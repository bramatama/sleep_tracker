import '../database/database.dart';
import '../../utils/service_locator.dart';
import 'package:drift/drift.dart';

class FactorRepository {
  final AppDatabase _database = sl<AppDatabase>();

  // Mengambil semua faktor dari database
  Stream<List<Factor>> watchAllFactors() {
    return (_database.select(_database.factors)..orderBy([
          (f) => OrderingTerm(expression: f.isDefault, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  // Menambah faktor baru
  Future<int> addFactor(String name, String icon) {
    return _database
        .into(_database.factors)
        .insert(
          FactorsCompanion.insert(
            name: name,
            icon: icon,
            isDefault: const Value(false), // Faktor buatan pengguna
          ),
        );
  }

  // -- BARU: Mengupdate faktor yang sudah ada --
  Future<bool> updateFactor(FactorsCompanion factor) {
    return _database.update(_database.factors).replace(factor);
  }

  // Menghapus faktor
  Future<int> deleteFactor(int id) {
    return (_database.delete(
      _database.factors,
    )..where((f) => f.id.equals(id))).go();
  }
}
