import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/analysis/analysis_bloc.dart';
// import '../../models/database/database.dart';
import '../../models/repositories/sleep_repository.dart';
import '../../utils/service_locator.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AnalysisBloc(sl<SleepRepository>())..add(FetchAnalysisData()),
      child: const AnalysisView(),
    );
  }
}

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analisis Tidur Mendalam')),
      body: BlocBuilder<AnalysisBloc, AnalysisState>(
        builder: (context, state) {
          if (state is AnalysisLoading || state is AnalysisInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AnalysisLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Statistik Utama
                Text(
                  "Statistik Utama (Bulan Ini)",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        title: "Rata-rata Durasi",
                        value: "7j 21m",
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: StatCard(
                        title: "Rata-rata Kualitas",
                        value: "4.1 ★",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Analisis Korelasi Faktor
                Text(
                  "Pengaruh Aktivitas",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                if (state.analysisResults.isEmpty)
                  const Center(child: Text("Data tidak cukup untuk analisis."))
                else
                  ...state.analysisResults.map(
                    (result) => FactorAnalysisCard(result: result),
                  ),
              ],
            );
          }
          return const Center(child: Text("Gagal memuat data analisis."));
        },
      ),
    );
  }
}

// Widget Bantuan
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  const StatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}

class FactorAnalysisCard extends StatelessWidget {
  final FactorAnalysisResult result;

  const FactorAnalysisCard({super.key, required this.result});

  // Helper untuk format durasi dari jam (double) ke "Xj Ym"
  String _formatDuration(double hours) {
    final int h = hours.floor();
    final int m = ((hours - h) * 60).round();
    return "${h}j ${m}m";
  }

  @override
  Widget build(BuildContext context) {
    final avgWithStr = _formatDuration(result.avgWith);
    final avgWithoutStr = _formatDuration(result.avgWithout);
    final difference = (result.avgWith - result.avgWithout).abs();
    final insight =
        "Tidur Anda ${_formatDuration(difference)} ${result.avgWith > result.avgWithout ? 'lebih lama' : 'lebih singkat'}.";
    final isNegative = result.avgWith < result.avgWithout;

    final color = isNegative ? Colors.red.shade300 : Colors.green.shade300;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${result.factor.icon} ${result.factor.name}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text("Dengan Faktor"),
                    Text(
                      avgWithStr,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Tanpa Faktor"),
                    Text(
                      avgWithoutStr,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                insight,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
