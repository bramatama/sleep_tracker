import 'package:go_router/go_router.dart';
import '../views/pages/main_wrapper_page.dart';
import '../views/pages/home_page.dart';
import '../views/pages/analysis_page.dart';
import '../views/pages/factor_management_page.dart';
import '../views/pages/profile_page.dart';
import '../views/pages/active_sleep_session_page.dart';
import '../views/pages/splash_page.dart';
import '../views/pages/edit_factors_page.dart';
import '../views/pages/profile_subpages.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/splash',

    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(
        path: '/active-session',
        builder: (context, state) => const ActiveSleepSessionPage(),
      ),
      GoRoute(
        path: '/factors/edit',
        builder: (context, state) => const EditFactorsPage(),
      ),
      GoRoute(
        path: '/profile/edit',
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: '/profile/settings',
        builder: (context, state) => const SettingsPage(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapperPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/analysis',
                builder: (context, state) => const AnalysisPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/factors',
                builder: (context, state) => const FactorManagementPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
