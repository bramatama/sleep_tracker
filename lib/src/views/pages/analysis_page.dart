import 'package:flutter/material.dart';
import '../../models/dummy_data.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analisis Tidur Mendalam')),
      body: ListView(
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
                child: StatCard(title: "Rata-rata Durasi", value: "7j 21m"),
              ),
              SizedBox(width: 12),
              Expanded(
                child: StatCard(title: "Rata-rata Kualitas", value: "4.1 ★"),
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
          ...factorAnalysis.map(
            (analysis) => FactorAnalysisCard(
              factor: analysis["factor"] as DummyFactor,
              avgWith: analysis["avgWith"] as String,
              avgWithout: analysis["avgWithout"] as String,
              insight: analysis["insight"] as String,
              isNegative: analysis["isNegative"] as bool,
            ),
          ),
        ],
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
  final DummyFactor factor;
  final String avgWith, avgWithout, insight;
  final bool isNegative;

  const FactorAnalysisCard({
    super.key,
    required this.factor,
    required this.avgWith,
    required this.avgWithout,
    required this.insight,
    required this.isNegative,
  });

  @override
  Widget build(BuildContext context) {
    final color = isNegative ? Colors.red.shade300 : Colors.green.shade300;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${factor.icon} ${factor.name}",
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
                      avgWith,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Tanpa Faktor"),
                    Text(
                      avgWithout,
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
