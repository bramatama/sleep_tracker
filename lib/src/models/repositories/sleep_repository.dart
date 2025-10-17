import 'package:drift/drift.dart';
import '../../utils/service_locator.dart';
import '../database/database.dart';

// Kelas ini akan menampung data gabungan dari SleepSession dan Factors-nya.
class SleepSessionWithFactors {
  final SleepSession session;
  final List<Factor> factors;

  SleepSessionWithFactors({required this.session, required this.factors});
}

// Kelas baru untuk menampung hasil analisis
class FactorAnalysisResult {
  final Factor factor;
  final double avgWith;
  final double avgWithout;
  final int countWith;

  FactorAnalysisResult({
    required this.factor,
    required this.avgWith,
    required this.avgWithout,
    required this.countWith,
  });
}

class SleepRepository {
  final AppDatabase _db = sl<AppDatabase>();

  // Memulai sesi tidur baru
  Future<int> startNewSession() {
    // Untuk saat ini, kita anggap hanya ada satu user dengan id = 1
    final session = SleepSessionsCompanion.insert(
      userId: 1,
      startedAt: DateTime.now(),
    );
    return _db.into(_db.sleepSessions).insert(session);
  }

  // Mengakhiri sesi tidur
  Future<void> endSession({
    required int sessionId,
    required int quality,
    required List<Factor> selectedFactors,
  }) async {
    final session = await (_db.select(
      _db.sleepSessions,
    )..where((s) => s.id.equals(sessionId))).getSingle();

    final duration = DateTime.now().difference(session.startedAt);

    // Update data sesi
    await (_db.update(
      _db.sleepSessions,
    )..where((s) => s.id.equals(sessionId))).write(
      SleepSessionsCompanion(
        endedAt: Value(DateTime.now()),
        qualityRating: Value(quality),
        durationInMinutes: Value(duration.inMinutes),
      ),
    );

    // Simpan faktor-faktor yang dipilih
    for (var factor in selectedFactors) {
      await _db
          .into(_db.sleepSessionFactors)
          .insert(
            SleepSessionFactorsCompanion.insert(
              sleepSessionId: sessionId,
              factorId: factor.id,
            ),
          );
    }
  }

  // Mendapatkan sesi tidur terakhir
  Stream<SleepSessionWithFactors?> watchLastSleepSession() {
    final query = _db.select(_db.sleepSessions)
      ..orderBy([(s) => OrderingTerm.desc(s.endedAt)])
      ..limit(1);

    return query.watchSingleOrNull().asyncMap((session) async {
      if (session == null) return null;

      final factorsQuery = _db.select(_db.sleepSessionFactors).join([
        innerJoin(
          _db.factors,
          _db.factors.id.equalsExp(_db.sleepSessionFactors.factorId),
        ),
      ])..where(_db.sleepSessionFactors.sleepSessionId.equals(session.id));

      final factorRows = await factorsQuery.get();
      final factors = factorRows
          .map((row) => row.readTable(_db.factors))
          .toList();

      return SleepSessionWithFactors(session: session, factors: factors);
    });
  }

  // Mendapatkan data tidur untuk 7 hari terakhir
  Stream<List<double>> watchWeeklySleepDurations() {
    // Logika ini akan mengambil data dan mengagregasinya per hari
    // Untuk sementara, kita kembalikan stream data statis
    return Stream.value([6.5, 7.0, 8.0, 6.0, 7.5, 9.0, 7.2]);
  }

  // Metode baru untuk analisis faktor
  Future<List<FactorAnalysisResult>> analyzeFactors() async {
    // Ini adalah logika yang disederhanakan.
    // Analisis nyata memerlukan query SQL yang lebih kompleks.
    final allSessions = await _db.select(_db.sleepSessions).get();
    final allFactors = await _db.select(_db.factors).get();
    List<FactorAnalysisResult> results = [];

    // Jika tidak ada data, kembalikan list kosong
    if (allSessions.isEmpty) return [];

    for (var factor in allFactors) {
      // Dummy logic for demonstration
      results.add(
        FactorAnalysisResult(
          factor: factor,
          avgWith: (factor.name == "Minum Kopi" ? 380 : 460) / 60.0,
          avgWithout: 440 / 60.0,
          countWith: factor.name == "Minum Kopi" ? 5 : 8,
        ),
      );
    }

    return results;
  }
}
