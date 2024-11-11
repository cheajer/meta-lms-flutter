import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_lms/utils/AppColors.dart'; // Ensure the path is correct

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Centers content horizontally
      children: [
        SvgPicture.asset(
          'assets/icons/logo.svg',
          width: 40,
        ),
        const SizedBox(width: 10), // Adds space between the logo and text
        Text(
          'METALMS',
          style: TextStyle(
            fontSize: 20, // You can adjust the size
            fontFamily: "Oswald",
            color: Theme.of(context).textTheme.bodyMedium?.color ?? AppColors.textColor, // Use a custom color from AppColors
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
      ],
    );
  }
}
