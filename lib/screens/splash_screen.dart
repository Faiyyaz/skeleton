import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeleton/base/base_stateful_widget.dart';
import 'package:skeleton/components/text/custom_text.dart';
import 'package:skeleton/components/textstyle/custom_text_style.dart';

class SplashScreen extends BaseStatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> with BasicPage {
  @override
  Widget getBody(BuildContext context, Orientation orientation) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Container(
          child: Center(
            child: CustomText(
              text: 'Hello',
              textStyle: CustomTextStyle.getTextStyle(
                textColor: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool onBackPress() {
    return true;
  }

  @override
  bool shouldShowLoader() {
    return false;
  }
}
