import 'dart:io';
import 'package:meta_lms/database/daos/AssessmentsDao.dart';
import 'package:meta_lms/database/daos/ResourcesDao.dart';
import 'package:meta_lms/database/daos/TopicsDao.dart';
import 'package:meta_lms/database/tables/Assessments.dart';
import 'package:meta_lms/database/tables/Resources.dart';
import 'package:meta_lms/database/tables/Topics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart'; // The filename for the generated part file

@DriftDatabase(tables: [Topics, Resources, Assessments], daos: [TopicsDao, ResourcesDao, AssessmentsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  Future<void> clearAllTables() async {
    // For each table, execute a delete statement without a where clause,
    // which will delete all rows from the table.

    await batch((batch) {
      // Using batch to perform all deletes in a single transaction for efficiency
      batch.deleteWhere(topics,
          (_) => const Constant(true)); // Deletes all rows in Topics table
      // Add similar lines here for other tables
      batch.deleteWhere(resources,
          (_) => const Constant(true));

      batch.deleteWhere(assessments,
          (_) => const Constant(true));
    });
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
        // Called when the database is first created
        onCreate: (Migrator m) {
          return m.createAll();
        },

        // Handles all migrations from one version to another
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            // Example migration: Adding a new table in version 2
            await m.createTable(resources);
            // If you have columns to add or modify in existing tables, you would use
            // m.addColumn(tableName, columnName), m.alterTable() etc.
          }
          if (from < 3) {
            await m.createTable(assessments);
          }
          if (from < 4) {
            await m.addColumn(topics, topics.lastAccessed);
          }
          // Future version migrations go here
          // if (from < 3) {
          //   // Implement migration to version 3
          // }
        },

        // Optional: Override to handle cases where the schema version is higher
        // than expected (e.g., downgrading the app)
        beforeOpen: (details) async {
          if (details.wasCreated) {
            // Initialize data if needed
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
