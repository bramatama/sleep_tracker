import 'duration_formatter.dart';

String buildInsight({required double avgWith, required double avgWithout}) {
  final diff = (avgWith - avgWithout).abs();
  final duration = formatDuration(diff);
  final status = avgWith > avgWithout ? 'lebih lama' : 'lebih singkat';

  return "Tidur Anda $duration $status.";
}
