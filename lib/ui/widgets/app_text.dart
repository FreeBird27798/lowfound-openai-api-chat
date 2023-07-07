import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  AppText(
      {Key? key,
      required this.label,
      this.fontSize = 16,
      this.fontFamily = "Roboto",
      this.textAlign = TextAlign.start,
      this.textColor = Colors.white,
      this.letterSpacing = 0.06,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  final String label;
  final double fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double letterSpacing;
  final String fontFamily;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
      ),
      textAlign: textAlign,
    );
  }
}
