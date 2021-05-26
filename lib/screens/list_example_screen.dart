import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton/api/response/album_response.dart';
import 'package:skeleton/base/base_stateful_widget.dart';
import 'package:skeleton/components/listview/shimmer_list_view.dart';
import 'package:skeleton/components/loader/custom_error_widget.dart';
import 'package:skeleton/components/text/custom_text.dart';
import 'package:skeleton/services/api_service.dart';
import 'package:skeleton/services/dialog_service.dart';

class ListExampleScreen extends BaseStatefulWidget {
  _ListExampleScreenState createState() => _ListExampleScreenState();
}

class _ListExampleScreenState extends BaseState<ListExampleScreen>
    with BasicPage {
  List<AlbumResponse> _albums = [];
  bool _isLoading = false;
  String? _error;

  @override
  Widget getBody(BuildContext context, Orientation orientation) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomErrorWidget(
        onRetry: () {
          _isLoading = false;
          _error = null;
          setState(() {});
          _callAPI();
        },
        isLoading: _isLoading,
        error: _error,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: ShimmerListView(
            itemBuilder: (index) {
              AlbumResponse albumResponse = _albums[index];
              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: CustomText(
                  text: albumResponse.title,
                  textStyle: Theme.of(context).textTheme.subtitle2,
                ),
              );
            },
            shimmerItemBuilder: (index) {
              return Shimmer.fromColors(
                baseColor: Theme.of(context).indicatorColor,
                highlightColor: Theme.of(context).scaffoldBackgroundColor,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  padding: EdgeInsets.all(32.0),
                  color: Theme.of(context).indicatorColor,
                  child: CustomText(
                    text: 'Lorem Ipsum',
                    textStyle: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              );
            },
            itemCount: _albums.length,
            isLoaded: !_isLoading,
          ),
        ),
      ),
    );
  }

  @override
  bool onBackPress() {
    return false;
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _callAPI();
    });
  }

  _callAPI() async {
    _isLoading = true;
    setState(() {});
    Map<String, dynamic> data = await apiService.callAPI(
      apiMethod: HttpMethod.GET,
      url: 'https://jsonplaceholder.typicode.com/albums',
    );
    if (data['success']) {
      _albums = albumResponseFromJson(jsonEncode(data['data']));
      Future.delayed(Duration(seconds: 2), () async {
        _isLoading = false;
        setState(() {});
        await dialogService.showSnackbar(
          SnackbarType.SUCCESS,
          data['success'].toString(),
        );
      });
    } else {
      _isLoading = false;
      _error = data['data']['message'];
      setState(() {});
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
