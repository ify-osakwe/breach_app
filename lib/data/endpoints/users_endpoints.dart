import 'package:breach/data/common/api_client.dart';
import 'package:breach/data/common/api_path.dart';
import 'package:breach/data/common/api_response_model.dart';
import 'package:breach/data/models/user_interest_request.dart';
import 'package:breach/data/models/user_interest_response.dart';

mixin UsersEndpoints {
  final _apiClient = ApiClient();

  Future<ApiResult<EmptyResponse>> saveUserInterests({
    required String authToken,
    required int userId,
    required UserInterestRequest request,
  }) {
    return _apiClient.postEmpty(
      ApiPath.saveUserInterest(userId),
      data: request.toJson(),
      headers: {'Authorization': 'Bearer $authToken'},
    );
  }

  Future<ApiResult<UserInterestResponse>> getUserInterest({
    required String authToken,
    required int userId,
  }) {
    return _apiClient.getJsonList(
      ApiPath.getUserInterest(userId),
      fromJsonList: UserInterestResponse.fromJsonList,
      headers: {'Authorization': 'Bearer $authToken'},
    );
  }
}
