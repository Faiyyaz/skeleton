import 'package:flutter/material.dart';

/// This is custom scrollview widget class which can be use for pagination
/// Only to be used if nested listview are there

class CustomPaginationScrollView extends StatelessWidget {
  /// View to be shown inside scrollview
  final Widget child;

  /// Controller used to listen scroll
  final ScrollController scrollController;

  CustomPaginationScrollView({
    @required this.scrollController,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: child,
    );
  }
}
