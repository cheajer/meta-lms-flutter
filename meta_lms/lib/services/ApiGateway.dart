import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/models/assessments/AssessmentDetailModel.dart';
import 'package:meta_lms/models/assessments/AssessmentModel.dart';
import 'package:meta_lms/models/resources/ResourceModel.dart';
import 'package:meta_lms/models/topics/TopicModel.dart';
import 'package:meta_lms/utils/HttpHelper.dart';
import 'package:meta_lms/utils/ServiceLocator.dart';

class ApiGateway {
  final HttpHelper _httpHelper;

  ApiGateway() : _httpHelper = HttpHelper();

  final _topicsDao = locator<AppDatabase>().topicsDao;
  final _resourcesDao = locator<AppDatabase>().resourcesDao;
  final _assessmentsDao = locator<AppDatabase>().assessmentsDao;

  Future<List<AssessmentDetailModel>> fetchAssessmentDetailModels(String token, int topicId) async {
    final response = await _httpHelper.post(
      '/assessment/detail',
      {'token': token, 'topic_id': topicId},
      token: token,
    );

    if (response !=null) {
      final assessmentsJson = response as List;
      final assessments =
          assessmentsJson.map((json) => AssessmentDetailModel.fromJson(json)).toList();

      return assessments;
    }

    return [];
  }

  Future fetchAndStoreUserResources(String token) async {
    final response = await _httpHelper.get('/user_resources', token: token);
    print(response);
    if (response != null) {
      final resourcesJson = response as List;
      final resources =
          resourcesJson.map((json) => ResourceModel.fromJson(json)).toList();

      // Insert into database
      for (var resource in resources) {
        final resourceEntry = ResourcesCompanion(
            id: Value(resource.id),
            resourceType: Value(resource.resourceType),
            topicId: Value(resource.topicId),
            section: Value(resource.section),
            serverPath: Value(resource.serverPath),
            title: Value(resource.title),
            topic: Value(resource.topic),
            url: Value(resource.url));
        await _resourcesDao.insertResource(resourceEntry);
      }
    } else {
      // Handle errors, possibly throw an exception
      throw Exception('Failed to load resources');
    }
  }


  Future<void> fetchAndStoreUserAssessments(String token) async {
    final response = await _httpHelper.post(
      '/user/lookup/assessment/open',
      {'token': token},
      token: token,
    );
    print(response);
    if (response != null) {
      final assessmentsJson = response as List;
      final assessments = assessmentsJson.map((json) => AssessmentModel.fromJson(json)).toList();

      for (var assessment in assessments) {
        final assessmentEntry = AssessmentsCompanion(
          id: Value(assessment.id),
          topicId: Value(assessment.topicId),
          type: Value(assessment.type),
          proportion: Value(assessment.proportion),
          status: Value(assessment.status),
          assessmentName: Value(assessment.assessmentName),
          description: Value(assessment.description),
          timeRange: Value(assessment.timeRange),
        );
        await _assessmentsDao.insertAssessment(assessmentEntry);
      }
    } else {
      // Handle errors, possibly throw an exception
      throw Exception('Failed to load assessments');
    }

   
  }


  Future fetchAndStoreEnrolledTopics(String token) async {
    final response = await _httpHelper.get('/enrolled_topics', token: token);
    print(response);
    if (response != null) {
      final topicsJson = response['topics'] as List;
      final topics =
          topicsJson.map((json) => TopicModel.fromJson(json)).toList();

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
