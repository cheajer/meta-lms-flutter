import 'package:drift/drift.dart';

@DataClassName('Resource')
class Resources extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get resourceType => text().named('resource_type')();
  TextColumn get section => text()();
  TextColumn get serverPath => text().named('server_path')();
  TextColumn get title => text()();
  TextColumn get topic => text()();
  IntColumn get topicId => integer().named('topic_id')();
  TextColumn get url => text()();
}