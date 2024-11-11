import 'package:flutter/material.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/models/assessments/AssessmentDetailModel.dart';
import 'package:meta_lms/provider/AuthProvider.dart';
import 'package:meta_lms/services/ApiGateway.dart';
import 'package:meta_lms/services/NavigationService.dart';
import 'package:meta_lms/ui/pages/topics/assessments/QuizPage.dart';
import 'package:meta_lms/ui/widgets/GlobalAppBar.dart';
import 'package:meta_lms/ui/widgets/LoadingScreen.dart';
import 'package:meta_lms/utils/AppColors.dart';
import 'package:meta_lms/utils/ServiceLocator.dart';
import 'package:provider/provider.dart';

class AssessmentsListPage extends StatefulWidget {
  const AssessmentsListPage({Key? key}) : super(key: key);

  @override
  _AssessmentsListPageState createState() => _AssessmentsListPageState();
}

class _AssessmentsListPageState extends State<AssessmentsListPage> {
  late List<Assessment> dehydratedAssessments;
  Map<int, List<AssessmentDetailModel>> groupedAssessments = {};
  Map<int, List<AssessmentDetailModel>> filteredGroupedAssessments = {};
  Map<int, String> topicNameCache = {}; // Cache for topic names
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  final ApiGateway _apiGateway = ApiGateway();

  @override
  void initState() {
    super.initState();
    dehydratedAssessments = [];
    initialize();
    _searchController.addListener(_filterAssessments);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> initialize() async {
    setLoading(true);

    // Fetch dehydrated assessments
    dehydratedAssessments =
        await locator<AppDatabase>().assessmentsDao.getAllAssessments();

    // Extract unique topic IDs
    Set<int> uniqueTopicIds =
        dehydratedAssessments.map((a) => a.topicId).toSet();

    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    String? token = authProvider.getToken();

    await _cacheTopicNames(uniqueTopicIds);

    // Fetch detailed assessments and group by topic ID
    for (int topicId in uniqueTopicIds) {
      List<AssessmentDetailModel> detailedAssessments =
          await _apiGateway.fetchAssessmentDetailModels(token!, topicId);
      groupedAssessments[topicId] = detailedAssessments;
    }

    filteredGroupedAssessments = Map.from(groupedAssessments);
    setLoading(false);
  }

  Future<void> _cacheTopicNames(Set<int> topicIds) async {
    for (int topicId in topicIds) {
      // Fetch the topic name only if it is not already cached
      if (!topicNameCache.containsKey(topicId)) {
        String? topicName =
            await locator<AppDatabase>().topicsDao.getTopicNameById(topicId);
        topicNameCache[topicId] = topicName ?? "Unknown Topic";
      }
    }
  }

  void _filterAssessments() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        // Reset to show all assessments if the query is empty
        filteredGroupedAssessments = Map.from(groupedAssessments);
      } else {
        filteredGroupedAssessments =
            groupedAssessments.map((topicId, assessments) {
          // Check if the topic name contains the query
          final topicName = topicNameCache[topicId]?.toLowerCase() ?? "";
          if (topicName.contains(query)) {
            return MapEntry(topicId, assessments);
          } else {
            return MapEntry(topicId, []);
          }
        })
              ..removeWhere((_, assessments) => assessments.isEmpty);
      }
    });
  }

  Future<String> getTopicNameById(int topicId) async {
    String? topicName =
        await locator<AppDatabase>().topicsDao.getTopicNameById(topicId);
    return topicName ?? "Unknown Topic";
  }

  void _openAssessmentExam(AssessmentDetailModel assessmentDetail) {
    NavigationService.navigateToWidget(QuizPage(assessment: assessmentDetail));
  }

  void _openAssessmentQuiz(AssessmentDetailModel assessmentDetail) {
    NavigationService.navigateToWidget(QuizPage(assessment: assessmentDetail));
  }

  void _openAssessmentEssay(AssessmentDetailModel assessmentDetail) {
    NavigationService.navigateToWidget(QuizPage(assessment: assessmentDetail));
  }

  void _openAssessmentAssignment(AssessmentDetailModel assessmentDetail) {
    NavigationService.navigateToWidget(QuizPage(assessment: assessmentDetail));
  }

  DateTime? _parseSecondDateFromString(String dateString) {
    try {
      // Split the string by 'to' to separate the dates
      List<String> parts = dateString.split(' to ');

      // Check if we have exactly two parts after splitting
      if (parts.length == 2) {
        // The second part is the date string we are interested in
        String secondDateString = parts[1];

        // Split the date string by '/' to separate year, month, and day
        List<String> dateParts = secondDateString.split('/');

        // Check if we have exactly three parts for year, month, and day
        if (dateParts.length == 3) {
          // Parse the year, month, and day into integers
          int year = int.parse(dateParts[0]);
          int month = int.parse(dateParts[1]);
          int day = int.parse(dateParts[2]);

          // Return the DateTime object
          return DateTime(year, month, day);
        }
      }
    } catch (e) {
      // If any error occurs, print it to the console and return null
      print('Error parsing date: $e');
    }
    // Return null if the string format is incorrect or parsing fails
    return null;
  }

  String _daysUntilDue(String dateString) {
    DateTime? dueDate = _parseSecondDateFromString(dateString);

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
      return "$daysLeft days remaining";
    }
  }

  IconData _getAssessmentIcon(assessmentType) {
    switch (assessmentType) {
      case "exam":
        return Icons.biotech;
      case "assignment":
        return Icons.assignment;
      case "quiz":
        return Icons.quiz;
      case "essay":
        return Icons.bookmark;
    }
    return Icons.assignment;
  }

  Widget _buildAssessmentList(
      int topicId, List<AssessmentDetailModel> assessments) {
    String topicName = topicNameCache[topicId] ?? "Unknown Topic";

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
        collapsedBackgroundColor: Theme.of(context).cardColor,
        leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/default.jpg')),
        title: Text(
          topicName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        children: assessments.map(_buildAssessmentButtonByType).toList(),
      ),
    );
  }

  Widget _buildAssessmentButtonByType(AssessmentDetailModel assessmentDetail) {
    return GestureDetector(
      onTap: () {
        switch (assessmentDetail.type) {
          case "exam":
            _openAssessmentExam(assessmentDetail);
            break;
          case "assignemnt":
            _openAssessmentAssignment(assessmentDetail);
            break;
          case "quiz":
            _openAssessmentQuiz(assessmentDetail);
            break;
          case "essay":
            _openAssessmentEssay(assessmentDetail);
            break;
        }
      },
      child: Card(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: [
                Expanded(
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        _getAssessmentIcon(assessmentDetail.type),
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(assessmentDetail.name,
                          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color ?? AppColors.textColor)),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        label: Text(
                          "0% Complete",
                          style: TextStyle(
                              fontSize: 11, color: Theme.of(context).textTheme.bodyMedium?.color ?? AppColors.textColor),
                        ),
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: Row(children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _daysUntilDue(assessmentDetail.timeRange),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color ?? AppColors.textColor, fontSize: 11),
                      ),
                    )
                  ]),
                ),
                const Divider(),
                Expanded(
                  child: Row(children: const [
                    Expanded(
                        child: Center(
                            child: Text("COMPLETE EXAM",
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700))))
                  ]),
                ),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
      appBar: GlobalAppBar(callback: setLoading, elevation: 0),
      body: _isLoading
          ? LoadingScreen()
          : Column(
              children: [
                // Search Bar
                Material(
                  elevation: 1,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Theme.of(context).cardColor,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by topic...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: filteredGroupedAssessments.length,
                      itemBuilder: (context, index) {
                        int topicId =
                            filteredGroupedAssessments.keys.elementAt(index);
                        List<AssessmentDetailModel> assessments =
                            filteredGroupedAssessments[topicId]!;
                        return _buildAssessmentList(topicId, assessments);
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
