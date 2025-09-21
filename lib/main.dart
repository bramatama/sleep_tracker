import 'package:flutter/material.dart';
import 'package:sleep_tracker/src/services/storage_service.dart';
import 'package:sleep_tracker/src/utils/app_router.dart';

void main() async {
  // Pastikan Flutter siap sebelum menjalankan kode async
  WidgetsFlutterBinding.ensureInitialized();

  // Cek apakah nama pengguna sudah ada
  final storageService = StorageService();
  final userName = await storageService.getUserName();

  runApp(const MyApp(hasSeenOnboarding: false));
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;
  const MyApp({super.key, required this.hasSeenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sleep Tracker',
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
      // Gunakan router yang sudah kita buat
      routerConfig: AppRouter(hasSeenOnboarding: hasSeenOnboarding).router,
    );
  }
}
