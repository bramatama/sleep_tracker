import 'package:drift/drift.dart';
import 'dart:async';
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
  // Stream controller untuk memberi tahu kapan sesi selesai dan analisis perlu dijalankan ulang.
  final _sessionCompletedController = StreamController<void>.broadcast();

  // Stream yang bisa didengarkan oleh bagian lain dari aplikasi (misal: AnalysisBloc)
  Stream<void> get onSessionCompleted => _sessionCompletedController.stream;

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
    await _db.transaction(() async {
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

      // Hapus faktor lama jika ada (untuk menghindari duplikasi jika endSession dipanggil ulang)
      await (_db.delete(
        _db.sleepSessionFactors,
      )..where((t) => t.sleepSessionId.equals(sessionId))).go();

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

      // Memberi tahu listener bahwa sesi telah selesai
      _sessionCompletedController.add(null);
    });
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

  // Mendapatkan semua riwayat tidur (Stream) untuk halaman History
  Stream<List<SleepSessionWithFactors>> watchAllSleepSessions() {
    return (_db.select(
      _db.sleepSessions,
    )..orderBy([(s) => OrderingTerm.desc(s.startedAt)])).watch().asyncMap((
      sessions,
    ) async {
      List<SleepSessionWithFactors> result = [];
      for (var session in sessions) {
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
        result.add(SleepSessionWithFactors(session: session, factors: factors));
      }
      return result;
    });
  }

  // Mendapatkan data tidur untuk 7 hari terakhir dengan perhitungan dari database
  Stream<List<double>> watchWeeklySleepDurations() {
    return _db.select(_db.sleepSessions).watch().asyncMap((sessions) async {
      final now = DateTime.now();
      final sevenDaysAgo = now.subtract(const Duration(days: 7));

      // Kelompokkan sesi tidur per hari
      final Map<String, List<SleepSession>> sessionsByDay = {};

      for (var session in sessions) {
        if (session.endedAt != null &&
            session.endedAt!.isAfter(sevenDaysAgo) &&
            session.endedAt!.isBefore(now.add(const Duration(days: 1)))) {
          final dayKey =
              "${session.endedAt!.year}-${session.endedAt!.month.toString().padLeft(2, '0')}-${session.endedAt!.day.toString().padLeft(2, '0')}";
          sessionsByDay.putIfAbsent(dayKey, () => []).add(session);
        }
      }

      final List<double> weeklyData = [];
      for (int i = 6; i >= 0; i--) {
        final date = now.subtract(Duration(days: i));
        final dayKey =
            "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

        if (sessionsByDay.containsKey(dayKey)) {
          final daySessions = sessionsByDay[dayKey]!;
          final avgDuration =
              daySessions
                  .where((s) => s.durationInMinutes != null)
                  .map((s) => s.durationInMinutes! / 60.0)
                  .fold(0.0, (a, b) => a + b) /
              daySessions.length;
          weeklyData.add(avgDuration);
        } else {
          weeklyData.add(0.0); // Tidak ada data untuk hari tersebut
        }
      }

      return weeklyData;
    });
  }

  // Metode baru untuk analisis faktor
  Future<List<FactorAnalysisResult>> analyzeFactors() async {
    // 1. Ambil semua faktor dan semua sesi yang sudah selesai (ada durasi)
    final allFactors = await _db.select(_db.factors).get();
    final allSessions = await (_db.select(
      _db.sleepSessions,
    )..where((s) => s.durationInMinutes.isNotNull())).get();

    List<FactorAnalysisResult> results = [];

    if (allSessions.isEmpty) return [];

    // 2. Ambil data relasi (junction table) untuk mengetahui sesi mana punya faktor apa
    final sessionFactors = await _db.select(_db.sleepSessionFactors).get();

    // Map: SessionID -> Set of FactorIDs (untuk pencarian cepat)
    final sessionFactorMap = <int, Set<int>>{};
    for (var sf in sessionFactors) {
      sessionFactorMap
          .putIfAbsent(sf.sleepSessionId, () => {})
          .add(sf.factorId);
    }

    for (var factor in allFactors) {
      // 3. Pisahkan sesi menjadi dua grup: dengan faktor & tanpa faktor
      final sessionsWith = <SleepSession>[];
      final sessionsWithout = <SleepSession>[];

      for (var session in allSessions) {
        final factorsInSession = sessionFactorMap[session.id] ?? {};
        if (factorsInSession.contains(factor.id)) {
          sessionsWith.add(session);
        } else {
          sessionsWithout.add(session);
        }
      }

      // 4. Hitung rata-rata durasi (dalam jam)
      double calculateAvg(List<SleepSession> sessions) {
        if (sessions.isEmpty) return 0.0;
        final totalMinutes = sessions.fold<int>(
          0,
          (sum, s) => sum + (s.durationInMinutes ?? 0),
        );
        return (totalMinutes / sessions.length) / 60.0;
      }

      // Hanya tambahkan hasil jika faktor ini pernah digunakan setidaknya sekali
      if (sessionsWith.isNotEmpty) {
        results.add(
          FactorAnalysisResult(
            factor: factor,
            avgWith: calculateAvg(sessionsWith),
            avgWithout: calculateAvg(sessionsWithout),
            countWith: sessionsWith.length,
          ),
        );
      }
    }

    // Urutkan berdasarkan dampak terbesar (selisih durasi)
    results.sort((a, b) {
      final diffA = (a.avgWith - a.avgWithout).abs();
      final diffB = (b.avgWith - b.avgWithout).abs();
      return diffB.compareTo(diffA);
    });

    return results;
  }

  // Mendapatkan statistik tidur bulan ini (Rata-rata durasi & kualitas)
  Future<Map<String, dynamic>> getMonthlyStats() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);

    final sessions =
        await (_db.select(_db.sleepSessions)
              ..where((s) => s.endedAt.isBiggerOrEqualValue(startOfMonth))
              ..where((s) => s.durationInMinutes.isNotNull()))
            .get();

    if (sessions.isEmpty) {
      return {'avgDuration': 0, 'avgQuality': 0.0};
    }

    final totalDuration = sessions.fold<int>(
      0,
      (sum, s) => sum + (s.durationInMinutes ?? 0),
    );

    final sessionsWithQuality = sessions.where((s) => s.qualityRating != null);
    final totalQuality = sessionsWithQuality.fold<int>(
      0,
      (sum, s) => sum + (s.qualityRating!),
    );

    return {
      'avgDuration': totalDuration ~/ sessions.length, // dalam menit
      'avgQuality': sessionsWithQuality.isEmpty
          ? 0.0
          : totalQuality / sessionsWithQuality.length,
    };
  }

  // Export sleep data to CSV format
  Future<String> exportDataAsCSV() async {
    final allSessions = await _db.select(_db.sleepSessions).get();

    if (allSessions.isEmpty) {
      return 'Tanggal Mulai,Tanggal Selesai,Durasi (Menit),Rating Kualitas\n';
    }

    // Build CSV header
    StringBuffer csv = StringBuffer();
    csv.writeln('Tanggal Mulai,Tanggal Selesai,Durasi (Menit),Rating Kualitas');

    // Add data rows
    for (var session in allSessions) {
      final startDate = session.startedAt.toString();
      final endDate = session.endedAt?.toString() ?? 'Belum selesai';
      final duration = session.durationInMinutes ?? 0;
      final rating = session.qualityRating ?? 0;

      csv.writeln('$startDate,$endDate,$duration,$rating');
    }

    return csv.toString();
  }

  // Get all sleep data with factors for export
  Future<List<Map<String, dynamic>>> getAllSleepDataWithFactors() async {
    final allSessions = await _db.select(_db.sleepSessions).get();
    List<Map<String, dynamic>> result = [];

    for (var session in allSessions) {
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

      result.add({'session': session, 'factors': factors});
    }

    return result;
  }
}
