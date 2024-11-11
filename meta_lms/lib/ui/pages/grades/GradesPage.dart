import 'package:flutter/material.dart';
import 'package:meta_lms/ui/widgets/GlobalAppBar.dart';
import 'package:meta_lms/utils/AppColors.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({Key? key}) : super(key: key);

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  // Sample hardcoded data
  final List<Map<String, dynamic>> topics = [
    {
      'topic': 'Databases',
      'grade': 'A',
      'score': 90,
      'assessments': [
        {'name': 'Midterm Exam', 'grade': 'A', 'score': 92},
        {'name': 'Project', 'grade': 'A-', 'score': 88},
        {'name': 'Final Exam', 'grade': 'B+', 'score': 85},
      ],
    },
    {
      'topic': 'Linked Lists',
      'grade': 'B+',
      'score': 78,
      'assessments': [
        {'name': 'Quiz 1', 'grade': 'B', 'score': 75},
        {'name': 'Assignment 1', 'grade': 'B+', 'score': 80},
        {'name': 'Final Exam', 'grade': 'B', 'score': 78},
      ],
    },
    {
      'topic': 'Calculus',
      'grade': 'Unmarked',
      'score': 0,
      'assessments': [
        {'name': 'Quiz 1', 'grade': 'Unmarked', 'score': null},
        {'name': 'Assignment 1', 'grade': 'Unmarked', 'score': null},
        {'name': 'Final Exam', 'grade': 'Unmarked', 'score': null},
      ],
    },
  ];

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
        return Colors.green;
      case 'A-':
        return Colors.lightGreen;
      case 'B+':
        return Colors.orange;
      case 'B':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
      appBar: const GlobalAppBar(
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final topicData = topics[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                color: Colors.white,
                child: ExpansionTile(
                  collapsedBackgroundColor: Theme.of(context).cardColor,
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: _getGradeColor(topicData['grade']),
                        child: Text(
                          topicData['grade'] == 'Unmarked' ? '-' : topicData['grade'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        topicData['topic'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        topicData['grade'] == 'Unmarked'
                            ? 'Not yet graded'
                            : '${topicData['score']}%',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  children: topicData['assessments'].map<Widget>((assessment) {
                    return ListTile(
                      leading: Icon(
                        assessment['grade'] == 'Unmarked'
                            ? Icons.pending
                            : Icons.check_circle,
                        color: assessment['grade'] == 'Unmarked'
                            ? Colors.grey
                            : Colors.green,
                      ),
                      title: Text(assessment['name']),
                      subtitle: Text(
                        assessment['grade'] == 'Unmarked'
                            ? 'Not yet graded'
                            : 'Grade: ${assessment['grade']}',
                      ),
                      trailing: assessment['score'] != null
                          ? Text('${assessment['score']}%')
                          : const Text('—'),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
