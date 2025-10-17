import 'package:flutter/material.dart';
import '../../models/database/database.dart'; // Ganti ke model Drift

class SummaryCard extends StatelessWidget {
  final SleepSession session;
  final VoidCallback onTap;

  const SummaryCard({super.key, required this.session, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final duration = Duration(minutes: session.durationInMinutes ?? 0);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    return Card(
      elevation: 2.0,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${hours}j ${minutes}m",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    "${session.qualityRating ?? 'N/A'}/5 Kualitas",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.schedule, color: Colors.grey, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    "${TimeOfDay.fromDateTime(session.startedAt).format(context)} - ${session.endedAt != null ? TimeOfDay.fromDateTime(session.endedAt!).format(context) : '...'}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Lihat Analisis Lengkap"),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
