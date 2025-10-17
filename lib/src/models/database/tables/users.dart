import 'package:drift/drift.dart';

// Tabel untuk menyimpan data pengguna.
@DataClassName('User')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text().unique()();
  TextColumn get password => text()();
  TextColumn get primaryActivity =>
      text().named('primary_activity').nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}
