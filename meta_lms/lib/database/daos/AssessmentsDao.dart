import 'package:drift/drift.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/database/tables/Assessments.dart';

part 'AssessmentsDao.g.dart'; // The filename for the generated part file

@DriftAccessor(tables: [Assessments])
class AssessmentsDao extends DatabaseAccessor<AppDatabase> with _$AssessmentsDaoMixin {
  final AppDatabase db;

  AssessmentsDao(this.db) : super(db);

  Future<List<Assessment>> getAllAssessments() => select(assessments).get();

  Future<List<Assessment>> getAssessmentsByTopicId(int topicId) {
    return (select(assessments)
          ..where((tbl) => tbl.topicId.equals(topicId)))
        .get();
  }

  Stream<List<Assessment>> watchAllAssessments() => select(assessments).watch();

  Future insertAssessment(Insertable<Assessment> assessment) => into(assessments).insert(assessment);

  // Add more methods as needed
}
