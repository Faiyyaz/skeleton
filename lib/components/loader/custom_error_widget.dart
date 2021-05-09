import 'package:flutter/material.dart';
import 'package:skeleton/components/button/text/custom_text_button.dart';

class CustomErrorWidget extends StatelessWidget {
  /// Widget to be shown after loading
  final Widget child;

  /// Error String
  final String error;

  /// Boolean to toggle between loaded & loading widget
  final bool isLoading;

  /// Function to retry API call on button click
  final Function onRetry;

  CustomErrorWidget({
    @required this.child,
    @required this.error,
    @required this.isLoading,
    @required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading && error != null && error.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterLogo(
            size: 100,
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            error,
            textAlign: TextAlign.center,
          ),
          CustomTextButton(
            onButtonPress: onRetry,
            title: 'Retry',
          ),
          SizedBox(
            height: 16.0,
          ),
        ],
      );
    } else {
      return child;
    }
  }
}
