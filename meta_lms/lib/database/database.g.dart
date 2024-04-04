// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TopicsTable extends Topics with TableInfo<$TopicsTable, Topic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _topicGroupIdMeta =
      const VerificationMeta('topicGroupId');
  @override
  late final GeneratedColumn<int> topicGroupId = GeneratedColumn<int>(
      'topic_group_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _topicNameMeta =
      const VerificationMeta('topicName');
  @override
  late final GeneratedColumn<String> topicName = GeneratedColumn<String>(
      'topic_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _archivedMeta =
      const VerificationMeta('archived');
  @override
  late final GeneratedColumn<bool> archived =
      GeneratedColumn<bool>('archived', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("archived" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, description, topicGroupId, topicName, imageUrl, archived];
  @override
  String get aliasedName => _alias ?? 'topics';
  @override
  String get actualTableName => 'topics';
  @override
  VerificationContext validateIntegrity(Insertable<Topic> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('topic_group_id')) {
      context.handle(
          _topicGroupIdMeta,
          topicGroupId.isAcceptableOrUnknown(
              data['topic_group_id']!, _topicGroupIdMeta));
    } else if (isInserting) {
      context.missing(_topicGroupIdMeta);
    }
    if (data.containsKey('topic_name')) {
      context.handle(_topicNameMeta,
          topicName.isAcceptableOrUnknown(data['topic_name']!, _topicNameMeta));
    } else if (isInserting) {
      context.missing(_topicNameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('archived')) {
      context.handle(_archivedMeta,
          archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Topic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Topic(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      topicGroupId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}topic_group_id'])!,
      topicName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}topic_name'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      archived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}archived'])!,
    );
  }

  @override
  $TopicsTable createAlias(String alias) {
    return $TopicsTable(attachedDatabase, alias);
  }
}

class Topic extends DataClass implements Insertable<Topic> {
  final int id;
  final String description;
  final int topicGroupId;
  final String topicName;
  final String imageUrl;
  final bool archived;
  const Topic(
      {required this.id,
      required this.description,
      required this.topicGroupId,
      required this.topicName,
      required this.imageUrl,
      required this.archived});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['description'] = Variable<String>(description);
    map['topic_group_id'] = Variable<int>(topicGroupId);
    map['topic_name'] = Variable<String>(topicName);
    map['image_url'] = Variable<String>(imageUrl);
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  TopicsCompanion toCompanion(bool nullToAbsent) {
    return TopicsCompanion(
      id: Value(id),
      description: Value(description),
      topicGroupId: Value(topicGroupId),
      topicName: Value(topicName),
      imageUrl: Value(imageUrl),
      archived: Value(archived),
    );
  }

  factory Topic.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Topic(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      topicGroupId: serializer.fromJson<int>(json['topicGroupId']),
      topicName: serializer.fromJson<String>(json['topicName']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String>(description),
      'topicGroupId': serializer.toJson<int>(topicGroupId),
      'topicName': serializer.toJson<String>(topicName),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  Topic copyWith(
          {int? id,
          String? description,
          int? topicGroupId,
          String? topicName,
          String? imageUrl,
          bool? archived}) =>
      Topic(
        id: id ?? this.id,
        description: description ?? this.description,
        topicGroupId: topicGroupId ?? this.topicGroupId,
        topicName: topicName ?? this.topicName,
        imageUrl: imageUrl ?? this.imageUrl,
        archived: archived ?? this.archived,
      );
  @override
  String toString() {
    return (StringBuffer('Topic(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('topicGroupId: $topicGroupId, ')
          ..write('topicName: $topicName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, description, topicGroupId, topicName, imageUrl, archived);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Topic &&
          other.id == this.id &&
          other.description == this.description &&
          other.topicGroupId == this.topicGroupId &&
          other.topicName == this.topicName &&
          other.imageUrl == this.imageUrl &&
          other.archived == this.archived);
}

class TopicsCompanion extends UpdateCompanion<Topic> {
  final Value<int> id;
  final Value<String> description;
  final Value<int> topicGroupId;
  final Value<String> topicName;
  final Value<String> imageUrl;
  final Value<bool> archived;
  const TopicsCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.topicGroupId = const Value.absent(),
    this.topicName = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.archived = const Value.absent(),
  });
  TopicsCompanion.insert({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    required int topicGroupId,
    required String topicName,
    this.imageUrl = const Value.absent(),
    this.archived = const Value.absent(),
  })  : topicGroupId = Value(topicGroupId),
        topicName = Value(topicName);
  static Insertable<Topic> custom({
    Expression<int>? id,
    Expression<String>? description,
    Expression<int>? topicGroupId,
    Expression<String>? topicName,
    Expression<String>? imageUrl,
    Expression<bool>? archived,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (topicGroupId != null) 'topic_group_id': topicGroupId,
      if (topicName != null) 'topic_name': topicName,
      if (imageUrl != null) 'image_url': imageUrl,
      if (archived != null) 'archived': archived,
    });
  }

  TopicsCompanion copyWith(
      {Value<int>? id,
      Value<String>? description,
      Value<int>? topicGroupId,
      Value<String>? topicName,
      Value<String>? imageUrl,
      Value<bool>? archived}) {
    return TopicsCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      topicGroupId: topicGroupId ?? this.topicGroupId,
      topicName: topicName ?? this.topicName,
      imageUrl: imageUrl ?? this.imageUrl,
      archived: archived ?? this.archived,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (topicGroupId.present) {
      map['topic_group_id'] = Variable<int>(topicGroupId.value);
    }
    if (topicName.present) {
      map['topic_name'] = Variable<String>(topicName.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicsCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('topicGroupId: $topicGroupId, ')
          ..write('topicName: $topicName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $TopicsTable topics = $TopicsTable(this);
  late final TopicsDao topicsDao = TopicsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [topics];
}
