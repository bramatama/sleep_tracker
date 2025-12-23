import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/profile/profile_cubit.dart';
import '../../models/repositories/sleep_repository.dart';
import '../../utils/service_locator.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  String? _selectedActivity;

  final List<String> _activities = [
    'Mahasiswa',
    'Atlit',
    'Driver Jarak Jauh',
    'Petugas Medis',
    'Programmer',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();

    // Initialize with current profile data
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is ProfileLoaded) {
      _nameController.text = profileState.profile.name;
      _emailController.text = profileState.profile.email;
      _selectedActivity = profileState.profile.primaryActivity;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan email tidak boleh kosong')),
      );
      return;
    }

    context.read<ProfileCubit>().updateProfile(
      name: _nameController.text,
      email: _emailController.text,
      primaryActivity: _selectedActivity,
    );

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profil berhasil diperbarui!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Alamat Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedActivity,
            decoration: const InputDecoration(
              labelText: 'Aktivitas Utama',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.work_outline),
            ),
            items: _activities
                .map(
                  (label) => DropdownMenuItem(value: label, child: Text(label)),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedActivity = value;
              });
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: _saveChanges,
            child: const Text('Simpan Perubahan'),
          ),
        ],
      ),
    );
  }
}

class SleepHistoryPage extends StatelessWidget {
  const SleepHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Tidur')),
      body: StreamBuilder<List<SleepSessionWithFactors>>(
        stream: sl<SleepRepository>().watchAllSleepSessions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada data tidur.\nMulai tidur sekarang untuk merekam data!',
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final item = data[index];
              final session = item.session;
              final duration = session.durationInMinutes ?? 0;
              final hours = duration ~/ 60;
              final minutes = duration % 60;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${session.startedAt.day}/${session.startedAt.month}/${session.startedAt.year}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "${hours}j ${minutes}m",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text("Kualitas: ${session.qualityRating ?? '-'}/5"),
                          const Spacer(),
                          ...item.factors.map(
                            (f) => Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                f.icon,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
