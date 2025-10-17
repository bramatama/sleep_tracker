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

class ActiveSleepSessionView extends StatelessWidget {
  const ActiveSleepSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SleepSessionCubit, SleepSessionState>(
      listener: (context, state) {
        if (state.status == SleepStatus.finished) {
          // Tampilkan dialog rating lalu pop
          showDialog(
            context: context,
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
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.status == SleepStatus.active
                  ? 'Sesi Tidur...'
                  : 'Mulai Sesi Tidur',
            ),
          ),
          body: state.status == SleepStatus.active
              ? _buildActiveView(context)
              : _buildSetupView(context, state),
        );
      },
    );
  }

  Widget _buildSetupView(BuildContext context, SleepSessionState state) {
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
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: state.allFactors.map((factor) {
                  final isSelected = state.selectedFactors.contains(factor);
                  return FilterChip(
                    label: Text('${factor.icon} ${factor.name}'),
                    selected: isSelected,
                    onSelected: (_) =>
                        context.read<SleepSessionCubit>().toggleFactor(factor),
                  );
                }).toList(),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () => context.read<SleepSessionCubit>().startSession(),
            child: const Text('Mulai Tidur'),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveView(BuildContext context) {
    // Tombol end session sekarang akan memicu listener untuk menampilkan dialog
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
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () => context.read<SleepSessionCubit>().endSession(
                0,
              ), // Rating akan diisi dari dialog
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
