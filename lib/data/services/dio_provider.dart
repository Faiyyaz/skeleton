import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/api_constants.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  ///Configuring Base Options
  BaseOptions baseOptions = BaseOptions(
    connectTimeout: const Duration(
      seconds: 30,
    ),
    sendTimeout: const Duration(
      seconds: 30,
    ),
    receiveTimeout: const Duration(
      seconds: 30,
    ),
  );

  Dio dio = Dio(
    baseOptions,
  );

  ///Adding Logger
  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(),
    );
  }

  ///Adding Retry
  dio.interceptors.add(
    RetryInterceptor(
      dio: dio,
      logPrint: print,
      retries: kAPIRetryCount, // retry count (optional)
      retryDelays: List.generate(
        kAPIRetryCount,
        (index) => const Duration(
          seconds: kAPIRetryInSeconds,
        ),
      ),
    ),
  );

  ///Adding Interceptor to send api key
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, RequestInterceptorHandler handler) async {
        return handler.next(options);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        if (error.response?.statusCode == 403 ||
            error.response?.statusCode == 401) {
          //TODO: Refreshing token here
          // if (isTokenRefreshed) {
          //     ///Retrying failed request which threw the refresh token response
          //     Response response = await _retry(
          //       dio,
          //       error.requestOptions,
          //     );
          //     return handler.resolve(response);
          //   } else {
          //     return handler.reject(error);
          //   }
          // } else {
          //   return handler.reject(error);
          // }
          return handler.reject(error);
        }
        return handler.reject(error);
      },
    ),
  );

  return dio;
}

Future<Response> _retry(Dio dio, RequestOptions requestOptions) {
  final options = Options(
    method: requestOptions.method,
    headers: requestOptions.headers,
  );
  return dio.request<dynamic>(
    requestOptions.path,
    data: requestOptions.data,
    queryParameters: requestOptions.queryParameters,
    options: options,
  );
}
