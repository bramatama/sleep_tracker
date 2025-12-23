import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/src/views/widgets/add_factor_dialog.dart';
import '../lib/src/views/widgets/summary_card.dart';
import '../lib/src/models/database/database.dart';

void main() {
  group('AddFactorDialog Widget Test', () {
    testWidgets('Menampilkan form dan tombol', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AddFactorDialog())),
      );

      expect(find.text('Tambah Faktor Baru'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Simpan'), findsOneWidget);
      expect(find.text('Batal'), findsOneWidget);
    });

    testWidgets('Submit valid mengembalikan data', (tester) async {
      dynamic result;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () async {
                  result = await showDialog(
                    context: context,
                    builder: (_) => const AddFactorDialog(),
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      // Buka dialog
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Isi form
      await tester.enterText(find.byType(TextFormField).at(0), 'Baca Buku');
      await tester.enterText(find.byType(TextFormField).at(1), '📖');

      // Submit
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      expect(result, isNotNull);
      expect(result['name'], 'Baca Buku');
      expect(result['icon'], '📖');
    });
  });
  group('SummaryCard Widget Test', () {
    testWidgets('Menampilkan data sesi tidur', (tester) async {
      final session = SleepSession(
        id: 1,
        userId: 1,
        durationInMinutes: 450, // 7j 30m
        qualityRating: 4,
        startedAt: DateTime(2025, 1, 1, 22, 0),
        endedAt: DateTime(2025, 1, 2, 5, 30),
      );

      bool tapped = false;

      await tester.pumpWidget(const MaterialApp(home: Scaffold()));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SummaryCard(session: session, onTap: () => tapped = true),
          ),
        ),
      );

      // Durasi
      expect(find.text('7j 30m'), findsOneWidget);

      // Kualitas
      expect(find.text('4/5 Kualitas'), findsOneWidget);

      // Icon jam (lebih stabil daripada string waktu)
      expect(find.byIcon(Icons.schedule), findsOneWidget);

      // CTA
      expect(find.text('Lihat Analisis Lengkap'), findsOneWidget);

      // Tap
      await tester.tap(find.byType(InkWell));
      expect(tapped, true);
    });
  });
}
