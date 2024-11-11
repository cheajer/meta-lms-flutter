import 'package:flutter/material.dart';
import 'package:meta_lms/database/database.dart';

class TopicProvider with ChangeNotifier {
  Topic? _recentlyAccessedTopic;

  Topic? get recentlyAccessedTopic => _recentlyAccessedTopic;

  void setRecentlyAccessedTopic(Topic topic) {
    _recentlyAccessedTopic = topic;
    notifyListeners();
  }
}
