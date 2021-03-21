import 'package:skeleton/components/alignment/view_alignment.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// This is custom button widget class which can be use to create reusable translated outline buttons

class CustomTranslationOutlineButton extends StatelessWidget {
  /// OnClick event of button
  final Function onButtonPress;

  /// Title of button
  final String title;

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

  /// Alignment of the view
  final ViewAlignment viewAlignment;

  /// Background color of button
  final Color backgroundColor;

  CustomTranslationOutlineButton({
    @required this.onButtonPress,
    @required this.title,
    @required this.backgroundColor,
    this.height,
    this.minWidth,
    this.titleTextStyle,
    this.buttonPadding,
    this.cornerRadius = 0.0,
    this.viewAlignment = ViewAlignment.CENTER,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Align(
          alignment: _getAlignment(),
          child: OutlinedButton(
            onPressed: onButtonPress,
            child: Text(
              title,
            ).tr(),
            style: OutlinedButton.styleFrom(
              minimumSize: _getMinimumSize(context),
              textStyle: _getTextStyle(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(cornerRadius),
              ),
              primary: backgroundColor,
              padding: _getPadding(),
            ),
          ),
        ),
      ],
    );
  }

  /// This method will return size of button
  Size _getMinimumSize(BuildContext context) {
    ButtonThemeData buttonThemeData = Theme.of(context).buttonTheme;

    if (height != null) {
      buttonThemeData = buttonThemeData.copyWith(height: height);
    }

    if (minWidth != null) {
      buttonThemeData = buttonThemeData.copyWith(minWidth: minWidth);
    }

    return Size(
      buttonThemeData.minWidth,
      buttonThemeData.height,
    );
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

  Alignment _getAlignment() {
    switch (viewAlignment) {
      case ViewAlignment.LEFT:
        return Alignment.bottomLeft;
        break;
      case ViewAlignment.CENTER:
        return Alignment.bottomCenter;
        break;
      case ViewAlignment.RIGHT:
        return Alignment.bottomRight;
        break;
      default:
        return Alignment.bottomCenter;
    }
  }
}
