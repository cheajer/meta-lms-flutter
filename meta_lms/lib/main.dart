import 'package:flutter/material.dart';
import 'package:meta_lms/provider/AuthProvider.dart';
import 'package:meta_lms/ui/pages/home/HomePage.dart'; // Adjust the import path as necessary
import 'package:meta_lms/ui/pages/login/LoginPage.dart';
import 'package:meta_lms/services/NavigationService.dart';
import 'package:meta_lms/utils/AppColors.dart';
import 'package:meta_lms/utils/ServiceLocator.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Widget _defaultHome = const LoginPage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          backgroundColor: AppColors.backgroundColor,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          primarySwatch: AppColors.createPrimaryMaterialColor(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _defaultHome,
        navigatorKey: NavigationService.navigatorKey,
      ),
    );
  }
}
