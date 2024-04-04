import 'package:drift/drift.dart';

@DataClassName('Topic')
class Topics extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text().named('description').withDefault(const Constant(''))();
  IntColumn get topicGroupId => integer().named('topic_group_id')();
  TextColumn get topicName => text().named('topic_name')();
  TextColumn get imageUrl => text().named('image_url').withDefault(const Constant(''))();
  BoolColumn get archived => boolean().named('archived').withDefault(const Constant(false))();
}