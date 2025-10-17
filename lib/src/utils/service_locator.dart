import 'package:get_it/get_it.dart';
import '../models/database/database.dart';
import '../models/repositories/factor_repository.dart';
import '../models/repositories/sleep_repository.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Database
  sl.registerLazySingleton(() => AppDatabase());

  // Repositories
  sl.registerLazySingleton(() => FactorRepository());
  sl.registerLazySingleton(() => SleepRepository());
}
