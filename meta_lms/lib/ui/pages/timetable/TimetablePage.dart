import 'package:flutter/material.dart';
import 'package:meta_lms/ui/widgets/GlobalAppBar.dart';
import 'package:meta_lms/utils/AppColors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:meta_lms/models/assessments/AssessmentDetailModel.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/provider/AuthProvider.dart';
import 'package:meta_lms/services/ApiGateway.dart';
import 'package:provider/provider.dart';
import 'package:meta_lms/utils/ServiceLocator.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({Key? key}) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  final ApiGateway _apiGateway = ApiGateway();
  Map<DateTime, List<AssessmentDetailModel>> assessmentEvents = {};
  List<AssessmentDetailModel> selectedAssessments = [];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    fetchAndGroupAssessments();
  }

  Future<void> fetchAndGroupAssessments() async {
    setState(() => assessmentEvents.clear());

    // Step 1: Fetch dehydrated assessments from the local database
    List<Assessment> dehydratedAssessments =
        await locator<AppDatabase>().assessmentsDao.getAllAssessments();

    // Step 2: Extract unique topic IDs
    Set<int> uniqueTopicIds =
        dehydratedAssessments.map((a) => a.topicId).toSet();

    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    String? token = authProvider.getToken();

    if (token == null) {
      return;
    }

    // Step 3: Fetch detailed assessments for each topic ID
    Map<DateTime, List<AssessmentDetailModel>> events = {};
    for (int topicId in uniqueTopicIds) {
      List<AssessmentDetailModel> detailedAssessments =
          await _apiGateway.fetchAssessmentDetailModels(token, topicId);

      // Step 4: Group assessments by their deadline dates
      for (var assessment in detailedAssessments) {
        DateTime? deadline = _parseDeadline(assessment.timeRange);
        print(deadline);
        if (deadline != null) {
          if (events[deadline] == null) {
            events[deadline] = [];
          }
          events[deadline]!.add(assessment);
        }
      }
    }

    setState(() {
      assessmentEvents = events;
    });
  }

  DateTime? _parseDeadline(String dateRange) {
    try {
      List<String> parts = dateRange.split(' to ');
      if (parts.length == 2) {
        List<String> dateParts = parts[1].split('/');
        if (dateParts.length == 3) {
          int year = int.parse(dateParts[0]);
          int month = int.parse(dateParts[1]);
          int day = int.parse(dateParts[2]);
          return DateTime(year, month, day);
        }
      }
    } catch (e) {
      print('Error parsing deadline: $e');
    }
    return null;
  }

  List<AssessmentDetailModel> _getEventsForDay(DateTime day) {
    // Normalize the input day to remove time
    DateTime normalizedDay = DateTime(day.year, day.month, day.day);

    // Normalize all keys in assessmentEvents to ensure a proper match
    var assessments = assessmentEvents.entries
        .where((entry) => _isSameDay(entry.key, normalizedDay))
        .map((entry) => entry.value)
        .expand((list) => list)
        .toList();

    print("Normalized Day: $normalizedDay");
    print(
        "Available Dates: ${assessmentEvents.keys.map((d) => DateTime(d.year, d.month, d.day))}");

    return assessments;
  }

  // Helper method to compare dates without considering the time
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: GlobalAppBar(
        elevation: 1,
      ),
      body: Column(
        children: [
          // Calendar Widget
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Theme.of(context).cardColor,
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                calendarFormat: CalendarFormat.month,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    selectedAssessments = _getEventsForDay(selectedDay);
                  });
                },
                eventLoader: (day) {
                  return _getEventsForDay(day);
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if (events.isNotEmpty) {
                      return Positioned(
                        bottom: 10,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
                calendarStyle: const CalendarStyle(
                  markerDecoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // List of Assessments for the selected day
          Expanded(
            child: ListView.builder(
              itemCount: selectedAssessments.length,
              itemBuilder: (context, index) {
                final assessment = selectedAssessments[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: ListTile(
                    leading: Icon(_getAssessmentIcon(assessment.type), color: AppColors.primaryColor,),
                    title: Text(assessment.name),
                    subtitle: Text('Due: ${assessment.timeRange}'),
                    onTap: () {
                      // Add navigation or other actions here
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getAssessmentIcon(String assessmentType) {
    switch (assessmentType) {
      case 'exam':
        return Icons.biotech;
      case 'assignment':
        return Icons.assignment;
      case 'quiz':
        return Icons.quiz;
      case 'essay':
        return Icons.book;
      default:
        return Icons.assignment;
    }
  }
}
