import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// This is custom image widget class which can be use to create reusable imageview
/// This should be use if you are stacking any view on top of imageview
/// So this will return a render function only after image is loaded which you can you see add your design

class CacheImageBuilder extends StatelessWidget {
  /// Url of the image to be shown
  final String url;

  /// Height of image view
  final double height;

  /// Width of image view
  final double width;

  /// Scale type of image view (defaults to cover)
  final BoxFit boxFit;

  /// Function which we can use to render the image
  final Function getImage;

  /// This we can use in case of error for placeholder image
  final ImageProvider errorImageProvider =
      Image.asset('images/placeholder.png').image;

  CacheImageBuilder({
    @required this.url,
    @required this.height,
    @required this.width,
    @required this.getImage,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        return getImage(context, imageProvider);
      },
      placeholder: (context, data) {
        return Container(
          height: height,
          width: width,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorWidget: (context, data, error) {
        return getImage(context, errorImageProvider);
      },
    );
  }
}
