// widgets/factor_chip.dart
import 'package:flutter/material.dart';
import '../../models/dummy_data.dart';

class FactorChip extends StatelessWidget {
  final DummyFactor factor;
  const FactorChip({super.key, required this.factor});

  @override
  Widget build(BuildContext context) {
    return Chip(avatar: Text(factor.icon), label: Text(factor.name));
  }
}
