import 'package:flutter/material.dart';
import '../../models/database/database.dart'; // Ganti ke model Drift

class FactorChip extends StatelessWidget {
  final Factor factor;
  const FactorChip({super.key, required this.factor});

  @override
  Widget build(BuildContext context) {
    return Chip(avatar: Text(factor.icon), label: Text(factor.name));
  }
}
