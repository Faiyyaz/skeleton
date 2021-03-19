import 'package:flutter/material.dart';

/// This is custom button widget class which can be use to create reusable outline buttons

class CustomOutlineButton extends StatelessWidget {
  /// OnClick event of button
  final Function onButtonPress;

  /// Title of button
  final String title;

  /// Background color of button
  final Color outlineColor;

  /// Custom TextStyle of button title if any
  final TextStyle titleTextStyle;

  /// Custom height for button if any
  final double height;

  /// Custom minWidth for button if any
  final double minWidth;

  /// Padding for button if any
  final EdgeInsets buttonPadding;

  /// Corner Radius for button if any
  final double cornerRadius;

  CustomOutlineButton({
    @required this.onButtonPress,
    @required this.title,
    @required this.outlineColor,
    this.height,
    this.minWidth,
    this.titleTextStyle,
    this.buttonPadding,
    this.cornerRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        buttonTheme: _getButtonTheme(context),
      ),
      child: Center(
        child: OutlinedButton(
          onPressed: onButtonPress,
          child: Text(
            title,
          ),
          style: OutlinedButton.styleFrom(
            textStyle: _getTextStyle(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            primary: outlineColor,
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
