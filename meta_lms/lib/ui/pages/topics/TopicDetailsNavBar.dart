import 'package:flutter/material.dart';
import 'package:meta_lms/utils/AppColors.dart';

class TopicDetailsNavBar extends StatelessWidget {
  final String title;
  final Function() callback;
  const TopicDetailsNavBar({Key? key, required this.title, required this.callback}) : super(key: key);

  void _test() {
    debugPrint("testt");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width,
        child: Material(
          elevation: 1,
          color: AppColors.primaryColor,
          child: Row(children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white,),
              color: Colors.white,
              onPressed: callback,
            ),
            Text(title, style: const TextStyle(color: Colors.white))
          ]),
        ));
  }
}
