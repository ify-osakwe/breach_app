class ApiError {
  final String error;
  final String message;

  const ApiError({required this.error, required this.message});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(error: json['error'], message: json['message']);
  }
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  const ApiSuccess(this.data);
}

class ApiFailure<T> extends ApiResult<T> {
  final ApiError error;
  const ApiFailure(this.error);
}

sealed class ApiResult<T> {
  const ApiResult();
}

/// Represents a successful response with no content/body.
class EmptyResponse {
  const EmptyResponse();
}
