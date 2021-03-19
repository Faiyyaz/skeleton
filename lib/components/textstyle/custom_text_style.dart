import 'package:flutter/material.dart';

class CustomTextStyle {
  /// This method is used to generated custom textStyle for buttons and text

  static TextStyle getTextStyle(
    Color textColor,
    double fontSize, {
    String fontFamily,
    FontWeight fontWeight,
  }) {
    return TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
    );
  }
}
