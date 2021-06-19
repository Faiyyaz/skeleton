import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:skeleton/base/base_stateful_widget.dart';
import 'package:skeleton/components/text/custom_text.dart';
import 'package:skeleton/components/textstyle/custom_text_style.dart';
import 'package:skeleton/services/api_service.dart';
import 'package:skeleton/utilities/api_constants.dart';

class MovieDetailScreen extends BaseStatefulWidget {
  final Map<String, dynamic> map;

  MovieDetailScreen({
    required this.map,
  });

  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends BaseState<MovieDetailScreen>
    with BasicPage {
  CancelToken _apiCancelToken = CancelToken();

  @override
  Widget getBody(BuildContext context, Orientation orientation) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.map['title'],
          textStyle: CustomTextStyle.getTextStyle(
            textColor: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      body: Container(),
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
      _getMovieDetail();
    });
  }

  @override
  void dispose() {
    super.dispose();
    apiService.cancelAPI(
      cancelToken: _apiCancelToken,
    );
  }

  _getMovieDetail() async {
    Map<String, dynamic> response = await apiService.callAPI(
      apiMethod: HttpMethod.GET,
      url: kBaseAPI + '/movie/${widget.map['id']}' + kAPIKeyParam,
      cancelToken: _apiCancelToken,
    );

    if (response['success']) {
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
