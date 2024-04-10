import 'dart:convert';

class QuestionModel {
  final int id;
  final String questionDescription;
  final String type;
  final Map<String, dynamic> choices;
  final String? answerAttempt;
  final Map<String, dynamic> answer;
  final int assessmentId;
  final int? assessmentAttemptId;

  QuestionModel({
    required this.id,
    required this.questionDescription,
    required this.type,
    required this.choices,
    this.answerAttempt,
    required this.answer,
    required this.assessmentId,
    this.assessmentAttemptId,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      questionDescription: json['question_description'],
      type: json['type'],
      choices: jsonDecode(json['choices']),
      answerAttempt: json['answer_attempt'],
      answer: jsonDecode(json['answer']),
      assessmentId: json['assessment_id'],
      assessmentAttemptId: json['assessment_attempt_id'],
    );
  }
}
