import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:skeleton/services/dialog_service.dart';
import 'package:skeleton/services/local_storage_service.dart';
import 'package:skeleton/services/service_locator.dart' as serviceLocator;
import 'package:skeleton/utilities/constants.dart';
import 'package:skeleton/utilities/string_utilities.dart';

/// This class is used to access rest APIs
class APIService {
  final LocalStorageService _localStorageService =
      serviceLocator.locator<LocalStorageService>();

  final DialogService _dialogService = serviceLocator.locator<DialogService>();

  Future<Map<String, dynamic>> callAPI({
    @required HttpMethod apiMethod,
    @required String url,
    bool shouldHideLoader = true,
    Map<String, dynamic> headers,
    dynamic body,
    String contentType = Headers.jsonContentType,
  }) async {
    BaseOptions options = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      sendTimeout: 30000,
      contentType: contentType,
    );

    /// Adding custom headers if any
    if (headers != null && headers.isNotEmpty) {
      options.headers.addAll(headers);
    }

    Dio _dio = Dio(options);
    _addInterceptor(_dio);

    switch (apiMethod) {
      case HttpMethod.GET:
        try {
          Response response = await _dio.get(url);
          _hideLoader(shouldHideLoader);
          return {
            'success': true,
            'data': response.data,
          };
        } on DioError catch (e) {
          _hideLoader(shouldHideLoader);
          return _handleError(e, _dio);
        }
        break;
      case HttpMethod.POST:
        try {
          Response response = await _dio.post(url, data: body);
          _hideLoader(shouldHideLoader);
          return {
            'success': true,
            'data': response.data,
          };
        } on DioError catch (e) {
          _hideLoader(shouldHideLoader);
          return _handleError(e, _dio);
        }
        break;
      case HttpMethod.PUT:
        try {
          Response response = await _dio.put(url, data: body);
          _hideLoader(shouldHideLoader);
          return {
            'success': true,
            'data': response.data,
          };
        } on DioError catch (e) {
          _hideLoader(shouldHideLoader);
          return _handleError(e, _dio);
        }
        break;
      case HttpMethod.DELETE:
        try {
          Response response = await _dio.delete(url, data: body);
          _hideLoader(shouldHideLoader);
          return {
            'success': true,
            'data': response.data,
          };
        } on DioError catch (e) {
          _hideLoader(shouldHideLoader);
          return _handleError(e, _dio);
        }
        break;
      default:
        return null;
    }
  }

  void _addInterceptor(Dio dio) {
    /// Checking if app is in debug mode, if yes then we are adding API logger
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger());
    }

    /// Adding interceptor to add token in the request
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String authToken = await _localStorageService.getValue(
            kAuthToken,
          );
          if (authToken != null) {
            options.headers.addAll({"token": authToken});
          }
          return handler.next(options);
        },
      ),
    );
  }

  _hideLoader(bool shouldHideLoader) async {
    if (shouldHideLoader) {
      await _dialogService.hideLoader();
    }
  }

  /// Method to create custom error response
  Map<String, dynamic> _handleError(DioError error, Dio dio) {
    String url = error.requestOptions.path;
    if (kDebugMode) {
      print(url);
    }

    /// Fake statusCode
    int statusCode = 900;

    if (error.type == DioErrorType.response) {
      statusCode = error.response.statusCode;

      if (statusCode == 404) {
        return _generateError(
          statusCode,
          'Page Not Found',
        );
      } else {
        return _generateError(
          statusCode,
          error.response.data,
        );
      }
    } else if (error.type == DioErrorType.receiveTimeout) {
      return _generateError(
        statusCode,
        'Request Timed Out',
      );
    } else if (error.type == DioErrorType.connectTimeout) {
      return _generateError(
        statusCode,
        'Internet Error',
      );
    } else if (error.type == DioErrorType.sendTimeout) {
      return _generateError(
        statusCode,
        'Internet Error',
      );
    } else if (error.type == DioErrorType.other) {
      if (error.error is SocketException) {
        return _generateError(
          statusCode,
          'Internet Error',
        );
      } else if (error.error is HttpException) {
        return _generateError(
          statusCode,
          'Internet Error',
        );
      } else if (error.error is TlsException) {
        return _generateError(
          statusCode,
          'Internet Error',
        );
      } else {
        return _generateError(
          statusCode,
          StringUtilities.getExceptionMessage(
            error.error.toString(),
          ),
        );
      }
    } else {
      return _generateError(
        statusCode,
        StringUtilities.getExceptionMessage(
          error.error.toString(),
        ),
      );
    }
  }

  Map<String, dynamic> _generateError(
    int statusCode,
    String errorString,
  ) {
    return {
      'success': false,
      'data': {
        'statusCode': statusCode,
        'message': errorString,
      }
    };
  }
}

enum HttpMethod {
  GET,
  POST,
  PUT,
  DELETE,
}
