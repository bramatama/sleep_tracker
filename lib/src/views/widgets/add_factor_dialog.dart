import 'package:flutter/material.dart';
import '../../models/dummy_data.dart';

class AddFactorDialog extends StatefulWidget {
  const AddFactorDialog({super.key});

  @override
  State<AddFactorDialog> createState() => _AddFactorDialogState();
}

class _AddFactorDialogState extends State<AddFactorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _iconController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newFactor = DummyFactor(
        name: _nameController.text,
        icon: _iconController.text,
      );
      Navigator.of(context).pop(newFactor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah Faktor Baru'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Faktor',
                hintText: 'e.g., Baca Buku',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _iconController,
              decoration: const InputDecoration(
                labelText: 'Ikon (Cukup 1 Emoji)',
                hintText: 'e.g., 📖',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Ikon tidak boleh kosong';
                }
                if (value.characters.length != 1) {
                  return 'Harap masukkan satu emoji saja';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Simpan')),
      ],
    );
  }
}
