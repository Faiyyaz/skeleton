import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/error_response.dart';
import 'dio_provider.dart';

part 'api_service.g.dart';

@riverpod
ApiService apiService(ApiServiceRef ref) {
  return ApiService(client: ref.read(dioProvider));
}

class ApiService {
  final Dio client;

  ApiService({
    required this.client,
  });

  Future<dynamic> get({
    required String url,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await client.get(
        url,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw _handleDioError(e);
      } else {
        throw _handleNormalError(e);
      }
    }
  }

  Future<dynamic> post({
    required String url,
    CancelToken? cancelToken,
    required Map<String, dynamic>? body,
  }) async {
    try {
      Response response = await client.post(
        url,
        cancelToken: cancelToken,
        data: body,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw _handleDioError(e);
      } else {
        throw _handleNormalError(e);
      }
    }
  }

  Future<dynamic> put({
    required String url,
    CancelToken? cancelToken,
    required Map<String, dynamic>? body,
  }) async {
    try {
      Response response = await client.put(
        url,
        cancelToken: cancelToken,
        data: body,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw _handleDioError(e);
      } else {
        throw _handleNormalError(e);
      }
    }
  }

  Future<dynamic> delete({
    required String url,
    CancelToken? cancelToken,
    Map<String, dynamic>? body,
  }) async {
    try {
      Response response = await client.delete(
        url,
        cancelToken: cancelToken,
        data: body,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw _handleDioError(e);
      } else {
        throw _handleNormalError(e);
      }
    }
  }

  Future<dynamic> cancel({
    required CancelToken cancelToken,
  }) async {
    try {
      cancelToken.cancel();
    } catch (e) {
      rethrow;
    }
  }

  ErrorResponse _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ErrorResponse(
          statusCode: 900,
          statusMessage: 'You are not connected to Internet!',
        );
      case DioExceptionType.cancel:
        return ErrorResponse(
          statusCode: 900,
          statusMessage: '',
        );
      case DioExceptionType.unknown:
        return ErrorResponse(
          statusCode: 900,
          statusMessage: 'Something went wrong please try again!',
        );
      case DioExceptionType.badResponse:
      case DioExceptionType.badCertificate:
        if (e.response != null) {
          return ErrorResponse(
            statusCode: e.response!.statusCode ?? 900,
            statusMessage: 'Something went wrong',
          );
        } else {
          return ErrorResponse(
            statusCode: 900,
            statusMessage: 'Something went wrong please try again!',
          );
        }
    }
  }

  ErrorResponse _handleNormalError(Object e) {
    return ErrorResponse(
      statusCode: 900,
      statusMessage: 'Something went wrong please try again!',
    );
  }
}
