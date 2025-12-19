import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'package:ehtirafy_app/core/di/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ehtirafy_app/firebase_options.dart';
import 'package:ehtirafy_app/core/notifications/background_handler.dart';
import 'package:ehtirafy_app/core/notifications/notification_service.dart';

Future<void> main() async {
  // ANR FIX: Do NOT use FlutterNativeSplash.preserve() on Android 12+
  // The native splash dismisses automatically when Flutter renders.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register Background Handler
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  // Initialize Notification Service
  await NotificationService().initialize();

  // Run app
  runApp(const AppBootstrap());
}

/// Bootstrap widget that handles ALL async initialization
class AppBootstrap extends StatefulWidget {
  const AppBootstrap({super.key});

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  bool _isInitialized = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      await EasyLocalization.ensureInitialized();
      await setupLocator();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      // Primitive error screen (no localization)
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFF1C1D18),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Initialization Error:\n$_error',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }

    if (!_isInitialized) {
      // App is initializing. Native splash is still visible.
      // We return a simple container that matches splash background color
      // just in case of a frame gap.
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFF1C1D18), // Same as splash background
        ),
      );
    }

    // 5. App is ready! logical tree: EasyLocalization -> ScreenUtil -> MaterialApp
    return EasyLocalization(
      supportedLocales: const [Locale('ar', 'SA')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar', 'SA'),
      startLocale: const Locale('ar', 'SA'),
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'app_name'.tr(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: appRouter,
        );
      },
    );
  }
}
