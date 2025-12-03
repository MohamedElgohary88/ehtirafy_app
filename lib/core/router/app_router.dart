import 'package:go_router/go_router.dart';
import 'package:ehtirafy_app/features/shared/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/screens/login_screen.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/screens/signup_screen.dart';
import 'package:ehtirafy_app/features/client/home/presentation/pages/client_home_screen.dart';
import 'package:ehtirafy_app/features/client/home/presentation/pages/client_main_layout.dart';
import 'package:ehtirafy_app/features/client/home/presentation/pages/notifications_screen.dart';
import 'package:ehtirafy_app/features/client/home/presentation/pages/search_screen.dart';
import 'package:ehtirafy_app/features/client/messages/presentation/pages/messages_screen.dart';
import 'package:ehtirafy_app/features/client/profile/presentation/pages/client_profile_screen.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/screens/otp_screen.dart';
import 'package:ehtirafy_app/features/shared/auth/presentation/screens/role_selection_screen.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/pages/freelancer_profile_screen.dart';
import 'package:ehtirafy_app/features/booking/presentation/screens/request_booking_screen.dart';
import 'package:ehtirafy_app/features/booking/presentation/screens/booking_success_screen.dart';
import 'package:ehtirafy_app/features/client/requests/presentation/pages/my_requests_screen.dart';

/// GoRouter configuration for the app
final appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    // Onboarding screen - entry point
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    // Auth routes
    GoRoute(
      path: '/auth/signup',
      builder: (context, state) => const SignupScreen(),
    ),
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

    // Shell Route for Persistent Bottom Navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ClientMainLayout(navigationShell: navigationShell);
      },
      branches: [
        // Tab 0: Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ClientProfileScreen(),
            ),
          ],
        ),
        // Tab 1: Messages
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/messages',
              builder: (context, state) => const MessagesScreen(),
            ),
          ],
        ),
        // Tab 2: My Requests
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/my-requests',
              builder: (context, state) => const MyRequestsScreen(),
            ),
          ],
        ),
        // Tab 3: Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const ClientHomeContent(),
            ),
          ],
        ),
      ],
    ),

    // Other routes
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
    GoRoute(
      path: '/freelancer/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return FreelancerProfileScreen(freelancerId: id);
      },
    ),
    GoRoute(
      path: '/booking/request',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return RequestBookingScreen(
          freelancerId: extra['freelancerId'],
          freelancerName: extra['freelancerName'],
          serviceName: extra['serviceName'],
          price: extra['price'],
        );
      },
    ),
    GoRoute(
      path: '/booking/success',
      builder: (context, state) => const BookingSuccessScreen(),
    ),
  ],
);
