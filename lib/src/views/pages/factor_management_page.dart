import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/factors/factors_bloc.dart';
// import '../../models/database/database.dart';

class FactorManagementPage extends StatelessWidget {
  const FactorManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FactorsBloc()..add(LoadFactors()),
      child: const FactorManagementView(),
    );
  }
}

class FactorManagementView extends StatelessWidget {
  const FactorManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Faktor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: "Edit Faktor",
            onPressed: () => context.push('/factors/edit'),
          ),
        ],
      ),
      body: BlocBuilder<FactorsBloc, FactorsState>(
        builder: (context, state) {
          if (state is FactorsLoading || state is FactorsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FactorsLoaded) {
            if (state.factors.isEmpty) {
              return const Center(child: Text("Belum ada faktor."));
            }
            return ListView.builder(
              itemCount: state.factors.length,
              itemBuilder: (context, index) {
                final factor = state.factors[index];
                return ListTile(
                  leading: Text(
                    factor.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(factor.name),
                  subtitle: Text(
                    factor.isDefault ? "Faktor bawaan" : "Faktor kustom",
                  ),
                );
              },
            );
          }
          return const Center(child: Text("Terjadi kesalahan."));
        },
      ),
    );
  }
}
