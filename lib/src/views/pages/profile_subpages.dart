import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextFormField(
            initialValue: "Pengguna",
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: "pengguna@email.com",
            decoration: const InputDecoration(
              labelText: 'Alamat Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: 'Programmer', // <-- FIX: Mengganti value
            decoration: const InputDecoration(
              labelText: 'Aktivitas Utama',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.work_outline),
            ),
            items:
                [
                      'Mahasiswa',
                      'Atlit',
                      'Driver Jarak Jauh',
                      'Petugas Medis',
                      'Programmer',
                    ]
                    .map(
                      (label) =>
                          DropdownMenuItem(value: label, child: Text(label)),
                    )
                    .toList(),
            onChanged: (value) {},
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Profil berhasil diperbarui!")),
              );
            },
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
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Fitur ekspor data akan tersedia di sini."),
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
