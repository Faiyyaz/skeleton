import 'package:flutter/material.dart';
import 'package:skeleton/base/base_stateful_widget.dart';
import 'package:skeleton/components/button/elevated/custom_elevated_button.dart';
import 'package:skeleton/services/api_service.dart';
import 'package:skeleton/services/dialog_service.dart';

class ExampleScreen extends BaseStatefulWidget {
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends BaseState<ExampleScreen> with BasicPage {
  bool _isLoading = false;
  String _data;

  @override
  Widget getBody(BuildContext context, Orientation orientation) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CustomElevatedButton(
          onButtonPress: () {
            _callAPI();
          },
          title: _data == null ? 'Fetch Data' : _data,
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  @override
  bool onBackPress() {
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  _callAPI() async {
    _isLoading = true;
    checkedMountedAndSetState();
    Map<String, dynamic> data = await apiService.callAPI(
      apiMethod: HttpMethod.GET,
      url: 'https://jsonplaceholder.typicode.com/albums/1',
    );
    if (data['success']) {
      _data = data['data'].toString();
      Future.delayed(Duration(seconds: 2), () async {
        _isLoading = false;
        checkedMountedAndSetState();
        await dialogService.showSnackbar(
          SnackbarType.SUCCESS,
          data['success'].toString(),
        );
      });
    } else {
      _isLoading = false;
      _data = data['data']['message'];
      checkedMountedAndSetState();
      await dialogService.showSnackbar(
        SnackbarType.ERROR,
        data['data']['message'].toString(),
      );
    }
  }

  @override
  bool shouldShowLoader() {
    return _isLoading;
  }
}
