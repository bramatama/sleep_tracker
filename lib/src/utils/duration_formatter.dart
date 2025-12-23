String formatDuration(double hours) {
  final int h = hours.floor();
  final int m = ((hours - h) * 60).round();
  return "${h}j ${m}m";
}
