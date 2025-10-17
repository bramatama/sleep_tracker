import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/dashboard/dashboard_bloc.dart';
import '../../models/repositories/sleep_repository.dart';
import '../../utils/service_locator.dart';
import '../widgets/factor_chip.dart';
import '../widgets/summary_card.dart';
import '../widgets/weekly_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(sl<SleepRepository>()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selamat Pagi!'), // Nama bisa ditambahkan nanti
        centerTitle: false,
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state.lastSession == null) {
            return const Center(
              child: Text("Belum ada data tidur. Mulai sesi pertamamu!"),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tidur Terakhir Anda",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                SummaryCard(
                  session: state.lastSession!.session,
                  onTap: () => context.go('/analysis'),
                ),
                const SizedBox(height: 24),
                Text(
                  "Tren Mingguan",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                WeeklyChart(data: state.weeklyData),
                const SizedBox(height: 24),
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
                if (state.lastSession!.factors.isEmpty)
                  const Text("Tidak ada faktor yang dicatat.")
                else
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: state.lastSession!.factors
                        .map((factor) => FactorChip(factor: factor))
                        .toList(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
