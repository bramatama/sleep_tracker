import 'package:flutter/material.dart';

class WeeklyChart extends StatelessWidget {
  final List<double> data; // data durasi tidur 7 hari
  const WeeklyChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final days = ["S", "S", "R", "K", "J", "S", "M"];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(7, (index) {
            final value = data.length > index ? data[index] : 0.0;
            return Column(
              children: [
                Text(value.toStringAsFixed(1)),
                const SizedBox(height: 4),
                Container(
                  height: value * 10, // simple scaling
                  width: 20,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 4),
                Text(days[index]),
              ],
            );
          }),
        ),
      ),
    );
  }
}
