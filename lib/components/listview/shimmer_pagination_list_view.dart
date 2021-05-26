import 'package:flutter/material.dart';

class ShimmerPaginationListView extends StatelessWidget {
  final int itemCount;
  final bool isPaginating;
  final bool isLoaded;
  final bool isLastPage;
  final bool isNestedScroll;
  final ScrollController scrollController;
  final Function shimmerItemBuilder;
  final Function itemBuilder;

  ShimmerPaginationListView({
    required this.itemCount,
    required this.itemBuilder,
    required this.scrollController,
    required this.isPaginating,
    required this.isLoaded,
    required this.isLastPage,
    required this.shimmerItemBuilder,
    this.isNestedScroll = false,
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
        controller: scrollController,
        padding: EdgeInsets.zero,
        shrinkWrap: isNestedScroll,
        primary: false,
        physics:
            isNestedScroll ? NeverScrollableScrollPhysics() : ScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == itemCount) {
            return _buildProgressIndicator();
          } else {
            return itemBuilder(index);
          }
        },
        itemCount: itemCount + 1,
      );
    }
  }

  Widget _buildProgressIndicator() {
    return Visibility(
      visible: !isLastPage,
      child: Opacity(
        opacity: isPaginating ? 1.0 : 0.0,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
