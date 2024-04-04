import 'package:flutter/material.dart';
import 'package:meta_lms/utils/AppColors.dart'; // Make sure the path is correct

class ListButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? height;

  const ListButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed,
      this.color,
      this.textColor,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 25,
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon,
                color:
                    textColor ?? AppColors.textColor), // Icon aligned to start
            const SizedBox(width: 8), // Space between icon and text
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: textColor ?? AppColors.textColor),
                textAlign: TextAlign.left, // Text aligned to start
              ),
            ),
          ],
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(0.0), // Adjust the radius as needed
          ),
          backgroundColor: color ??
              Colors
                  .white, // Use the passed color or default to AppColors.primaryColor
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 8.0), // Adjust the padding as needed
        ),
      ),
    );
  }
}
