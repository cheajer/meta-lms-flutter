class ResourceModel {
  final int id;
  final String resourceType;
  final int topicId;
  final String section;
  final String serverPath;
  final String title;
  final String topic;
  final String url;

  ResourceModel({
    required this.id,
    required this.resourceType,
    required this.topicId,
    required this.section,
    required this.serverPath,
    required this.title,
    required this.topic,
    required this.url
  });

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
      id: json['id'],
      resourceType: json['resource_type'],
      topicId: json['topic_id'],
      section: json['section'],
      serverPath: json['server_path'],
      title: json['title'],
      topic: json['topic'],
      url: json['url']
    );
  }
}
