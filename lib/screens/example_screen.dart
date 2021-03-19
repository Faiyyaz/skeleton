import 'package:flutter/material.dart';
import 'package:skeleton/base/base_stateful_widget.dart';
import 'package:skeleton/components/button/custom_elevated_button.dart';
import 'package:skeleton/service/api_service.dart';
import 'package:skeleton/service/dialog_service.dart';

class ExampleScreen extends BaseStatefulWidget {
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends BaseState<ExampleScreen> with BasicPage {
  String _data;

  @override
  Widget getBody(BuildContext context, Orientation orientation) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CustomElevatedButton(
          onButtonPress: () async {
            await dialogService.showLoader();
            Map<String, dynamic> data = await apiService.callAPI(
              apiMethod: HttpMethod.GET,
              url: 'https://jsonplaceholder.typicode.com/albums/1',
            );
            _data = data.toString();
            await dialogService.showSnackbar(
              SnackbarType.SUCCESS,
              data['success'].toString(),
            );
            setState(() {});
          },
          title: _data == null ? 'Fetch Data' : _data,
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  @override
  bool onBackPress() {
    return false;
  }
}
