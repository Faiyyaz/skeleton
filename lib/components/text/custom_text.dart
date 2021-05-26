import 'package:flutter/material.dart';

/// This is custom text widget class which can be use to create reusable textview

class CustomText extends StatelessWidget {
  /// Text to be shown in text widget
  final String? text;

  /// TextStyle of the text to be shown in text widget
  final TextStyle? textStyle;

  /// Maximum number of lines for text
  final int? maxLines;

  /// How to show textOverflow
  /// use TextOverflow.ellipsis for ... at the end
  final TextOverflow textOverflow;

  /// Alignment of the text
  final TextAlign alignment;

  CustomText({
    required this.text,
    required this.textStyle,
    this.maxLines,
    this.textOverflow = TextOverflow.clip,
    this.alignment = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text == null ? '' : text!,
      style: textStyle,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: alignment,
    );
  }
}
