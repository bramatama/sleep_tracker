import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/factors/factors_bloc.dart';
import '../../models/database/database.dart';
import '../widgets/add_factor_dialog.dart';
import '../widgets/edit_factor_dialog.dart';

class EditFactorsPage extends StatelessWidget {
  const EditFactorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<FactorsBloc>(context),
      child: const EditFactorsView(),
    );
  }
}

class EditFactorsView extends StatelessWidget {
  const EditFactorsView({super.key});

  // -- FIX: Mengisi body fungsi yang kosong --
  void _showAddFactorDialog(BuildContext context) async {
    final newFactorData = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return const AddFactorDialog();
      },
    );

    if (newFactorData != null && newFactorData.isNotEmpty) {
      if (!context.mounted) return; // FIX: Menambahkan mounted check
      context.read<FactorsBloc>().add(
        AddFactor(newFactorData['name']!, newFactorData['icon']!),
      );
    }
  }

  void _showEditFactorDialog(BuildContext context, Factor factorToEdit) async {
    final updatedFactor = await showDialog<FactorsCompanion>(
      context: context,
      builder: (_) => EditFactorDialog(initialFactor: factorToEdit),
    );

    if (updatedFactor != null) {
      if (!context.mounted) return; // FIX: Menambahkan mounted check
      context.read<FactorsBloc>().add(EditFactor(updatedFactor));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Faktor')),
      body: BlocBuilder<FactorsBloc, FactorsState>(
        builder: (context, state) {
          if (state is FactorsLoading || state is FactorsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FactorsLoaded) {
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
                  trailing: factor.isDefault
                      ? null
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () =>
                                  _showEditFactorDialog(context, factor),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                context.read<FactorsBloc>().add(
                                  DeleteFactor(factor.id),
                                );
                              },
                            ),
                          ],
                        ),
                );
              },
            );
          }
          return const Center(child: Text("Terjadi kesalahan."));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddFactorDialog(context),
        tooltip: 'Tambah Faktor',
        child: const Icon(Icons.add),
      ),
    );
  }
}
