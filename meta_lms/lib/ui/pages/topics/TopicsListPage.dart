import 'package:flutter/material.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/services/NavigationService.dart';
import 'package:meta_lms/ui/pages/topics/TopicsDetailsPage.dart';
import 'package:meta_lms/ui/widgets/GlobalAppBar.dart';
import 'package:meta_lms/ui/widgets/LoadingScreen.dart';
import 'package:meta_lms/utils/AppColors.dart';
import 'package:meta_lms/utils/ServiceLocator.dart';

class TopicsListPage extends StatefulWidget {
  const TopicsListPage({Key? key}) : super(key: key);

  @override
  _TopicsListPageState createState() => _TopicsListPageState();
}

class _TopicsListPageState extends State<TopicsListPage> {
  late List<Topic> topics;
  late List<Topic> filteredTopics;
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  int? selectedTopicGroupId;
  bool showArchived = false;

  @override
  void initState() {
    super.initState();
    topics = [];
    filteredTopics = [];
    initialize();
    _searchController.addListener(_filterTopics);
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
    topics = await locator<AppDatabase>().topicsDao.getAllTopics();
    filteredTopics = topics;
    setLoading(false);
  }

  void _filterTopics() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredTopics = topics.where((topic) {
        final matchesQuery = topic.topicName.toLowerCase().contains(query);
        final matchesGroupId = selectedTopicGroupId == null ||
            topic.topicGroupId == selectedTopicGroupId;
        final matchesArchived = !showArchived || topic.archived == true;
        return matchesQuery && matchesGroupId && matchesArchived;
      }).toList();

      filteredTopics.sort((a, b) {
        final aLastAccessed =
            a.lastAccessed ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bLastAccessed =
            b.lastAccessed ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bLastAccessed.compareTo(aLastAccessed);
      });
      filteredTopics = filteredTopics;
    });
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int? tempGroupId = selectedTopicGroupId;
        bool tempShowArchived = showArchived;

        return AlertDialog(
          title: const Text('Filter Topics'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dropdown for Topic Group
              DropdownButton<int?>(
                value: tempGroupId,
                isExpanded: true,
                hint: const Text('Select Topic Group'),
                items: [
                  DropdownMenuItem(value: null, child: Text('All Groups')),
                  DropdownMenuItem(value: 1, child: Text('Group 1')),
                  DropdownMenuItem(value: 2, child: Text('Group 2')),
                  DropdownMenuItem(value: 3, child: Text('Group 3')),
                ],
                onChanged: (value) {
                  setState(() {
                    tempGroupId = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Checkbox for Archived Filter
              CheckboxListTile(
                title: const Text('Show Archived'),
                value: tempShowArchived,
                onChanged: (bool? value) {
                  setState(() {
                    tempShowArchived = value ?? false;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedTopicGroupId = tempGroupId;
                  showArchived = tempShowArchived;
                });
                _filterTopics();
                Navigator.of(context).pop();
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
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
                // Search Bar with Filter Button
                Material(
                  elevation: 1,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Theme.of(context).cardColor,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Search topics...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.filter_list),
                          onPressed: () => _showFilterDialog(context),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTopics.length,
                    itemBuilder: (context, index) {
                      final topic = filteredTopics[index];
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
                                            MediaQuery.of(context).size.width -
                                                100,
                                        height: 90,
                                        fit: BoxFit
                                            .cover, // Ensure the image covers the box
                                      )
                                    : Image.asset(
                                        'assets/images/default.jpg',
                                        width:
                                            MediaQuery.of(context).size.width -
                                                100,
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
                ),
              ],
            ),
    );
  }
}
