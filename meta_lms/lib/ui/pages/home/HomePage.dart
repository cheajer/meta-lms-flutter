import 'package:flutter/material.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/provider/AuthProvider.dart';
import 'package:meta_lms/services/NavigationService.dart';
import 'package:meta_lms/ui/pages/home/Dashboard.dart';
import 'package:meta_lms/ui/pages/topics/TopicsListPage.dart';
import 'package:meta_lms/ui/widgets/GlobalAppBar.dart';
import 'package:meta_lms/ui/widgets/ListButton.dart';
import 'package:meta_lms/ui/widgets/LoadingScreen.dart';
import 'package:meta_lms/ui/widgets/PoweredByWidget.dart';
import 'package:meta_lms/utils/AppColors.dart';
import 'package:meta_lms/utils/ServiceLocator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  List<Assessment> _assessments = [];

  @override
  void initState() {
    super.initState();
    // Initialize your topics list here, e.g.:
    // For now, we'll just use an empty list until you replace it with actual data.
    initialize();
  }

  Future<void> initialize() async {
    final _assessmentsDao = locator<AppDatabase>().assessmentsDao;
    setLoading(true);
    _assessments = await _assessmentsDao.getAllAssessments();
    print(_assessments.length);
    setLoading(false);
  }

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  String _daysUntilDue(String dateString) {
    DateTime? dueDate = parseSecondDateFromString(dateString);

    if (dueDate == null) {
      return "Invalid date format";
    }

    // Get the current date and time, and remove the time part to compare just the dates
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    // Calculate the difference
    Duration difference = dueDate.difference(today);
    int daysLeft = difference.inDays;

    // Return a readable string based on the number of days left
    if (daysLeft < 0) {
      return "The due date has passed";
    } else if (daysLeft == 0) {
      return "Due today";
    } else if (daysLeft == 1) {
      return "Due tomorrow";
    } else {
      return "$daysLeft days";
    }
  }

  DateTime? parseSecondDateFromString(String dateString) {
    try {
      List<String> parts = dateString.split(' to ');
      if (parts.length == 2) {
        String secondDateString = parts[1];
        List<String> dateParts = secondDateString.split('/');
        if (dateParts.length == 3) {
          int year = int.parse(dateParts[0]);
          int month = int.parse(dateParts[1]);
          int day = int.parse(dateParts[2]);
          return DateTime(year, month, day);
        }
      }
    } catch (e) {
      print('Error parsing date: $e');
    }
    return null;
  }

  String getSoonDueDate() {
    // Filter out assessments without a valid due date
    final validAssessments = _assessments
        .where((assessment) =>
            parseSecondDateFromString(assessment.timeRange) != null)
        .toList();

    // Sort by due date
    validAssessments.sort((a, b) => parseSecondDateFromString(a.timeRange)!
        .compareTo(parseSecondDateFromString(b.timeRange)!));

    // Get the soonest due date, if any
    if (validAssessments.isNotEmpty) {
      return _daysUntilDue(validAssessments.first.timeRange);
    } else {
      return "No upcoming due dates";
    }
  }

  int countOpenAssessments() {
    return _assessments

        .length;
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading)
        ? LoadingScreen()
        : Scaffold(
            appBar: GlobalAppBar(callback: setLoading),
            backgroundColor: AppColors.surfaceColor,
            body: Column(
              children: [
                Dashboard(
                  numAssessments: countOpenAssessments(),
                  nextDueStr: getSoonDueDate(),
                ),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [

                        ListButton(
                          text: 'Topics',
                          icon: Icons.book_outlined,
                          onPressed: () {
                            NavigationService.navigateToWidget(
                                const TopicsListPage());
                          },
                          height: 70,
                        ),
                        const Divider(
                            thickness: 0.5,
                            height: 3),
                        ListButton(
                          text: 'Assessments',
                          icon: Icons.checklist_outlined,
                          onPressed: () {},
                          height: 70,
                        ),
                        const Divider(
                            thickness: 0.5,
                            height: 3),
                        ListButton(
                          text: 'Resources',
                          icon: Icons.folder_outlined,
                          onPressed: () {},
                          height: 70,
                        ),
                        const Divider(
                            thickness: 0.5,
                            height: 3),
                        ListButton(
                          text: 'Timetable',
                          icon: Icons.calendar_today_outlined,
                          onPressed: () {},
                          height: 70,
                        ),
                        const Divider(
                            thickness: 0.5,
                            height: 3),
                        ListButton(
                          text: 'Refresh DB',
                          icon: Icons.refresh,
                          onPressed: () async {
                            setLoading(true);
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .fetchPostLoginData();
                            setLoading(false);
                          },
                          height: 70,
                        ),

                        
                      ],
                    ),
                  ),
                ),const PoweredByWidget(),
              ],
            ),
          );
  }
}
