import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// These variables are not class dependent i.e. there value will remains the same irrespective of loader class objects

/// State whether loader is showing or not
bool _isShowing = false;

/// Context of current page and dismissing page
BuildContext _context, _dismissingContext;

/// This decide whether the loader can be close if click outside or not
bool _barrierDismissible = false;

/// Duration of appear/disappear animation
int _duration = 200;

/// Whether to show background overlay or not
bool _showBackgroundColor = true;

/// This is custom loader widget class which can be use to create reusable loader

class Loader {
  Loader({
    @required BuildContext context,
    bool isDismissible,
    int duration,
    bool showBackgroundColor,
  }) {
    _context = context;
    _barrierDismissible = isDismissible ?? false;
  }

  /// This function returns whether the loader is showing or not
  bool isShowing() {
    return _isShowing;
  }

  /// This function hides the loader
  Future<bool> hide() async {
    try {
      if (_isShowing) {
        _isShowing = false;
        Navigator.of(_dismissingContext).pop();
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (err) {
      debugPrint('Seems there is an issue hiding dialog');
      debugPrint(err.toString());
      return Future.value(false);
    }
  }

  /// This function shows the loader
  Future<bool> show() async {
    try {
      if (!_isShowing) {
        final ThemeData theme = Theme.of(_context);
        showGeneralDialog(
          context: _context,
          pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            final Widget pageChild = Builder(
              builder: (BuildContext context) {
                _dismissingContext = context;
                return AnnotatedRegion(
                  value: SystemUiOverlayStyle.light,
                  child: WillPopScope(
                    onWillPop: () async => _barrierDismissible,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              },
            );
            return Builder(
              builder: (BuildContext context) {
                return theme != null
                    ? Theme(data: theme, child: pageChild)
                    : pageChild;
              },
            );
          },
          barrierDismissible: _barrierDismissible,
          barrierLabel:
              MaterialLocalizations.of(_context).modalBarrierDismissLabel,
          barrierColor:
              _showBackgroundColor ? Colors.black.withOpacity(0.7) : null,
          transitionDuration: Duration(milliseconds: _duration),
          transitionBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
        // Delaying the function for 200 milliseconds
        // [Default transitionDuration of DialogRoute]
        await Future.delayed(Duration(milliseconds: _duration));
        _isShowing = true;
        return true;
      } else {
        return false;
      }
    } catch (err) {
      _isShowing = false;
      debugPrint('Exception while showing the dialog');
      debugPrint(err.toString());
      return false;
    }
  }
}
