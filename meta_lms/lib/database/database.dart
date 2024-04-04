import 'dart:io';
import 'package:meta_lms/database/daos/TopicsDao.dart';
import 'package:meta_lms/database/tables/Topics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart'; // The filename for the generated part file

@DriftDatabase(tables: [Topics], daos: [TopicsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> clearAllTables() async {
    // For each table, execute a delete statement without a where clause,
    // which will delete all rows from the table.

    await batch((batch) {
      // Using batch to perform all deletes in a single transaction for efficiency
      batch.deleteWhere(topics, (_) => const Constant(true)); // Deletes all rows in Topics table
      // Add similar lines here for other tables
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
