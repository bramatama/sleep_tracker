import 'package:go_router/go_router.dart';
import 'package:sleep_tracker/src/pages/home_page.dart';
import 'package:sleep_tracker/src/pages/onboarding_page.dart';

class AppRouter {
  final bool hasSeenOnboarding;

  AppRouter({required this.hasSeenOnboarding});

  late final GoRouter router = GoRouter(
    initialLocation: hasSeenOnboarding ? '/home' : '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ],
  );
}
