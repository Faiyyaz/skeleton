import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// This is custom image widget class which can be use to create reusable imageview

class CacheImage extends StatelessWidget {
  /// Url of the image to be shown
  final String url;

  /// Height of image view
  final double height;

  /// Width of image view
  final double width;

  /// Scale type of image view (defaults to cover)
  final BoxFit boxFit;

  CacheImage({
    required this.url,
    required this.height,
    required this.width,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: boxFit,
      placeholder: (context, url) {
        return Container(
          height: height,
          width: width,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorWidget: (context, url, error) {
        /// Here we can have a error image
        return Container(
          height: height,
          width: width,
          child: Center(
            child: Icon(Icons.error),
          ),
        );
      },
    );
  }
}
