import 'package:flutter/material.dart';
import 'package:skeleton/base/base_stateful_widget.dart';
import 'package:skeleton/components/button/custom_elevated_button.dart';
import 'package:skeleton/components/text/custom_translation_text.dart';
import 'package:skeleton/components/textstyle/custom_text_style.dart';

class ExampleScreen extends BaseStatefulWidget {
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends BaseState<ExampleScreen> with BasicPage {
  String _languageCode;

  @override
  Widget getBody(BuildContext context, Orientation orientation) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTranslationText(
            text: 'hello',
            alignment: TextAlign.center,
            textStyle: CustomTextStyle.getTextStyle(
              fontSize: 16.0,
              textColor: Colors.black,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          CustomElevatedButton(
            onButtonPress: () async {
              Locale locale = await localeService.setLocale(
                language: _languageCode == 'hi' ? 'en' : 'hi',
              );
              _languageCode = locale.languageCode;
              setState(() {});
            },
            title: _languageCode,
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  @override
  bool onBackPress() {
    return false;
  }

  @override
  void initState() {
    _languageCode = localeService.getCurrentLocale().languageCode;
    super.initState();
  }
}
