import 'package:breach/data/common/api_client.dart';
import 'package:breach/data/common/api_path.dart';
import 'package:breach/data/common/api_response_model.dart';
import 'package:breach/data/models/save_interest_request.dart';

mixin UsersEndpoints {
  final _apiClient = ApiClient();

  Future<ApiResult<EmptyResponse>> saveUserInterests({
    required String authToken,
    required int userId,
    required SaveInterestRequest request,
  }) {
    return _apiClient.postEmpty(
      ApiPath.saveUserInterest(userId),
      data: request.toJson(),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
  }
}
