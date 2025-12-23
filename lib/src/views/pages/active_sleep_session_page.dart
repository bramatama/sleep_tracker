import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/sleep_session/sleep_session_cubit.dart';
// import '../../models/database/database.dart';
import '../../models/repositories/factor_repository.dart';
import '../../models/repositories/sleep_repository.dart';
import '../../utils/service_locator.dart';

class ActiveSleepSessionPage extends StatelessWidget {
  const ActiveSleepSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SleepSessionCubit(sl<SleepRepository>(), sl<FactorRepository>())
            ..loadFactors(),
      child: const ActiveSleepSessionView(),
    );
  }
}

class ActiveSleepSessionView extends StatefulWidget {
  const ActiveSleepSessionView({super.key});

  @override
  State<ActiveSleepSessionView> createState() => _ActiveSleepSessionViewState();
}

class _ActiveSleepSessionViewState extends State<ActiveSleepSessionView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  Timer? _timer;
  String _currentTime = "";

  @override
  void initState() {
    super.initState();
    // Animasi pulsing untuk ikon bulan
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    // Update jam setiap detik
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      final now = DateTime.now();
      setState(() {
        _currentTime =
            "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
      });
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SleepSessionCubit, SleepSessionState>(
      listener: (context, state) {
        if (state.status == SleepStatus.finished) {
          // Tampilkan dialog rating lalu pop
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => RatingDialog(
              onSubmit: (rating) {
                context.read<SleepSessionCubit>().endSession(rating);
                context.pop(); // Tutup dialog
                context.pop(); // Kembali ke halaman utama
              },
            ),
          );
        }
      },
      builder: (context, state) {
        final isSleeping = state.status == SleepStatus.active;
        return Scaffold(
          appBar: isSleeping
              ? null
              : AppBar(
                  title: const Text('Mulai Sesi Tidur'),
                  centerTitle: true,
                ),
          body: isSleeping
              ? _buildActiveView(context)
              : _buildSetupView(context, state),
        );
      },
    );
  }

  Widget _buildSetupView(BuildContext context, SleepSessionState state) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.bedtime, size: 64, color: Colors.indigo),
          const SizedBox(height: 16),
          Text(
            "Persiapan Tidur",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Pilih aktivitas yang mempengaruhi tidurmu hari ini:",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                alignment: WrapAlignment.center,
                children: state.allFactors.map((factor) {
                  final isSelected = state.selectedFactors.contains(factor);
                  return FilterChip(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    label: Text('${factor.icon} ${factor.name}'),
                    selected: isSelected,
                    checkmarkColor: Colors.white,
                    selectedColor: Colors.indigoAccent,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (_) =>
                        context.read<SleepSessionCubit>().toggleFactor(factor),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.nights_stay),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
            ),
            onPressed: () => context.read<SleepSessionCubit>().startSession(),
            label: const Text(
              'Mulai Tidur Sekarang',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Animasi Bulan
            ScaleTransition(
              scale: Tween(begin: 0.9, end: 1.1).animate(
                CurvedAnimation(
                  parent: _animController,
                  curve: Curves.easeInOut,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
                child: const Icon(
                  Icons.nights_stay,
                  size: 80,
                  color: Colors.amberAccent,
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Jam Digital
            Text(
              _currentTime,
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w200,
                color: Colors.white,
                letterSpacing: 4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "Selamat Tidur...",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white70,
                    letterSpacing: 1.5,
                  ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // Tombol Tahan untuk Bangun
            GestureDetector(
              onLongPress: () {
                // HapticFeedback.mediumImpact(); // Opsional: getaran
                context.read<SleepSessionCubit>().endSession(0);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber.shade700, Colors.amber.shade900],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.touch_app, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      'Tahan untuk Bangun',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// Dialog untuk rating
class RatingDialog extends StatefulWidget {
  final Function(int) onSubmit;
  const RatingDialog({super.key, required this.onSubmit});
  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 3;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Bagaimana kualitas tidurmu?"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return IconButton(
            icon: Icon(
              index < _rating ? Icons.star : Icons.star_border,
              color: Colors.amber,
            ),
            onPressed: () => setState(() => _rating = index + 1),
          );
        }),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => widget.onSubmit(_rating),
          child: const Text("Simpan"),
        ),
      ],
    );
  }
}
