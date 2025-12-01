import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/shared/onboarding/presentation/screens/onboarding_screen.dart';

/// GoRouter configuration for the app
final appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    // Onboarding screen - entry point
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    // Auth routes (placeholder - will be implemented later)
    GoRoute(
      path: '/auth/signup',
      builder: (context, state) => const Scaffold(body: SizedBox.shrink()),
    ),
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const Scaffold(body: SizedBox.shrink()),
    ),
  ],
);
