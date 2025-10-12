import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/dummy_data.dart';

class ActiveSleepSessionPage extends StatefulWidget {
  const ActiveSleepSessionPage({super.key});

  @override
  State<ActiveSleepSessionPage> createState() => _ActiveSleepSessionPageState();
}

class _ActiveSleepSessionPageState extends State<ActiveSleepSessionPage> {
  bool _isSessionActive = false;
  final Set<DummyFactor> _selectedFactors = {};

  void _startSession() {
    setState(() {
      _isSessionActive = true;
    });
  }

  void _endSession() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSessionActive ? 'Sesi Tidur...' : 'Mulai Sesi Tidur'),
      ),
      body: _isSessionActive ? _buildActiveView() : _buildSetupView(),
    );
  }

  Widget _buildSetupView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Aktivitas apa yang Anda lakukan hari ini?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: allFactors.map((factor) {
              final isSelected = _selectedFactors.contains(factor);
              return FilterChip(
                label: Text('${factor.icon} ${factor.name}'),
                selected: isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      _selectedFactors.add(factor);
                    } else {
                      _selectedFactors.remove(factor);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: _startSession,
            child: const Text('Mulai Tidur'),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Selamat Tidur...",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              // Perkiraan waktu bangun (misal: 8 jam dari sekarang)
              "Perkiraan bangun sekitar pukul ${TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 8))).format(context)}",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: _endSession,
              child: const Text(
                'Saya Sudah Bangun',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
