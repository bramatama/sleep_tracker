import 'package:flutter/material.dart';
import '../../models/dummy_data.dart';
import '../widgets/add_factor_dialog.dart';

class EditFactorsPage extends StatefulWidget {
  const EditFactorsPage({super.key});

  @override
  State<EditFactorsPage> createState() => _EditFactorsPageState();
}

class _EditFactorsPageState extends State<EditFactorsPage> {
  // Dalam aplikasi nyata, ini akan memanipulasi data dari database
  final List<DummyFactor> _factors = List.from(allFactors);

  // Fungsi untuk menampilkan dialog tambah faktor
  void _showAddFactorDialog() async {
    final newFactor = await showDialog<DummyFactor>(
      context: context,
      builder: (BuildContext context) {
        return const AddFactorDialog();
      },
    );

    // Jika pengguna menyimpan faktor baru (dialog tidak mengembalikan null)
    if (newFactor != null) {
      setState(() {
        _factors.add(newFactor);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Faktor '${newFactor.name}' berhasil ditambahkan."),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Faktor')),
      body: ListView.builder(
        itemCount: _factors.length,
        itemBuilder: (context, index) {
          final factor = _factors[index];
          return ListTile(
            leading: Text(factor.icon, style: const TextStyle(fontSize: 24)),
            title: Text(factor.name),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () {
                final removedFactorName = _factors[index].name;
                setState(() {
                  _factors.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("'$removedFactorName' dihapus.")),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFactorDialog, // Memanggil fungsi dialog
        tooltip: 'Tambah Faktor',
        child: const Icon(Icons.add),
      ),
    );
  }
}
