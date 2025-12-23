import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/users.dart';
import 'tables/factors.dart';
import 'tables/sleep_sessions.dart';
import 'tables/sleep_session_factors.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Users, Factors, SleepSessions, SleepSessionFactors])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();

      await batch((batch) {
        batch.insertAll(factors, [
          FactorsCompanion.insert(name: 'Minum Kopi', icon: '☕'),
          FactorsCompanion.insert(name: 'Olahraga', icon: '🏋️'),
          FactorsCompanion.insert(name: 'Makan Berat', icon: '🍔'),
          FactorsCompanion.insert(name: 'Stres', icon: '😥'),
          FactorsCompanion.insert(name: 'Layar HP', icon: '📱'),
        ]);
      });
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.addColumn(users, users.profilePicture);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
