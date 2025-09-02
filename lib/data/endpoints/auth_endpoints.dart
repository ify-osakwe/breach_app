import 'package:breach/data/common/api_client.dart';
import 'package:breach/data/common/api_path.dart';
import 'package:breach/data/common/api_response_model.dart';
import 'package:breach/data/models/register_request.dart';
import 'package:breach/data/models/register_response.dart';

mixin AuthEndpoints {
  Future<ApiResult<RegisterResponse>> register({
    required RegisterRequest request,
  }) {
    final apiClient = ApiClient();
    return apiClient.postJson(
      ApiPath.register,
      data: request.toJson(),
      fromJsonT: RegisterResponse.fromJson,
    );
  }
}
