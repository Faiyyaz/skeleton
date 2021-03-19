import 'package:flutter/material.dart';

/// This is custom scrollview widget class which can be use for pagination
/// Only to be used if nested listview are there

class CustomPaginationScrollView extends StatelessWidget {
  /// View to be shown inside scrollview
  final Widget child;

  /// Function to start pagination
  final Function onPagination;

  CustomPaginationScrollView({
    @required this.onPagination,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          onPagination();
        }
        return true;
      },
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}
