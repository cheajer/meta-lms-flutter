// Assuming you have a file named topic.dart
class TopicModel {
  final int id;
  final String description;
  final int topicGroupId;
  final String topicName;
  final String imageUrl;
  final bool archived;

  TopicModel({
    required this.id,
    required this.description,
    required this.topicGroupId,
    required this.topicName,
    required this.imageUrl,
    required this.archived,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'],
      description: json['description'],
      topicGroupId: json['topic_group_id'],
      topicName: json['topic_name'],
      imageUrl: json['image_url'],
      archived: json['archived'],
    );
  }
}
