import 'package:flutter/material.dart';
import 'package:meta_lms/database/database.dart';
import 'package:meta_lms/services/NavigationService.dart';
import 'package:meta_lms/ui/pages/topics/TopicsDetailsPage.dart';
import 'package:meta_lms/utils/AppColors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecentlyAccessed extends StatelessWidget {
  final Topic topic;
  const RecentlyAccessed({Key? key, required this.topic}) : super(key: key);

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
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.23,
              child: Column(children: [
                Expanded(
                  child: Row(children: [
                    Expanded(
                        child: Center(
                            child: Text(
                                AppLocalizations.of(context)?.lastAccessed ??
                                    "LAST ACCESSED",
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700))))
                  ]),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    NavigationService.navigateToWidget(
                        TopicDetailsPage(topic: topic));
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: Column(
                      children: <Widget>[
                        (isValidUrl(topic.imageUrl))
                            ?
                            // Correctly use Padding around the Image
                            Image.network(
                                topic.imageUrl,
                                width: MediaQuery.of(context).size.width - 100,
                                height: 90,
                                fit: BoxFit
                                    .cover, // Ensure the image covers the box
                              )
                            : Image.asset(
                                'assets/images/default.jpg',
                                width: MediaQuery.of(context).size.width - 100,
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
              ]))),
    );
  }
}
