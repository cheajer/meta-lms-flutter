import 'package:flutter/material.dart';
import 'package:meta_lms/ui/pages/home/HomePage.dart';
import 'package:meta_lms/ui/pages/login/LoginPage.dart';
// Import pages


class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void navigateToLoginPage() {
    navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()), (Route<dynamic> route) => false);
  }

  static void navigateToHomePage() {
    navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
  }

  // A generic method to navigate to any widget
  static void navigateToWidget(Widget page) {
    navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => page));
  }

  // Pop the current screen off the navigator stack
  static void popScreen() {
    navigatorKey.currentState!.pop();
  }
}
