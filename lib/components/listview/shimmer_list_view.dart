import 'package:flutter/material.dart';

class ShimmerListView extends StatelessWidget {
  final int itemCount;
  final bool isLoaded;
  final Function shimmerItemBuilder;
  final Function itemBuilder;

  ShimmerListView({
    required this.itemCount,
    required this.itemBuilder,
    required this.shimmerItemBuilder,
    required this.isLoaded,
  });

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      if (isLoaded) {
        return SizedBox(
          height: 0,
        );
      } else {
        return ListView.builder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return shimmerItemBuilder(index);
          },
          itemCount: 20,
        );
      }
    } else {
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return itemBuilder(index);
        },
        itemCount: itemCount,
      );
    }
  }
}
