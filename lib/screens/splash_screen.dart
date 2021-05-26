import 'package:firebase_messaging/firebase_messaging.dart';
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
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Center(
          child: CustomText(
            text: 'Hello',
            textStyle: CustomTextStyle.getTextStyle(
              textColor: Colors.black,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool onBackPress() {
    return false;
  }

  /// This is just like onStart of android
  @override
  void initState() {
    _checkToken();
    super.initState();
  }

  _checkToken() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      print('Got an initial notification!');
      print('Message data: ${message.data}');
    } else {
      Future.delayed(Duration(seconds: 3), () async {
        navigationService.pushNamedAndClearStack(
          routeName: '/example',
        );
      });
    }
  }

  @override
  bool shouldShowLoader() {
    return false;
  }
}
