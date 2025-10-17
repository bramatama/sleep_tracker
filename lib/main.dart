import 'package:flutter/material.dart';
import './src/utils/app_router.dart';
import './src/utils/service_locator.dart'; // Impor file baru

void main() {
  // Panggil setupLocator sebelum menjalankan aplikasi
  setupLocator();

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
