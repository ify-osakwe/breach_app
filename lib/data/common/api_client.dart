import 'package:breach/data/common/api_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final Dio _dio;
  static String baseUrl = "https://breach-api.qa.mvm-tech.xyz";

  ApiClient({List<Interceptor>? interceptors})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          contentType: 'application/json',
          responseType: ResponseType.json,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 20),
          validateStatus: (_) => true,
        ),
      ) {
    // Add caller-provided interceptors first
    if (interceptors != null) _dio.interceptors.addAll(interceptors);

    // Add a pretty logger in debug builds for convenient inspection
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 100,
        ),
      );
    }
  }

  Future<ApiResult<T>> getJson<T>(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    required T Function(Map<String, dynamic>) fromJsonT,
  }) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return _parse(res, fromJsonT);
    } on DioException catch (e) {
      return _dioError<T>(e);
    } catch (_) {
      return ApiFailure(
        ApiError(error: 'unknown', message: 'Unexpected client error'),
      );
    }
  }

  Future<ApiResult<T>> postJson<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    required T Function(Map<String, dynamic>) fromJsonT,
  }) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return _parse(res, fromJsonT);
    } on DioException catch (e) {
      return _dioError<T>(e);
    } catch (_) {
      return ApiFailure(
        ApiError(error: 'unknown', message: 'Unexpected client error'),
      );
    }
  }

  ApiResult<T> _parse<T>(
    Response<Map<String, dynamic>> res,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final status = res.statusCode ?? 0;
    final map = res.data ?? const <String, dynamic>{};

    final isErrorJson = map.containsKey('error') && map.containsKey('message');
    final is2xx = status >= 200 && status < 300;

    if (is2xx && !isErrorJson) {
      try {
        return ApiSuccess<T>(fromJsonT(map));
      } catch (_) {
        return ApiFailure<T>(
          ApiError(error: 'parse_error', message: 'Invalid response format'),
        );
      }
    }

    final error = map.isNotEmpty
        ? ApiError.fromJson(map)
        : ApiError(
            error: 'http_$status',
            message: res.statusMessage ?? 'HTTP $status',
          );
    return ApiFailure<T>(error);
  }

  ApiResult<T> _dioError<T>(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      return ApiFailure<T>(ApiError.fromJson(data));
    }
    return ApiFailure<T>(
      ApiError(error: e.type.name, message: e.message ?? 'Network error'),
    );
  }
}
