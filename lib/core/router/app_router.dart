import 'package:go_router/go_router.dart';
import 'package:ehtirafy_app/features/shared/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/screens/login_screen.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/screens/signup_screen.dart';
import 'package:ehtirafy_app/features/client/home/presentation/pages/client_home_screen.dart';
import 'package:ehtirafy_app/features/client/home/presentation/pages/notifications_screen.dart';
import 'package:ehtirafy_app/features/client/home/presentation/pages/search_screen.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/screens/otp_screen.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/screens/role_selection_screen.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/pages/freelancer_profile_screen.dart';

/// GoRouter configuration for the app
final appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    // Onboarding screen - entry point
    GoRoute(
      path: '/onboarding',
      builder: (context, state) =>
          const FreelancerProfileScreen(freelancerId: '1'),
    ),
    // Auth routes (placeholder - will be implemented later)
    GoRoute(
      path: '/auth/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const ClientHomeScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/auth/otp',
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '';
        return OtpScreen(phone: phone);
      },
    ),
    GoRoute(
      path: '/auth/select-role',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: '/freelancer/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return FreelancerProfileScreen(freelancerId: id);
      },
    ),
  ],
);
