import 'package:get_it/get_it.dart';
import 'package:meta_lms/database/database.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AppDatabase()); // Register your AppDatabase as a singleton
}
