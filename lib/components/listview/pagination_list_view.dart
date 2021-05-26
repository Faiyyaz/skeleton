import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skeleton/components/listview/listview_direction.dart';

/// This is custom listview widget class which can be use to create reusable listview with empty view & pagination

class CustomPaginationListView extends StatelessWidget {
  /// View to be shown if list is empty
  final Widget? emptyView;

  /// List count
  final int itemCount;

  /// Function used to render item
  final Function itemBuilder;

  /// Should render view (This is used to wait for response)
  final bool shouldShowView;

  /// This is used when listview is inside scrollview
  final bool isNestedScroll;

  /// Separator Widget - This is used when list required separator
  final Widget? separator;

  /// Height for horizontal list
  final double? horizontalListHeight;

  /// scrollDirection of list
  final ListViewDirection scrollDirection;

  /// If list is empty or not
  final bool isEmpty;

  /// Controller used to listen scroll
  final ScrollController scrollController;

  /// To check if its paginating
  final bool isPaginating;

  /// To know if its last page
  final bool isLastPage;

  CustomPaginationListView({
    required this.itemCount,
    required this.itemBuilder,
    required this.scrollController,
    required this.isEmpty,
    required this.isLastPage,
    required this.shouldShowView,
    this.emptyView,
    this.isNestedScroll = false,
    this.isPaginating = false,
    this.separator,
    this.horizontalListHeight,
    this.scrollDirection = ListViewDirection.VERTICAL,
  });

  @override
  Widget build(BuildContext context) {
    if (shouldShowView && isEmpty) {
      if (emptyView != null) {
        return emptyView!;
      } else {
        return SizedBox(
          height: 0,
        );
      }
    } else if (shouldShowView && !isEmpty) {
      return _getListView(scrollDirection);
    } else {
      return Container();
    }
  }

  Widget _getListView(ListViewDirection scrollDirection) {
    if (scrollDirection == ListViewDirection.VERTICAL) {
      if (separator != null) {
        return ListView.separated(
          controller: scrollController,
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => separator!,
          shrinkWrap: isNestedScroll,
          physics:
              isNestedScroll ? NeverScrollableScrollPhysics() : ScrollPhysics(),
          primary: false,
          itemBuilder: (context, index) {
            if (index == itemCount) {
              return _buildProgressIndicator();
            } else {
              return itemBuilder(index);
            }
          },
          itemCount: itemCount + 1,
        );
      } else {
        return ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.zero,
          shrinkWrap: isNestedScroll,
          physics:
              isNestedScroll ? NeverScrollableScrollPhysics() : ScrollPhysics(),
          primary: false,
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
    } else {
      if (separator != null) {
        return Container(
          height: horizontalListHeight,
          child: ListView.separated(
            controller: scrollController,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => separator!,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == itemCount) {
                return _buildProgressIndicator();
              } else {
                return itemBuilder(index);
              }
            },
            itemCount: itemCount + 1,
          ),
        );
      } else {
        return Container(
          height: horizontalListHeight,
          child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == itemCount) {
                return _buildProgressIndicator();
              } else {
                return itemBuilder(index);
              }
            },
            itemCount: itemCount + 1,
          ),
        );
      }
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
