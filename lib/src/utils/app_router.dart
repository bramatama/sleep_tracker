import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../controllers/factors/factors_bloc.dart';
import '../controllers/profile/profile_cubit.dart';
import '../views/pages/main_wrapper_page.dart';
import '../views/pages/home_page.dart';
import '../views/pages/analysis_page.dart';
import '../views/pages/profile_page.dart';
import '../views/pages/active_sleep_session_page.dart';
import '../views/pages/splash_page.dart';
import '../views/pages/edit_factors_page.dart';
import '../views/pages/profile_subpages.dart';
import '../models/repositories/user_repository.dart';
// import '../models/repositories/factor_repository.dart';
import '../utils/service_locator.dart';

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
        builder: (context, state) {
          final bloc = state.extra;
          if (bloc is FactorsBloc) {
            return BlocProvider.value(
              value: bloc,
              child: const EditFactorsPage(),
            );
          }
          return BlocProvider(
            create: (context) => FactorsBloc(),
            child: const EditFactorsPage(),
          );
        },
      ),
      GoRoute(
        path: '/profile/edit',
        builder: (context, state) {
          final bloc = state.extra as ProfileCubit?;
          if (bloc != null) {
            return BlocProvider.value(
              value: bloc,
              child: const EditProfilePage(),
            );
          }
          return BlocProvider(
            create: (context) => ProfileCubit(sl<UserRepository>()),
            child: const EditProfilePage(),
          );
        },
      ),
      GoRoute(
        path: '/profile/history',
        builder: (context, state) => const SleepHistoryPage(),
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
                builder: (context, state) => BlocProvider(
                  create: (context) => FactorsBloc(),
                  child: const EditFactorsPage(),
                ),
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
