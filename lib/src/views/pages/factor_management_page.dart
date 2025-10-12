import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/dummy_data.dart';

class FactorManagementPage extends StatelessWidget {
  const FactorManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Faktor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: "Edit Faktor",
            onPressed: () {
              context.push('/factors/edit');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: allFactors.length,
        itemBuilder: (context, index) {
          final factor = allFactors[index];
          return ListTile(
            leading: Text(factor.icon, style: const TextStyle(fontSize: 24)),
            title: Text(factor.name),
            subtitle: const Text("Faktor bawaan"),
          );
        },
      ),
    );
  }
}
