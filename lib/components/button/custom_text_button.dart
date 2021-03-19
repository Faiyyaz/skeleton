import 'package:flutter/material.dart';

/// This is custom button widget class which can be use to create reusable text buttons

class CustomTextButton extends StatelessWidget {
  /// Custom height for button if any
  final double height;

  /// Custom minWidth for button if any
  final double minWidth;

  /// OnClick event of button
  final Function onButtonPress;

  /// Title of button
  final String title;

  /// textStyle of button title
  final TextStyle titleTextStyle;

  /// Padding for button if any
  final EdgeInsets buttonPadding;

  CustomTextButton({
    @required this.onButtonPress,
    @required this.title,
    this.height,
    this.minWidth,
    this.buttonPadding,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        buttonTheme: _getButtonTheme(context),
      ),
      child: Center(
        child: TextButton(
          onPressed: onButtonPress,
          child: Text(
            title,
          ),
          style: TextButton.styleFrom(
            textStyle: _getTextStyle(context),
            padding: _getPadding(),
          ),
        ),
      ),
    );
  }

  /// This method will update the buttonTheme with custom height and width
  ButtonThemeData _getButtonTheme(BuildContext context) {
    ButtonThemeData buttonThemeData = Theme.of(context).buttonTheme;

    if (height != null) {
      buttonThemeData = buttonThemeData.copyWith(height: height);
    }

    if (minWidth != null) {
      buttonThemeData = buttonThemeData.copyWith(minWidth: minWidth);
    }

    return buttonThemeData;
  }

  /// This method will decide textTheme to be used
  TextStyle _getTextStyle(BuildContext context) {
    if (titleTextStyle == null) {
      return Theme.of(context).textTheme.button;
    } else {
      return titleTextStyle;
    }
  }

  /// This method will decide padding to be used
  EdgeInsets _getPadding() {
    if (buttonPadding != null) {
      return EdgeInsets.symmetric(horizontal: 16.0);
    } else {
      return buttonPadding;
    }
  }
}
