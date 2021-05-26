import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// This is custom text widget class which can be use to create reusable translated textview
class CustomTranslationText extends StatelessWidget {
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

  /// Dynamic text to append
  final Map<String, String>? args;

  CustomTranslationText({
    required this.text,
    required this.textStyle,
    this.maxLines,
    this.args,
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
    ).tr(
      namedArgs: args,
    );
  }
}
