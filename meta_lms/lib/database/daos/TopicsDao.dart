import 'package:drift/drift.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/database/tables/Topics.dart';

part 'TopicsDao.g.dart'; // The filename for the generated part file.

@DriftAccessor(tables: [Topics])
class TopicsDao extends DatabaseAccessor<AppDatabase> with _$TopicsDaoMixin {
  // Pass the AppDatabase object to the constructor
  TopicsDao(AppDatabase db) : super(db);

  // Define a method to retrieve all topics from the database
  Future<List<Topic>> getAllTopics() => select(topics).get();

  // Method to get a topic name using the topicId
  Future<String?> getTopicNameById(int topicId) async {
    final query = select(topics)..where((t) => t.id.equals(topicId));
    final topic = await query.getSingleOrNull();
    return topic?.topicName;
  }

  // Define a method to watch all topics as a stream
  Stream<List<Topic>> watchAllTopics() => select(topics).watch();

  // Define a method to insert a new topic
  Future<int> insertTopic(TopicsCompanion topic) => into(topics).insert(topic);

  // Define a method to update a topic
  Future<bool> updateTopic(TopicsCompanion topic) => update(topics).replace(topic);

  // Define a method to delete a topic
  Future<int> deleteTopic(TopicsCompanion topic) => delete(topics).delete(topic);

  // Define a method to get the most recently accessed topic
  Future<Topic?> getMostRecentlyAccessedTopic() async {
    return (select(topics)
          ..orderBy([
            (t) => OrderingTerm(expression: t.lastAccessed, mode: OrderingMode.desc), // Order by lastAccessed descending
          ])
          ..limit(1)) // Limit to only one result
        .getSingleOrNull(); // Get the single topic or return null if none exists
  }

  // Method to update the lastAccessed time for a given topic ID
  Future<void> updateLastAccessed(int topicId) async {
    await (update(topics)..where((t) => t.id.equals(topicId))).write(
      TopicsCompanion(
        lastAccessed: Value(DateTime.now()), // Set lastAccessed to the current datetime
      ),
    );
  }
}
