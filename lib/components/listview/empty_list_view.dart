import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skeleton/components/listview/listview_direction.dart';

/// This is custom listview widget class which can be use to create reusable listview with empty view

class CustomListView extends StatelessWidget {
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

  CustomListView({
    required this.itemCount,
    required this.itemBuilder,
    required this.isEmpty,
    required this.shouldShowView,
    this.emptyView,
    this.isNestedScroll = false,
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
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => separator!,
          shrinkWrap: isNestedScroll,
          primary: false,
          itemBuilder: (context, index) {
            return itemBuilder(index);
          },
          itemCount: itemCount,
        );
      } else {
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: isNestedScroll,
          primary: false,
          itemBuilder: (context, index) {
            return itemBuilder(index);
          },
          itemCount: itemCount,
        );
      }
    } else {
      if (separator != null) {
        return Container(
          height: horizontalListHeight,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => separator!,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return itemBuilder(index);
            },
            itemCount: itemCount,
          ),
        );
      } else {
        return Container(
          height: horizontalListHeight,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return itemBuilder(index);
            },
            itemCount: itemCount,
          ),
        );
      }
    }
  }
}
