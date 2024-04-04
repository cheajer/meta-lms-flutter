import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/models/topics/TopicModel.dart';
import 'package:meta_lms/utils/HttpHelper.dart';
import 'package:meta_lms/utils/ServiceLocator.dart';

class TopicsService {
  
  final HttpHelper _httpHelper;

  TopicsService()
      : _httpHelper = HttpHelper();

  final _topicsDao = locator<AppDatabase>().topicsDao;

  Future<void> fetchAndStoreEnrolledTopics(String token) async {
    final response = await _httpHelper.get(
      '/enrolled_topics',
      token: token
    );
    print(response);
    if (response != null) {
      final topicsJson = response['topics'] as List;
      final topics = topicsJson.map((json) => TopicModel.fromJson(json)).toList();

      // Insert into database
      for (var topic in topics) {
        final topicEntry = TopicsCompanion(
          id: Value(topic.id),
          description: Value(topic.description),
          topicGroupId: Value(topic.topicGroupId),
          topicName: Value(topic.topicName),
          imageUrl: Value(topic.imageUrl),
          archived: Value(topic.archived),
        );
        await _topicsDao.insertTopic(topicEntry);
      }
    } else {
      // Handle errors, possibly throw an exception
      throw Exception('Failed to load topics');
    }
  }
}
