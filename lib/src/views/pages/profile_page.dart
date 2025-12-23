import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/profile/profile_cubit.dart';
import '../../models/repositories/user_repository.dart';
import '../../utils/service_locator.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(sl<UserRepository>()),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil & Pengaturan')),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileLoaded) {
            final profile = state.profile;

            return ListView(
              children: [
                // Custom Header
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        profile.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        profile.email,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      if (profile.primaryActivity != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            profile.primaryActivity!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ListTile(
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text('Edit Profil'),
                  onTap: () => context.push(
                    '/profile/edit',
                    extra: context.read<ProfileCubit>(),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Riwayat Tidur'),
                  onTap: () => context.push('/profile/history'),
                ),
              ],
            );
          }

          if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<ProfileCubit>().resetError(),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('Status tidak dikenal'));
        },
      ),
    );
  }
}
