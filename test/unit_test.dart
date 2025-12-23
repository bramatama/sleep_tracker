import 'package:flutter_test/flutter_test.dart';
import '../lib/src/utils/duration_formatter.dart';
import '../lib/src/utils/analysis_insight.dart';

void main() {
  group('Duration Formatter', () {
    test('Format 1.5 jam', () {
      expect(formatDuration(1.5), '1j 30m');
    });

    test('Format 2.0 jam', () {
      expect(formatDuration(2.0), '2j 0m');
    });
  });

  group('Analysis Insight', () {
    test('Insight lebih lama', () {
      final result = buildInsight(avgWith: 8.0, avgWithout: 6.5);
      expect(result, 'Tidur Anda 1j 30m lebih lama.');
    });

    test('Insight lebih singkat', () {
      final result = buildInsight(avgWith: 5.0, avgWithout: 6.0);
      expect(result, 'Tidur Anda 1j 0m lebih singkat.');
    });
  });
}
