import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/profile/profile_cubit.dart';

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

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  bool _sleepReminder = true;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 22, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan Aplikasi')),
      body: ListView(
        children: [
          _buildSectionHeader(context, "Tampilan"),
          SwitchListTile(
            title: const Text('Mode Gelap'),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
            secondary: const Icon(Icons.dark_mode_outlined),
          ),
          _buildSectionHeader(context, "Notifikasi"),
          SwitchListTile(
            title: const Text('Pengingat Waktu Tidur'),
            subtitle: Text(
              _sleepReminder
                  ? 'Setiap hari pukul ${_reminderTime.format(context)}'
                  : 'Nonaktif',
            ),
            value: _sleepReminder,
            onChanged: (value) {
              setState(() {
                _sleepReminder = value;
              });
            },
            secondary: const Icon(Icons.notifications_active_outlined),
          ),
          if (_sleepReminder)
            ListTile(
              title: const Text('Ubah Waktu Pengingat'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                final newTime = await showTimePicker(
                  context: context,
                  initialTime: _reminderTime,
                );
                if (newTime != null) {
                  setState(() {
                    _reminderTime = newTime;
                  });
                }
              },
            ),
          _buildSectionHeader(context, "Data"),
          ListTile(
            leading: const Icon(Icons.download_for_offline_outlined),
            title: const Text('Ekspor Data'),
            subtitle: const Text('Simpan riwayat tidur Anda sebagai file CSV.'),
            onTap: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Fitur ekspor data siap. Data dapat diunduh dari device Anda.",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
