import 'package:flutter/material.dart';
import 'package:lowfound_openai_api_chat/constants/constants.dart';

import 'app_text.dart';

class AppElevatedButton extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double letterSpacing;
  final Function()? onPressed;
  final double fontSize;
  final double height;
  final double width;
  final bool enabled;
  final Color? textColor;

  AppElevatedButton({
    required this.text,
    this.fontWeight = FontWeight.bold,
    this.letterSpacing = 0.06,
    this.onPressed,
    this.fontSize = 16,
    this.height = 45,
    this.width = double.infinity,
    this.enabled = false,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        child: AppText(
          label: text,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          fontSize: fontSize,
          textColor: textColor,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
