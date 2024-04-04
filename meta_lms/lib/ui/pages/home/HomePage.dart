import 'package:flutter/material.dart';
import 'package:meta_lms/ui/pages/home/Dashboard.dart';
import 'package:meta_lms/ui/widgets/GlobalAppBar.dart';
import 'package:meta_lms/ui/widgets/ListButton.dart';
import 'package:meta_lms/ui/widgets/LoadingScreen.dart';
import 'package:meta_lms/ui/widgets/PoweredByWidget.dart';
import 'package:meta_lms/utils/AppColors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading)
        ? LoadingScreen()
        : Scaffold(
            appBar: GlobalAppBar(callback: setLoading),
            body: Column(
              children: [
                const Dashboard(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      const Divider(color: AppColors.dividerColor, thickness: 0.5, height: 3),
                      ListButton(
                        text: 'Topics',
                        icon: Icons.book_outlined,
                        onPressed: () {},
                        height: 70,
                      ),
                      const Divider(color: AppColors.dividerColor, thickness: 0.5, height: 3),
                      ListButton(
                        text: 'Assessments',
                        icon: Icons.checklist_outlined,
                        onPressed: () {},
                        height: 70,
                      ),
                      const Divider(color: AppColors.dividerColor, thickness: 0.5, height: 3),
                      ListButton(
                        text: 'Resources',
                        icon: Icons.folder_outlined,
                        onPressed: () {},
                        height: 70,
                      ),
                      const Divider(color: AppColors.dividerColor, thickness: 0.5, height: 3),
                      ListButton(
                        text: 'Timetable',
                        icon: Icons.calendar_today_outlined,
                        onPressed: () {},
                        height: 70,
                      ),
                      const Divider(color: AppColors.dividerColor, thickness: 0.5, height: 3),
                      const PoweredByWidget(),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
