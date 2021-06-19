import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:skeleton/api/trending_response.dart';
import 'package:skeleton/base/base_stateful_widget.dart';
import 'package:skeleton/components/text/custom_text.dart';
import 'package:skeleton/components/textstyle/custom_text_style.dart';
import 'package:skeleton/services/api_service.dart';
import 'package:skeleton/utilities/api_constants.dart';

class HomeScreen extends BaseStatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> with BasicPage {
  CancelToken _apiCancelToken = CancelToken();
  int _page = 1;

  List<Result> _results = [];

  @override
  Widget getBody(BuildContext context, Orientation orientation) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Home',
          textStyle: CustomTextStyle.getTextStyle(
            textColor: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          Result result = _results[index];
          return ListTile(
            title: CustomText(
              text: result.originalTitle,
              textStyle: CustomTextStyle.getTextStyle(
                textColor: Colors.black,
                fontSize: 16.0,
              ),
            ),
          );
        },
        itemCount: _results.length,
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

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _getMovies();
    });
  }

  @override
  void dispose() {
    super.dispose();
    apiService.cancelAPI(
      cancelToken: _apiCancelToken,
    );
  }

  _getMovies() async {
    Map<String, dynamic> response = await apiService.callAPI(
      apiMethod: HttpMethod.GET,
      url: kBaseAPI + '/movie/popular' + kAPIKeyParam + '&page=$_page',
      cancelToken: _apiCancelToken,
    );

    if (response['success']) {
      MovieListingResponse movieListingResponse =
          MovieListingResponse.fromJson(response['data']);
      if (_page == 1) {
        _results = [];
      }
      _results.addAll(movieListingResponse.results!);
      checkedMountedAndSetState();
    } else {
      showSnackbar(
        context: context,
        message: response['data']['isJsonError']
            ? response['data']['status_message']
            : response['data']['message'],
      );
    }
  }
}
