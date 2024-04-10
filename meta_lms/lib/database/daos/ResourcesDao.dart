import 'package:drift/drift.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/database/tables/Resources.dart';

part 'ResourcesDao.g.dart'; // The filename for the generated part file.

@DriftAccessor(tables: [Resources])
class ResourcesDao extends DatabaseAccessor<AppDatabase> with _$ResourcesDaoMixin {
  // Pass the AppDatabase object to the constructor
  ResourcesDao(AppDatabase db) : super(db);

  // Define a method to retrieve all Resources from the database
  Future<List<Resource>> getAllResources() => select(resources).get();

  Future<List<Resource>> getResourcesByTopicId(int topicId) {
    return (select(resources)
          ..where((tbl) => tbl.topicId.equals(topicId)))
        .get();
  }


  Future<List<Resource>> getResourcesByType(String resourceType) {
    return (select(resources)
          ..where((tbl) => tbl.resourceType.equals(resourceType)))
        .get();
  }

  // Define a method to watch all Resources as a stream
  Stream<List<Resource>> watchAllResources() => select(resources).watch();

  // Define a method to insert a new Resource
  Future<int> insertResource(ResourcesCompanion resource) => into(resources).insert(resource);

  // Define a method to update a Resource
  Future<bool> updateResource(ResourcesCompanion resource) => update(resources).replace(resource);

  // Define a method to delete a Resource
  Future<int> deleteResource(ResourcesCompanion resource) => delete(resources).delete(resource);

  // More methods as needed for your use case
}
