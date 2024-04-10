import 'package:drift/drift.dart';

@DataClassName('Assessment')
class Assessments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get topicId => integer()();
  TextColumn get type => text()();
  RealColumn get proportion => real()();
  TextColumn get status => text()();
  TextColumn get assessmentName => text()();
  TextColumn get description => text().nullable()();
  TextColumn get timeRange => text()();
}
