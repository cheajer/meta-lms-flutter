import 'package:flutter/material.dart';
import 'package:meta_lms/utils/AppColors.dart'; // Make sure the path is correct

class NamedBoxButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? height;

  const NamedBoxButton(
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
            Icon(icon, color: textColor ?? Colors.white), // Icon aligned to start
            const SizedBox(width: 8), // Space between icon and text
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: textColor ?? Colors.white),
                textAlign: TextAlign.left, // Text aligned to start
              ),
            ),
          ],
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ??
              AppColors
                  .primaryColor, // Use the passed color or default to AppColors.primaryColor
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(5.0), // Adjust the radius as needed
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0), // Adjust the padding as needed
        ),
      ),
    );
  }
}
