import 'package:flutter/material.dart';

class WeeklyChart extends StatelessWidget {
  final List<double> data; // data durasi tidur 7 hari
  const WeeklyChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    String getDayLabel(int weekday) {
      const labels = ['S', 'S', 'R', 'K', 'J', 'S', 'M']; // Senin - Minggu
      return labels[weekday - 1];
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 150),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (index) {
              final value = data.length > index ? data[index] : 0.0;
              // Hitung tanggal untuk kolom ini (index 0 = 6 hari lalu, index 6 = hari ini)
              final date = now.subtract(Duration(days: 6 - index));

              return Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      value.toStringAsFixed(1),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: value * 10 > 20 ? value * 10 : 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(getDayLabel(date.weekday)),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
