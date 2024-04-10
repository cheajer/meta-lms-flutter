class AssessmentModel {
  final int id;
  final int topicId;
  final String type;
  final double proportion;
  final String status;
  final String assessmentName;
  final String? description; // Assuming this can be null
  final String timeRange;
  final String topicName; // Additional field based on your example

  AssessmentModel({
    required this.id,
    required this.topicId,
    required this.type,
    required this.proportion,
    required this.status,
    required this.assessmentName,
    this.description,
    required this.timeRange,
    required this.topicName,
  });

  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentModel(
      id: json['id'],
      topicId: json['topic_id'],
      type: json['type'],
      proportion: json['proportion'].toDouble(), // Ensuring this is a double
      status: json['status'],
      assessmentName: json['assessmentName'],
      description: json['description'],
      timeRange: json['timeRange'],
      topicName: "", // Assuming this comes from the same level as Assessment
    );
  }
}
