import 'package:flutter/material.dart';
import './src/utils/app_router.dart';
import './src/utils/service_locator.dart';
import './src/models/repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  // Initialize default user
  final userRepo = UserRepository();
  await userRepo.getOrCreateDefaultUser();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sleep Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      routerConfig: AppRouter().router,
    );
  }
}
