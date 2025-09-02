import 'package:breach/data/common/api_client.dart';
import 'package:breach/data/common/api_path.dart';
import 'package:breach/data/common/api_response_model.dart';
import 'package:breach/data/models/auth_request.dart';
import 'package:breach/data/models/auth_response.dart';

mixin AuthEndpoints {
  final _apiClient = ApiClient();
  Future<ApiResult<AuthResponse>> register({required AuthRequest request}) {
    return _apiClient.postJson(
      ApiPath.register,
      data: request.toJson(),
      fromJsonT: AuthResponse.fromJson,
    );
  }

  Future<ApiResult<AuthResponse>> login({required AuthRequest request}) {
    return _apiClient.postJson(
      ApiPath.login,
      data: request.toJson(),
      fromJsonT: AuthResponse.fromJson,
    );
  }
}
