import 'package:breach/data/breach_api.dart';
import 'package:breach/data/common/api_response_model.dart';
import 'package:breach/data/local/secure_storage.dart';
import 'package:breach/data/models/user_interest_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInterestsProvider = FutureProvider<UserInterestResponse>((ref) async {
  final authToken = await SecureStorage.instance.getAuthToken() ?? '';
  final userId = await SecureStorage.instance.getUserId() ?? '';
  final apiResult = await BreachApi.instance.getUserInterest(
    authToken: authToken,
    userId: int.parse(userId),
  );
  switch (apiResult) {
    case ApiSuccess(data: final response):
      return response;
    case ApiFailure(error: final _):
      return UserInterestResponse.empty();
  }
});
