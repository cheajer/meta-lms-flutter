import 'package:flutter/material.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/provider/AuthProvider.dart';
import 'package:meta_lms/provider/TopicProvider.dart';
import 'package:meta_lms/services/NavigationService.dart';
import 'package:meta_lms/ui/pages/assessments/AssessmentsListPage.dart';
import 'package:meta_lms/ui/pages/grades/GradesPage.dart';
import 'package:meta_lms/ui/pages/home/Dashboard.dart';
import 'package:meta_lms/ui/pages/home/RecentlyAccessed.dart';
import 'package:meta_lms/ui/pages/settings/SettingsPage.dart';
import 'package:meta_lms/ui/pages/timetable/TimetablePage.dart';
import 'package:meta_lms/ui/pages/topics/TopicsListPage.dart';
import 'package:meta_lms/ui/widgets/GlobalAppBar.dart';
import 'package:meta_lms/ui/widgets/ListButton.dart';
import 'package:meta_lms/ui/widgets/LoadingScreen.dart';
import 'package:meta_lms/ui/widgets/PoweredByWidget.dart';
import 'package:meta_lms/utils/AppColors.dart';
import 'package:meta_lms/utils/ServiceLocator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  List<Assessment> _assessments = [];
  Topic? _topic;
  @override
  void initState() {
    super.initState();
    // Initialize your topics list here, e.g.:
    // For now, we'll just use an empty list until you replace it with actual data.
    initialize();
  }

  Future<void> initialize() async {
    final _assessmentsDao = locator<AppDatabase>().assessmentsDao;
    final _topicsDao = locator<AppDatabase>().topicsDao;
    setLoading(true);
    _assessments = await _assessmentsDao.getAllAssessments();

    _topic = await _topicsDao.getMostRecentlyAccessedTopic();
    print(_topic);
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
      return AppLocalizations.of(context)?.theDueDateHasPassed ??
          "The due date has passed";
    } else if (daysLeft == 0) {
      return AppLocalizations.of(context)?.dueToday ?? "Due today";
    } else if (daysLeft == 1) {
      return AppLocalizations.of(context)?.dueTomorrow ?? "Due tomorrow";
    } else {
      return AppLocalizations.of(context)
              ?.daysLeft
              .replaceAll('{days}', "$daysLeft") ??
          "$daysLeft days remaining";
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
    var validAssessments = _assessments
        .where((assessment) =>
            parseSecondDateFromString(assessment.timeRange) != null)
        .toList();

    // Sort by due date
    validAssessments.sort((a, b) => parseSecondDateFromString(a.timeRange)!
        .compareTo(parseSecondDateFromString(b.timeRange)!));

    // Filter out already due ones
    validAssessments = validAssessments
        .where((element) => parseSecondDateFromString(element.timeRange)!
            .isAfter(DateTime.now()))
        .toList();

    // Get the soonest due date, if any
    if (validAssessments.isNotEmpty) {
      return _daysUntilDue(validAssessments.first.timeRange);
    } else {
      return AppLocalizations.of(context)?.noUpcomingDueDates ??
          "No upcoming due dates";
    }
  }

  int countOpenAssessments() {
    return _assessments.length;
  }

  @override
  Widget build(BuildContext context) {
    final topicProvider = Provider.of<TopicProvider>(context);

    return (_isLoading)
        ? LoadingScreen()
        : Scaffold(
            appBar: GlobalAppBar(callback: setLoading),
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Dashboard(
                    numAssessments: countOpenAssessments(),
                    nextDueStr: getSoonDueDate(),
                  ),
                  Visibility(
                      visible: topicProvider.recentlyAccessedTopic != null,
                      child: (topicProvider.recentlyAccessedTopic == null)
                          ? Container()
                          : RecentlyAccessed(
                              topic: topicProvider.recentlyAccessedTopic!)),
                  Card(
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          ListButton(
                            textColor:
                                Theme.of(context).textTheme.bodyMedium?.color ??
                                    AppColors.textColor,
                            color: Theme.of(context).cardColor,
                            text: AppLocalizations.of(context)?.topics ??
                                'Topics',
                            icon: Icons.book,
                            onPressed: () {
                              NavigationService.navigateToWidget(
                                  const TopicsListPage());
                            },
                            height: 70,
                          ),
                          const Divider(thickness: 0.5, height: 3),
                          ListButton(
                            textColor:
                                Theme.of(context).textTheme.bodyMedium?.color ??
                                    AppColors.textColor,
                            color: Theme.of(context).cardColor,
                            text: AppLocalizations.of(context)?.assessments ??
                                'Assessments',
                            icon: Icons.checklist,
                            onPressed: () {
                              NavigationService.navigateToWidget(
                                  const AssessmentsListPage());
                            },
                            height: 70,
                          ),
                          const Divider(thickness: 0.5, height: 3),
                          ListButton(
                            textColor:
                                Theme.of(context).textTheme.bodyMedium?.color ??
                                    AppColors.textColor,
                            color: Theme.of(context).cardColor,
                            text: AppLocalizations.of(context)?.timetable ??
                                'Timetable',
                            icon: Icons.calendar_today,
                            onPressed: () {
                              NavigationService.navigateToWidget(
                                  const TimetablePage());
                            },
                            height: 70,
                          ),
                          const Divider(thickness: 0.5, height: 3),
                          ListButton(
                            textColor:
                                Theme.of(context).textTheme.bodyMedium?.color ??
                                    AppColors.textColor,
                            color: Theme.of(context).cardColor,
                            text: AppLocalizations.of(context)?.grades ??
                                'Grades',
                            icon: Icons.star,
                            onPressed: () async {
                              NavigationService.navigateToWidget(
                                  const GradesPage());
                            },
                            height: 70,
                          ),
                          const Divider(thickness: 0.5, height: 3),
                          ListButton(
                            textColor:
                                Theme.of(context).textTheme.bodyMedium?.color ??
                                    AppColors.textColor,
                            color: Theme.of(context).cardColor,
                            text: AppLocalizations.of(context)?.settings ??
                                'Settings',
                            icon: Icons.settings,
                            onPressed: () async {
                              NavigationService.navigateToWidget(
                                  const SettingsPage());
                            },
                            height: 70,
                          ),
                          const Divider(thickness: 0.5, height: 3),
                          ListButton(
                            textColor:
                                Theme.of(context).textTheme.bodyMedium?.color ??
                                    AppColors.textColor,
                            color: Theme.of(context).cardColor,
                            text: AppLocalizations.of(context)?.refreshDb ??
                                'Refresh DB',
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
                  ),
                  const PoweredByWidget(),
                ],
              ),
            ),
          );
  }
}
