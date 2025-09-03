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
    if (interceptors != null) _dio.interceptors.addAll(interceptors);
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

  /// POST expecting an empty body (e.g., 201/204 with no content).
  /// Returns [EmptyResponse] on any 2xx status, even when the body is null.
  Future<ApiResult<EmptyResponse>> postEmpty(
    String path, {
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return _parse<EmptyResponse>(res, (_) => const EmptyResponse());
    } on DioException catch (e) {
      return _dioError<EmptyResponse>(e);
    } catch (_) {
      return ApiFailure<EmptyResponse>(
        ApiError(error: 'unknown', message: 'Unexpected client error'),
      );
    }
  }

  /// Fetches a JSON array and converts it into `T` using [fromJsonList].
  /// Safely handles error responses that may come back as an object.
  Future<ApiResult<T>> getJsonList<T>(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    required T Function(List<dynamic>) fromJsonList,
  }) async {
    try {
      final res = await _dio.get<dynamic>(
        path,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return _parseList(res, fromJsonList);
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

  ApiResult<T> _parseList<T>(
    Response<dynamic> res,
    T Function(List<dynamic>) fromJsonList,
  ) {
    final status = res.statusCode ?? 0;
    final is2xx = status >= 200 && status < 300;
    final data = res.data;

    if (is2xx) {
      if (data is List) {
        try {
          return ApiSuccess<T>(fromJsonList(data));
        } catch (_) {
          return ApiFailure<T>(
            ApiError(
              error: 'parse_error',
              message: 'Invalid list response format',
            ),
          );
        }
      }
      if (data is Map<String, dynamic>) {
        final looksLikeError =
            data.containsKey('error') && data.containsKey('message');
        if (looksLikeError) return ApiFailure<T>(ApiError.fromJson(data));
      }
      return ApiFailure<T>(
        ApiError(error: 'parse_error', message: 'Expected JSON array response'),
      );
    }

    if (data is Map<String, dynamic>) {
      return ApiFailure<T>(ApiError.fromJson(data));
    }
    return ApiFailure<T>(
      ApiError(
        error: 'http_$status',
        message: res.statusMessage ?? 'HTTP $status',
      ),
    );
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
