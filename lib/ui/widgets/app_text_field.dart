import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lowfound_openai_api_chat/constants/constants.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final double fontSize;
  final double hintFontSize;
  final double height;
  final double width;
  final double iconSize;
  final FontWeight fontWeight;
  final FontWeight hintFontWeight;
  final bool obscureText;
  final bool readOnly;
  final String? image;
  final IconData? icon;
  final bool enablePadding;
  final int maxLines;
  final int? maxLength;
  final void Function(String value)? onChanged;

  AppTextField(
      {required this.hintText,
      required this.textEditingController,
      this.keyboardType = TextInputType.text,
      this.fontSize = 17,
      this.hintFontSize = 16,
      this.height = 45,
      this.width = double.infinity,
      this.iconSize = 24,
      this.maxLines = 1,
      this.maxLength,
      this.fontWeight = FontWeight.w400,
      this.hintFontWeight = FontWeight.w600,
      this.obscureText = false,
      this.readOnly = false,
      this.image,
      this.icon,
      this.enablePadding = false,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor =
        theme.brightness == Brightness.light ? blueColor : Colors.white;

    final style = TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: 'Roboto',
    );
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        autofocus: false,
        readOnly: readOnly,
        style: style,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        controller: textEditingController,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          counterText: '',
          contentPadding: enablePadding ? EdgeInsetsDirectional.all(16) : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: greyColor, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: blueColor, width: 2),
          ),
          hintText: hintText,
          prefixIconConstraints: BoxConstraints(),
          prefixIcon: image != null
              ? Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    'images/${image}.svg',
                  ),
                )
              : icon != null
                  ? Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        icon,
                        color: iconColor,
                        size: iconSize,
                      ),
                    )
                  : null,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
