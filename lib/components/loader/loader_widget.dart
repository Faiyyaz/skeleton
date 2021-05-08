import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  /// Widget to be shown after loading
  final Widget child;

  /// Boolean to toggle between loaded & loading widget
  final bool isLoading;

  LoaderWidget({
    @required this.child,
    @required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: isLoading,
          child: IgnorePointer(
            child: Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
