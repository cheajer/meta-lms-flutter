import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meta_lms/provider/AuthProvider.dart';
import 'package:meta_lms/provider/TopicProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:meta_lms/ui/pages/login/LoginPage.dart';
import 'package:meta_lms/services/NavigationService.dart';
import 'package:meta_lms/utils/AppThemes.dart';
import 'package:meta_lms/utils/LocaleProvider.dart';
import 'package:meta_lms/utils/ServiceLocator.dart';
import 'package:meta_lms/utils/ThemeNotifier.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TopicProvider()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  /// InheritedWidget style accessor to our State object.
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  final Widget _defaultHome = const LoginPage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'MetaLMS',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.isDarkMode?ThemeMode.dark:ThemeMode.light,
      locale: localeProvider.locale,
      home: _defaultHome,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('zh', ''),
      ],
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}
