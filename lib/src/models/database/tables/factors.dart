import 'package:drift/drift.dart';
import 'users.dart';

// Tabel untuk menyimpan daftar semua faktor gaya hidup.
@DataClassName('Factor')
class Factors extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get icon => text()();
  BoolColumn get isDefault =>
      boolean().named('is_default').withDefault(const Constant(true))();
  IntColumn get userId =>
      integer().named('user_id').nullable().references(Users, #id)();
  
  @override
  Set<Column> get primaryKey => {id};
}
