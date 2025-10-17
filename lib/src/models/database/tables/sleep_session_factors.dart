import 'package:drift/drift.dart';
import 'sleep_sessions.dart';
import 'factors.dart';

class SleepSessionFactors extends Table {
  IntColumn get sleepSessionId =>
      integer().named('sleep_session_id').references(SleepSessions, #id)();
  IntColumn get factorId =>
      integer().named('factor_id').references(Factors, #id)();

  @override
  Set<Column> get primaryKey => {sleepSessionId, factorId};
}
