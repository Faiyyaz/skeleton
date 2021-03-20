import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeleton/components/alignment/view_alignment.dart';

/// This is custom image widget class which can be use to create reusable circle imageview

class CircleImage extends StatelessWidget {
  /// Url of the image to be shown
  final String url;

  /// Size of image view
  final double size;

  /// Alignment of the view
  final ViewAlignment viewAlignment;

  CircleImage({
    @required this.url,
    @required this.size,
    this.viewAlignment = ViewAlignment.CENTER,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Align(
          alignment: _getAlignment(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size / 2),
            child: CachedNetworkImage(
              imageUrl: url,
              height: size,
              width: size,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Container(
                  height: size,
                  width: size,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                /// Here we can have a error image
                return Container(
                  height: size,
                  width: size,
                  child: Center(
                    child: Icon(Icons.error),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Alignment _getAlignment() {
    switch (viewAlignment) {
      case ViewAlignment.LEFT:
        return Alignment.topLeft;
        break;
      case ViewAlignment.CENTER:
        return Alignment.topCenter;
        break;
      case ViewAlignment.RIGHT:
        return Alignment.topRight;
        break;
      default:
        return Alignment.topCenter;
    }
  }
}
