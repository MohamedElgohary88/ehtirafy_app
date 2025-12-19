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

import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  // 1. Keep native splash screen up until app is ready
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase (Critical ordered step 1)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register Background Handler (Critical ordered step 2)
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  // Initialize Notification Service (Critical ordered step 3)
  await NotificationService().initialize();

  // 2. Run app
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
      // 3. Initialize everything here while showing the loading screen
      await EasyLocalization.ensureInitialized();
      await setupLocator();

      // Initialization done, allow UI to update then remove splash
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        // We are ready, let the first frame of MyApp render, then remove splash.
        // Doing it immediately here is also fine usually.
        FlutterNativeSplash.remove();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
        // If error, also remove splash to show error
        FlutterNativeSplash.remove();
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
