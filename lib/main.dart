import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'package:ehtirafy_app/core/di/service_locator.dart';

void main() {
  // 1. Minimal initialization required for runApp
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Run immediately without awaiting anything else
  // This forces the native splash to dismiss as soon as possible
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
      // 4. Show loading screen immediately (Raw MaterialApp, no localization yet)
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFF1C1D18),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 180,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 24),
                const CircularProgressIndicator(color: Color(0xFFC8A44F)),
              ],
            ),
          ),
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
