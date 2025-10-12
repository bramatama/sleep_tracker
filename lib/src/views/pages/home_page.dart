import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/dummy_data.dart';
import '../widgets/factor_chip.dart';
import '../widgets/summary_card.dart';
import '../widgets/weekly_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Pagi, ${dummyUser.name}!'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartu Ringkasan Tidur Terakhir
            Text(
              "Tidur Terakhir Anda",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            SummaryCard(
              session: lastSleepSession,
              onTap: () => context.go('/analysis'),
            ),
            const SizedBox(height: 24),

            // Tren Mingguan
            Text(
              "Tren Mingguan",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            WeeklyChart(data: weeklySleepData),
            const SizedBox(height: 24),

            // Faktor Terakhir Dicatat
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Faktor Terakhir",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () => context.go('/factors'),
                  child: const Text("Kelola Faktor"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: lastSleepSession.factors
                  .map((factor) => FactorChip(factor: factor))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
