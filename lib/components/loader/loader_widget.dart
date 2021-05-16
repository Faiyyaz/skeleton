import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  /// Widget to be shown after loading
  final Widget child;

  /// Boolean to toggle between loaded & loading widget
  final bool showLoader;

  LoaderWidget({
    @required this.child,
    @required this.showLoader,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: showLoader,
          child: WillPopScope(
            onWillPop: () async => !showLoader,
            child: IgnorePointer(
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
