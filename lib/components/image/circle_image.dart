import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// This is custom image widget class which can be use to create reusable circle imageview

class CircleImage extends StatelessWidget {
  /// Url of the image to be shown
  final String url;

  /// Size of image view
  final double size;

  CircleImage({
    @required this.url,
    @required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
    );
  }
}
