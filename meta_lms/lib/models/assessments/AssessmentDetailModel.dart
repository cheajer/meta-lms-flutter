import 'package:meta_lms/models/assessments/QuestionModel.dart';

class AssessmentDetailModel {
  final int id;
  final String name;
  final String type;
  final String status;
  final double proportion;
  final String timeRange;
  final int topicId;
  final List<QuestionModel> questions;

  AssessmentDetailModel({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.proportion,
    required this.timeRange,
    required this.topicId,
    required this.questions,
  });

  factory AssessmentDetailModel.fromJson(Map<String, dynamic> json, int topicId) {
    var questionsFromJson = json['questions'] as List;
    List<QuestionModel> questionsList = questionsFromJson.map((questionJson) => QuestionModel.fromJson(questionJson)).toList();

    return AssessmentDetailModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      status: json['status'],
      proportion: json['proportion'].toDouble(),
      timeRange: json['timeRange'],
      topicId: topicId,
      questions: questionsList,
    );
  }
}
