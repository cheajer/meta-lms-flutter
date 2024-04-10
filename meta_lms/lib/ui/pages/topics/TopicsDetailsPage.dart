import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/models/assessments/AssessmentDetailModel.dart';
import 'package:meta_lms/provider/AuthProvider.dart';
import 'package:meta_lms/services/ApiGateway.dart';
import 'package:meta_lms/services/NavigationService.dart';
import 'package:meta_lms/ui/pages/topics/TopicDetailsNavBar.dart';
import 'package:meta_lms/ui/pages/topics/assessments/QuizPage.dart';
import 'package:meta_lms/ui/widgets/GlobalAppBar.dart';
import 'package:meta_lms/utils/AppColors.dart';
import 'package:meta_lms/utils/HttpHelper.dart';
import 'package:meta_lms/utils/PdfViewer.dart';
import 'package:meta_lms/utils/ServiceLocator.dart';
import 'package:meta_lms/utils/VideoPlayerScreen.dart';
import 'package:meta_lms/utils/WebViewPage.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class TopicDetailsPage extends StatefulWidget {
  final Topic topic;

  const TopicDetailsPage({Key? key, required this.topic}) : super(key: key);

  @override
  _TopicDetailsPageState createState() => _TopicDetailsPageState();
}

class _TopicDetailsPageState extends State<TopicDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Current selected tab index or identifier
  String _selectedTab = 'Preparation';

  List<Resource> _resources = [];

  List<Assessment> _assessments = [];

  List<AssessmentDetailModel> _assessmentDetails = [];

  ApiGateway _apiGateway = ApiGateway();

  final List<String> _tabList = [
    'Preparation',
    'Content',
    'Assessment',
    'Forum'
  ];

  final List<IconData> _tabIconList = [
    Icons.library_books,
    Icons.content_paste,
    Icons.assignment,
    Icons.forum
  ];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize your topics list here, e.g.:
    // For now, we'll just use an empty list until you replace it with actual data.
    initialize();
  }

  void setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  Future<void> initialize() async {
    setLoading(true);
    _resources = await locator<AppDatabase>()
        .resourcesDao
        .getResourcesByTopicId(widget.topic.id);
    _assessments = await locator<AppDatabase>()
        .assessmentsDao
        .getAssessmentsByTopicId(widget.topic.id);

    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    _assessmentDetails = await _apiGateway.fetchAssessmentDetailModels(
        authProvider.getToken()!, widget.topic.id);

    print(_assessmentDetails);
    print(_assessments);
    print(_resources);

    setLoading(false);
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
    debugPrint("did this work");
  }

  bool _isValidUrl(String? url) {
    if (url == null) {
      return false;
    }

    try {
      final uri = Uri.parse(url);
      // Check if the URL has a scheme and a host
      return uri.hasScheme && uri.host.isNotEmpty;
    } catch (e) {
      // If parsing the URL throws an exception, it's not a valid URL.
      return false;
    }
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors
                  .primaryColor, // Replace with your drawer header color
            ),
            child: Column(
              children: [
                (_isValidUrl(widget.topic.imageUrl))
                    ?
                    // Correctly use Padding around the Image
                    Image.network(
                        widget.topic.imageUrl!,
                        width: MediaQuery.of(context).size.width - 100,
                        height: 90,
                        fit: BoxFit.cover, // Ensure the image covers the box
                      )
                    : Image.asset(
                        'assets/images/default.jpg',
                        width: MediaQuery.of(context).size.width - 100,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      widget.topic.topicName,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: _tabList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(_tabIconList[index]),
                  title: Text(
                    _tabList[index],
                    style: const TextStyle(
                      color: AppColors.textColor,
                    ),
                  ),
                  onTap: () {
                    // Handle tap
                    setState(() {
                      _selectedTab = _tabList[index];
                    });
                    _scaffoldKey.currentState?.closeDrawer();
                  },
                );
              }),
        ],
      ),
    );
  }

  Future<void> _playVideo(BuildContext context, String url) async {
    debugPrint(url);
    final VideoPlayerController videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(url));

    await videoPlayerController.initialize(); // Initialize the controller

    // Create a Chewie controller with additional options
    final ChewieController chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      fullScreenByDefault: true, // Open the video in fullscreen by default
    );

    // Navigate to the Chewie video player page
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            VideoPlayerScreen(chewieController: chewieController),
      ),
    );
  }

  Future<void> viewPDF(BuildContext context, String url) async {
    // Download the PDF file
    HttpHelper _httpHelper = HttpHelper();
    debugPrint("Url: " + url);

    final response = await http.get(Uri.parse(_httpHelper.getBaseUrl() + url));
    final bytes = response.bodyBytes;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/temp.pdf');

    await file.writeAsBytes(bytes, flush: true);

    // Navigate to the PDF Viewer page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PDFViewer(file: file)),
    );
  }

  Widget _buildResourceButtonByType(Resource resource) {
    switch (resource.resourceType) {
      case "video":
        return GestureDetector(
          onTap: () {
            _playVideo(context, resource.url);
          },
          child: Card(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(
                            Icons.videocam,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(resource.title,
                              style:
                                  const TextStyle(color: AppColors.textColor)),
                        )
                      ]),
                    ),
                    const Divider(),
                    Expanded(
                      child: Row(children: const [
                        Expanded(
                            child: Center(
                                child: Text("WATCH VIDEO",
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
      case "document":
        return GestureDetector(
          onTap: () {
            viewPDF(context, resource.serverPath);
          },
          child: Card(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(
                            Icons.article,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(resource.title,
                              style:
                                  const TextStyle(color: AppColors.textColor)),
                        )
                      ]),
                    ),
                    const Divider(),
                    Expanded(
                      child: Row(children: const [
                        Expanded(
                            child: Center(
                                child: Text("VIEW DOCUMENT",
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

      case "slides":
        return GestureDetector(
          onTap: () {
            viewPDF(context, resource.serverPath);
          },
          child: Card(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(
                            Icons.slideshow,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(resource.title,
                              style:
                                  const TextStyle(color: AppColors.textColor)),
                        )
                      ]),
                    ),
                    const Divider(),
                    Expanded(
                      child: Row(children: const [
                        Expanded(
                            child: Center(
                                child: Text("VIEW SLIDES",
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
      case "audio":
        break;
      case "file":
        break;
      case "link":
        return GestureDetector(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebViewPage(url: resource.url)),
            );
          },
          child: Card(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(
                            Icons.link,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(resource.title,
                              style:
                                  const TextStyle(color: AppColors.textColor)),
                        )
                      ]),
                    ),
                    const Divider(),
                    Expanded(
                      child: Row(children: const [
                        Expanded(
                            child: Center(
                                child: Text("OPEN LINK",
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

    return Container();
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

  Widget _buildAssessmentButtonByType(AssessmentDetailModel assessmentDetail) {
    switch (assessmentDetail.type) {
      case "exam":
        return GestureDetector(
          onTap: () {
            _openAssessmentExam(assessmentDetail);
          },
          child: Card(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(
                            Icons.biotech,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(assessmentDetail.name,
                              style:
                                  const TextStyle(color: AppColors.textColor)),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Chip(
                            label: Text(
                              "0% Complete",
                              style: TextStyle(fontSize: 11, color: AppColors.textColor),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _daysUntilDue(assessmentDetail.timeRange),
                            style: const TextStyle(
                                color: AppColors.textColor, fontSize: 11),
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
      case "assignment":
        return GestureDetector(
          onTap: () {
            _openAssessmentAssignment(assessmentDetail);
          },
          child: Card(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(
                            Icons.assignment,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(assessmentDetail.name,
                              style:
                                  const TextStyle(color: AppColors.textColor)),
                        ),                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Chip(
                            backgroundColor: Colors.green,
                            label: Text(
                              "100% Complete",
                              style: TextStyle(fontSize: 11, color: Colors.white),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _daysUntilDue(assessmentDetail.timeRange),
                            style: const TextStyle(
                                color: AppColors.textColor, fontSize: 11),
                          ),
                        )
                      ]),
                    ),
                    const Divider(),
                    Expanded(
                      child: Row(children: const [
                        Expanded(
                            child: Center(
                                child: Text("COMPLETE ASSIGNMENT",
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
      case "quiz":
        return GestureDetector(
          onTap: () {
            _openAssessmentQuiz(assessmentDetail);
          },
          child: Card(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(
                            Icons.quiz,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(assessmentDetail.name,
                              style:
                                  const TextStyle(color: AppColors.textColor)),
                        ),                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Chip(
                            label: Text(
                              "0% Complete",
                              style: TextStyle(fontSize: 11, color: AppColors.textColor),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _daysUntilDue(assessmentDetail.timeRange),
                            style: const TextStyle(
                                color: AppColors.textColor, fontSize: 11),
                          ),
                        )
                      ]),
                    ),
                    const Divider(),
                    Expanded(
                      child: Row(children: const [
                        Expanded(
                            child: Center(
                                child: Text("COMPLETE QUIZ",
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
      case "essay":
        return GestureDetector(
          onTap: () {
            _openAssessmentEssay(assessmentDetail);
          },
          child: Card(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(
                            Icons.book,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(assessmentDetail.name,
                              style:
                                  const TextStyle(color: AppColors.textColor)),
                        ),                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Chip(
                            backgroundColor: Colors.green,
                            label: Text(
                              "100% Complete",
                              style: TextStyle(fontSize: 11, color: Colors.white),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _daysUntilDue(assessmentDetail.timeRange),
                            style: const TextStyle(
                                color: AppColors.textColor, fontSize: 11),
                          ),
                        )
                      ]),
                    ),
                    const Divider(),
                    Expanded(
                      child: Row(children: const [
                        Expanded(
                            child: Center(
                                child: Text("COMPLETE ESSAY",
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

    return Container();
  }

  Widget _buildPreparationTab() {
    List<Resource> preparationResources = _resources
        .where((element) => element.section == "preparation")
        .toList();

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: preparationResources.length,
          itemBuilder: (context, index) {
            return _buildResourceButtonByType(preparationResources[index]);
          },
        ),
      ],
    );
  }

  Widget _buildAsessmentTab() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _assessmentDetails.length,
      itemBuilder: (context, index) {
        return Container(
          child: _buildAssessmentButtonByType(_assessmentDetails[index]),
        );
      },
    );
  }

  Widget _buildContentTab() {
    List<Resource> contentResources =
        _resources.where((element) => element.section == "content").toList();

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: contentResources.length,
          itemBuilder: (context, index) {
            return _buildResourceButtonByType(contentResources[index]);
          },
        ),
      ],
    );
  }

  Widget _buildForumTab() {
    return Column(
      children: [const Text("Forum")],
    );
  }

  Widget _buildContentForSelectedTab() {
    switch (_selectedTab) {
      case 'Preparation':
        return _buildPreparationTab();
      case 'Content':
        return _buildContentTab();
      case "Assessment":
        return _buildAsessmentTab();
      case "Forum":
        return _buildForumTab();
      default:
        return _buildPreparationTab(); // Fallback to preparation tab
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceColor,
      drawer: _buildDrawer(),
      key: _scaffoldKey,
      appBar: const GlobalAppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [
        TopicDetailsNavBar(
          title: "${widget.topic.topicName}    |    $_selectedTab",
          callback: _openDrawer,
        ),
        Expanded(
            // The rest of your screen content
            child: _buildContentForSelectedTab()),
      ]),
    );
  }
}
