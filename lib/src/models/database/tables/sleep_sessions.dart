import 'package:drift/drift.dart';
import 'users.dart';

@DataClassName('SleepSession')
class SleepSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().named('user_id').references(Users, #id)();

  DateTimeColumn get startedAt => dateTime().named('started_at')();
  DateTimeColumn get endedAt => dateTime().named('ended_at').nullable()();
  IntColumn get durationInMinutes =>
      integer().named('duration_in_minutes').nullable()();
  IntColumn get qualityRating => integer().named('quality_rating').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
