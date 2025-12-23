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
                UserAccountsDrawerHeader(
                  accountName: Text(profile.name),
                  accountEmail: Text(profile.email),
                  currentAccountPicture: const CircleAvatar(
                    child: Icon(Icons.person, size: 50),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text('Edit Profil'),
                  onTap: () => context.push(
                    '/profile/edit',
                    extra: context.read<ProfileCubit>(),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Pengaturan Aplikasi'),
                  onTap: () => context.push('/profile/settings'),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red.shade400),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Colors.red.shade400),
                  ),
                  onTap: () {
                    // Logika logout
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fitur logout akan tersedia segera'),
                      ),
                    );
                  },
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
