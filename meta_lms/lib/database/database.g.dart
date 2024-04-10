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

class $ResourcesTable extends Resources
    with TableInfo<$ResourcesTable, Resource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _resourceTypeMeta =
      const VerificationMeta('resourceType');
  @override
  late final GeneratedColumn<String> resourceType = GeneratedColumn<String>(
      'resource_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sectionMeta =
      const VerificationMeta('section');
  @override
  late final GeneratedColumn<String> section = GeneratedColumn<String>(
      'section', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _serverPathMeta =
      const VerificationMeta('serverPath');
  @override
  late final GeneratedColumn<String> serverPath = GeneratedColumn<String>(
      'server_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _topicMeta = const VerificationMeta('topic');
  @override
  late final GeneratedColumn<String> topic = GeneratedColumn<String>(
      'topic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _topicIdMeta =
      const VerificationMeta('topicId');
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
      'topic_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, resourceType, section, serverPath, title, topic, topicId, url];
  @override
  String get aliasedName => _alias ?? 'resources';
  @override
  String get actualTableName => 'resources';
  @override
  VerificationContext validateIntegrity(Insertable<Resource> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('resource_type')) {
      context.handle(
          _resourceTypeMeta,
          resourceType.isAcceptableOrUnknown(
              data['resource_type']!, _resourceTypeMeta));
    } else if (isInserting) {
      context.missing(_resourceTypeMeta);
    }
    if (data.containsKey('section')) {
      context.handle(_sectionMeta,
          section.isAcceptableOrUnknown(data['section']!, _sectionMeta));
    } else if (isInserting) {
      context.missing(_sectionMeta);
    }
    if (data.containsKey('server_path')) {
      context.handle(
          _serverPathMeta,
          serverPath.isAcceptableOrUnknown(
              data['server_path']!, _serverPathMeta));
    } else if (isInserting) {
      context.missing(_serverPathMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('topic')) {
      context.handle(
          _topicMeta, topic.isAcceptableOrUnknown(data['topic']!, _topicMeta));
    } else if (isInserting) {
      context.missing(_topicMeta);
    }
    if (data.containsKey('topic_id')) {
      context.handle(_topicIdMeta,
          topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta));
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Resource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Resource(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      resourceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resource_type'])!,
      section: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}section'])!,
      serverPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}server_path'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      topic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}topic'])!,
      topicId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}topic_id'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
    );
  }

  @override
  $ResourcesTable createAlias(String alias) {
    return $ResourcesTable(attachedDatabase, alias);
  }
}

class Resource extends DataClass implements Insertable<Resource> {
  final int id;
  final String resourceType;
  final String section;
  final String serverPath;
  final String title;
  final String topic;
  final int topicId;
  final String url;
  const Resource(
      {required this.id,
      required this.resourceType,
      required this.section,
      required this.serverPath,
      required this.title,
      required this.topic,
      required this.topicId,
      required this.url});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['resource_type'] = Variable<String>(resourceType);
    map['section'] = Variable<String>(section);
    map['server_path'] = Variable<String>(serverPath);
    map['title'] = Variable<String>(title);
    map['topic'] = Variable<String>(topic);
    map['topic_id'] = Variable<int>(topicId);
    map['url'] = Variable<String>(url);
    return map;
  }

  ResourcesCompanion toCompanion(bool nullToAbsent) {
    return ResourcesCompanion(
      id: Value(id),
      resourceType: Value(resourceType),
      section: Value(section),
      serverPath: Value(serverPath),
      title: Value(title),
      topic: Value(topic),
      topicId: Value(topicId),
      url: Value(url),
    );
  }

  factory Resource.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Resource(
      id: serializer.fromJson<int>(json['id']),
      resourceType: serializer.fromJson<String>(json['resourceType']),
      section: serializer.fromJson<String>(json['section']),
      serverPath: serializer.fromJson<String>(json['serverPath']),
      title: serializer.fromJson<String>(json['title']),
      topic: serializer.fromJson<String>(json['topic']),
      topicId: serializer.fromJson<int>(json['topicId']),
      url: serializer.fromJson<String>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'resourceType': serializer.toJson<String>(resourceType),
      'section': serializer.toJson<String>(section),
      'serverPath': serializer.toJson<String>(serverPath),
      'title': serializer.toJson<String>(title),
      'topic': serializer.toJson<String>(topic),
      'topicId': serializer.toJson<int>(topicId),
      'url': serializer.toJson<String>(url),
    };
  }

  Resource copyWith(
          {int? id,
          String? resourceType,
          String? section,
          String? serverPath,
          String? title,
          String? topic,
          int? topicId,
          String? url}) =>
      Resource(
        id: id ?? this.id,
        resourceType: resourceType ?? this.resourceType,
        section: section ?? this.section,
        serverPath: serverPath ?? this.serverPath,
        title: title ?? this.title,
        topic: topic ?? this.topic,
        topicId: topicId ?? this.topicId,
        url: url ?? this.url,
      );
  @override
  String toString() {
    return (StringBuffer('Resource(')
          ..write('id: $id, ')
          ..write('resourceType: $resourceType, ')
          ..write('section: $section, ')
          ..write('serverPath: $serverPath, ')
          ..write('title: $title, ')
          ..write('topic: $topic, ')
          ..write('topicId: $topicId, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, resourceType, section, serverPath, title, topic, topicId, url);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Resource &&
          other.id == this.id &&
          other.resourceType == this.resourceType &&
          other.section == this.section &&
          other.serverPath == this.serverPath &&
          other.title == this.title &&
          other.topic == this.topic &&
          other.topicId == this.topicId &&
          other.url == this.url);
}

class ResourcesCompanion extends UpdateCompanion<Resource> {
  final Value<int> id;
  final Value<String> resourceType;
  final Value<String> section;
  final Value<String> serverPath;
  final Value<String> title;
  final Value<String> topic;
  final Value<int> topicId;
  final Value<String> url;
  const ResourcesCompanion({
    this.id = const Value.absent(),
    this.resourceType = const Value.absent(),
    this.section = const Value.absent(),
    this.serverPath = const Value.absent(),
    this.title = const Value.absent(),
    this.topic = const Value.absent(),
    this.topicId = const Value.absent(),
    this.url = const Value.absent(),
  });
  ResourcesCompanion.insert({
    this.id = const Value.absent(),
    required String resourceType,
    required String section,
    required String serverPath,
    required String title,
    required String topic,
    required int topicId,
    required String url,
  })  : resourceType = Value(resourceType),
        section = Value(section),
        serverPath = Value(serverPath),
        title = Value(title),
        topic = Value(topic),
        topicId = Value(topicId),
        url = Value(url);
  static Insertable<Resource> custom({
    Expression<int>? id,
    Expression<String>? resourceType,
    Expression<String>? section,
    Expression<String>? serverPath,
    Expression<String>? title,
    Expression<String>? topic,
    Expression<int>? topicId,
    Expression<String>? url,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (resourceType != null) 'resource_type': resourceType,
      if (section != null) 'section': section,
      if (serverPath != null) 'server_path': serverPath,
      if (title != null) 'title': title,
      if (topic != null) 'topic': topic,
      if (topicId != null) 'topic_id': topicId,
      if (url != null) 'url': url,
    });
  }

  ResourcesCompanion copyWith(
      {Value<int>? id,
      Value<String>? resourceType,
      Value<String>? section,
      Value<String>? serverPath,
      Value<String>? title,
      Value<String>? topic,
      Value<int>? topicId,
      Value<String>? url}) {
    return ResourcesCompanion(
      id: id ?? this.id,
      resourceType: resourceType ?? this.resourceType,
      section: section ?? this.section,
      serverPath: serverPath ?? this.serverPath,
      title: title ?? this.title,
      topic: topic ?? this.topic,
      topicId: topicId ?? this.topicId,
      url: url ?? this.url,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (resourceType.present) {
      map['resource_type'] = Variable<String>(resourceType.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    if (serverPath.present) {
      map['server_path'] = Variable<String>(serverPath.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (topic.present) {
      map['topic'] = Variable<String>(topic.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResourcesCompanion(')
          ..write('id: $id, ')
          ..write('resourceType: $resourceType, ')
          ..write('section: $section, ')
          ..write('serverPath: $serverPath, ')
          ..write('title: $title, ')
          ..write('topic: $topic, ')
          ..write('topicId: $topicId, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }
}

class $AssessmentsTable extends Assessments
    with TableInfo<$AssessmentsTable, Assessment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssessmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _topicIdMeta =
      const VerificationMeta('topicId');
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
      'topic_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _proportionMeta =
      const VerificationMeta('proportion');
  @override
  late final GeneratedColumn<double> proportion = GeneratedColumn<double>(
      'proportion', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assessmentNameMeta =
      const VerificationMeta('assessmentName');
  @override
  late final GeneratedColumn<String> assessmentName = GeneratedColumn<String>(
      'assessment_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeRangeMeta =
      const VerificationMeta('timeRange');
  @override
  late final GeneratedColumn<String> timeRange = GeneratedColumn<String>(
      'time_range', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        topicId,
        type,
        proportion,
        status,
        assessmentName,
        description,
        timeRange
      ];
  @override
  String get aliasedName => _alias ?? 'assessments';
  @override
  String get actualTableName => 'assessments';
  @override
  VerificationContext validateIntegrity(Insertable<Assessment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('topic_id')) {
      context.handle(_topicIdMeta,
          topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta));
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('proportion')) {
      context.handle(
          _proportionMeta,
          proportion.isAcceptableOrUnknown(
              data['proportion']!, _proportionMeta));
    } else if (isInserting) {
      context.missing(_proportionMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('assessment_name')) {
      context.handle(
          _assessmentNameMeta,
          assessmentName.isAcceptableOrUnknown(
              data['assessment_name']!, _assessmentNameMeta));
    } else if (isInserting) {
      context.missing(_assessmentNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('time_range')) {
      context.handle(_timeRangeMeta,
          timeRange.isAcceptableOrUnknown(data['time_range']!, _timeRangeMeta));
    } else if (isInserting) {
      context.missing(_timeRangeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Assessment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Assessment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      topicId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}topic_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      proportion: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}proportion'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      assessmentName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}assessment_name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      timeRange: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_range'])!,
    );
  }

  @override
  $AssessmentsTable createAlias(String alias) {
    return $AssessmentsTable(attachedDatabase, alias);
  }
}

class Assessment extends DataClass implements Insertable<Assessment> {
  final int id;
  final int topicId;
  final String type;
  final double proportion;
  final String status;
  final String assessmentName;
  final String? description;
  final String timeRange;
  const Assessment(
      {required this.id,
      required this.topicId,
      required this.type,
      required this.proportion,
      required this.status,
      required this.assessmentName,
      this.description,
      required this.timeRange});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['topic_id'] = Variable<int>(topicId);
    map['type'] = Variable<String>(type);
    map['proportion'] = Variable<double>(proportion);
    map['status'] = Variable<String>(status);
    map['assessment_name'] = Variable<String>(assessmentName);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['time_range'] = Variable<String>(timeRange);
    return map;
  }

  AssessmentsCompanion toCompanion(bool nullToAbsent) {
    return AssessmentsCompanion(
      id: Value(id),
      topicId: Value(topicId),
      type: Value(type),
      proportion: Value(proportion),
      status: Value(status),
      assessmentName: Value(assessmentName),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      timeRange: Value(timeRange),
    );
  }

  factory Assessment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Assessment(
      id: serializer.fromJson<int>(json['id']),
      topicId: serializer.fromJson<int>(json['topicId']),
      type: serializer.fromJson<String>(json['type']),
      proportion: serializer.fromJson<double>(json['proportion']),
      status: serializer.fromJson<String>(json['status']),
      assessmentName: serializer.fromJson<String>(json['assessmentName']),
      description: serializer.fromJson<String?>(json['description']),
      timeRange: serializer.fromJson<String>(json['timeRange']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'topicId': serializer.toJson<int>(topicId),
      'type': serializer.toJson<String>(type),
      'proportion': serializer.toJson<double>(proportion),
      'status': serializer.toJson<String>(status),
      'assessmentName': serializer.toJson<String>(assessmentName),
      'description': serializer.toJson<String?>(description),
      'timeRange': serializer.toJson<String>(timeRange),
    };
  }

  Assessment copyWith(
          {int? id,
          int? topicId,
          String? type,
          double? proportion,
          String? status,
          String? assessmentName,
          Value<String?> description = const Value.absent(),
          String? timeRange}) =>
      Assessment(
        id: id ?? this.id,
        topicId: topicId ?? this.topicId,
        type: type ?? this.type,
        proportion: proportion ?? this.proportion,
        status: status ?? this.status,
        assessmentName: assessmentName ?? this.assessmentName,
        description: description.present ? description.value : this.description,
        timeRange: timeRange ?? this.timeRange,
      );
  @override
  String toString() {
    return (StringBuffer('Assessment(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('type: $type, ')
          ..write('proportion: $proportion, ')
          ..write('status: $status, ')
          ..write('assessmentName: $assessmentName, ')
          ..write('description: $description, ')
          ..write('timeRange: $timeRange')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, topicId, type, proportion, status,
      assessmentName, description, timeRange);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Assessment &&
          other.id == this.id &&
          other.topicId == this.topicId &&
          other.type == this.type &&
          other.proportion == this.proportion &&
          other.status == this.status &&
          other.assessmentName == this.assessmentName &&
          other.description == this.description &&
          other.timeRange == this.timeRange);
}

class AssessmentsCompanion extends UpdateCompanion<Assessment> {
  final Value<int> id;
  final Value<int> topicId;
  final Value<String> type;
  final Value<double> proportion;
  final Value<String> status;
  final Value<String> assessmentName;
  final Value<String?> description;
  final Value<String> timeRange;
  const AssessmentsCompanion({
    this.id = const Value.absent(),
    this.topicId = const Value.absent(),
    this.type = const Value.absent(),
    this.proportion = const Value.absent(),
    this.status = const Value.absent(),
    this.assessmentName = const Value.absent(),
    this.description = const Value.absent(),
    this.timeRange = const Value.absent(),
  });
  AssessmentsCompanion.insert({
    this.id = const Value.absent(),
    required int topicId,
    required String type,
    required double proportion,
    required String status,
    required String assessmentName,
    this.description = const Value.absent(),
    required String timeRange,
  })  : topicId = Value(topicId),
        type = Value(type),
        proportion = Value(proportion),
        status = Value(status),
        assessmentName = Value(assessmentName),
        timeRange = Value(timeRange);
  static Insertable<Assessment> custom({
    Expression<int>? id,
    Expression<int>? topicId,
    Expression<String>? type,
    Expression<double>? proportion,
    Expression<String>? status,
    Expression<String>? assessmentName,
    Expression<String>? description,
    Expression<String>? timeRange,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (topicId != null) 'topic_id': topicId,
      if (type != null) 'type': type,
      if (proportion != null) 'proportion': proportion,
      if (status != null) 'status': status,
      if (assessmentName != null) 'assessment_name': assessmentName,
      if (description != null) 'description': description,
      if (timeRange != null) 'time_range': timeRange,
    });
  }

  AssessmentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? topicId,
      Value<String>? type,
      Value<double>? proportion,
      Value<String>? status,
      Value<String>? assessmentName,
      Value<String?>? description,
      Value<String>? timeRange}) {
    return AssessmentsCompanion(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      type: type ?? this.type,
      proportion: proportion ?? this.proportion,
      status: status ?? this.status,
      assessmentName: assessmentName ?? this.assessmentName,
      description: description ?? this.description,
      timeRange: timeRange ?? this.timeRange,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (proportion.present) {
      map['proportion'] = Variable<double>(proportion.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (assessmentName.present) {
      map['assessment_name'] = Variable<String>(assessmentName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (timeRange.present) {
      map['time_range'] = Variable<String>(timeRange.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssessmentsCompanion(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('type: $type, ')
          ..write('proportion: $proportion, ')
          ..write('status: $status, ')
          ..write('assessmentName: $assessmentName, ')
          ..write('description: $description, ')
          ..write('timeRange: $timeRange')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $TopicsTable topics = $TopicsTable(this);
  late final $ResourcesTable resources = $ResourcesTable(this);
  late final $AssessmentsTable assessments = $AssessmentsTable(this);
  late final TopicsDao topicsDao = TopicsDao(this as AppDatabase);
  late final ResourcesDao resourcesDao = ResourcesDao(this as AppDatabase);
  late final AssessmentsDao assessmentsDao =
      AssessmentsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [topics, resources, assessments];
}
