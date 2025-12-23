import 'package:drift/drift.dart'
    hide Column; // <-- FIX: Menghindari konflik nama
import 'package:flutter/material.dart';
import '../../models/database/database.dart';

class EditFactorDialog extends StatefulWidget {
  final Factor initialFactor;
  const EditFactorDialog({super.key, required this.initialFactor});

  @override
  State<EditFactorDialog> createState() => _EditFactorDialogState();
}

class _EditFactorDialogState extends State<EditFactorDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _iconController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialFactor.name);
    _iconController = TextEditingController(text: widget.initialFactor.icon);
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Buat FactorsCompanion untuk dikirim kembali
      final updatedFactor = widget.initialFactor
          .toCompanion(false)
          .copyWith(
            name: Value(_nameController.text),
            icon: Value(_iconController.text),
          );
      Navigator.of(context).pop(updatedFactor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Faktor'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Faktor'),
                validator: (v) {
                  // <-- FIX: Menambahkan kurung kurawal
                  if (v == null || v.trim().isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _iconController,
                decoration: const InputDecoration(labelText: 'Ikon (1 Emoji)'),
                validator: (v) {
                  // <-- FIX: Menambahkan kurung kurawal
                  if (v == null || v.trim().isEmpty) {
                    return 'Ikon tidak boleh kosong';
                  }
                  if (v.characters.length != 1) {
                    return 'Harap masukkan satu emoji saja';
                  }
                  return null;
                },
              ),
            ],
          ),
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
