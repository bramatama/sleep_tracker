import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sleep_tracker/src/providers/onboarding.dart';
import 'package:sleep_tracker/src/services/storage_service.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menyediakan OnboardingCubit ke widget tree di bawahnya
    return BlocProvider(
      create: (context) => OnboardingCubit(StorageService()),
      child: const OnboardingView(),
    );
  }
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    return Scaffold(
      body: BlocListener<OnboardingCubit, OnboardingStatus>(
        // Listener ini akan bereaksi terhadap perubahan state
        listener: (context, state) {
          if (state == OnboardingStatus.success) {
            // Jika sukses, pindah ke halaman home
            context.go('/home');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Selamat Datang!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Siapakah nama Anda? Ini akan membantu kami mempersonalisasi pengalaman Anda.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Masukkan nama Anda',
                  border: OutlineInputBorder(),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Builder ini akan membangun ulang UI berdasarkan state
              BlocBuilder<OnboardingCubit, OnboardingStatus>(
                builder: (context, state) {
                  if (state == OnboardingStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      // Panggil fungsi di cubit saat tombol ditekan
                      context.read<OnboardingCubit>().saveUserNameAndContinue(
                        nameController.text,
                      );
                    },
                    child: const Text('Simpan & Lanjutkan'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
