import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/services/NavigationService.dart';
import 'package:meta_lms/ui/pages/topics/TopicsDetailsPage.dart';
import 'package:meta_lms/ui/widgets/GlobalAppBar.dart';
import 'package:meta_lms/ui/widgets/LoadingScreen.dart';
import 'package:meta_lms/utils/AppColors.dart';
import 'package:meta_lms/utils/ServiceLocator.dart';
// Import your database provider to access TopicsDao

class TopicsListPage extends StatefulWidget {
  const TopicsListPage({Key? key}) : super(key: key);

  @override
  _TopicsListPageState createState() => _TopicsListPageState();
}

class _TopicsListPageState extends State<TopicsListPage> {
  late List<Topic>
      topics; // This will hold your topics, fetched from the database
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    // Initialize your topics list here, e.g.:
    // For now, we'll just use an empty list until you replace it with actual data.
    topics = [];
    initialize();
  }

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> initialize() async {
    setLoading(true);
    topics = await locator<AppDatabase>().topicsDao.getAllTopics();
    setLoading(false);
  }

  bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      // Check if the URL has a scheme and a host
      return uri.hasScheme && uri.host.isNotEmpty;
    } catch (e) {
      // If parsing the URL throws an exception, it's not a valid URL.
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceColor,
      appBar: GlobalAppBar(callback: setLoading),
      body: (_isLoading)
          ? LoadingScreen()
          : ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                final topic = topics[index];
                return GestureDetector(
                  onTap: () {
                    NavigationService.navigateToWidget(
                        TopicDetailsPage(topic: topic));
                  },
                  child: Card(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.18,
                      child: Column(
                        children: <Widget>[
                          (isValidUrl(topic.imageUrl))
                              ?
                              // Correctly use Padding around the Image
                              Image.network(
                                  topic.imageUrl,
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  height: 90,
                                  fit: BoxFit
                                      .cover, // Ensure the image covers the box
                                )
                              : Image.asset(
                                  'assets/images/default.jpg',
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                          const Divider(),
                          Text(
                            topic.topicName,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
