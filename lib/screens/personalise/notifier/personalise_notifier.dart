// ignore_for_file: use_build_context_synchronously

import 'package:breach/data/breach_api.dart';
import 'package:breach/data/common/api_response_model.dart';
import 'package:breach/data/local/secure_storage.dart';
import 'package:breach/data/models/categories_list_reponse.dart';
import 'package:breach/data/models/user_interest_request.dart';
import 'package:breach/routes/routes.dart';
import 'package:breach/screens/personalise/model/personalise_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final categoriesProvider = FutureProvider<CategoriesListResponse>((ref) async {
  final apiResult = await BreachApi.instance.getCategories();
  switch (apiResult) {
    case ApiSuccess(data: final response):
      return response;
    case ApiFailure(error: final _):
      return CategoriesListResponse.empty();
  }
});

final personaliseProvider =
    NotifierProvider<PersonaliseNotifier, PersonaliseState>(
      PersonaliseNotifier.new,
    );

class PersonaliseNotifier extends Notifier<PersonaliseState> {
  @override
  PersonaliseState build() {
    return PersonaliseState(isLoading: false);
  }

  Future<void> saveUserInterests(List<int> ids, BuildContext context) async {
    final userId = await SecureStorage.instance.getUserId() ?? '';
    final authToken = await SecureStorage.instance.getAuthToken() ?? '';
    state = state.copyWith(isLoading: true);
    final request = UserInterestRequest(interests: ids);
    try {
      final apiResult = await BreachApi.instance.saveUserInterests(
        userId: int.parse(userId),
        request: request,
        authToken: authToken,
      );
      switch (apiResult) {
        case ApiSuccess(data: final _):
          context.go(Routes.posts);
          break;
        case ApiFailure(error: final error):
          debugPrint(error.message);
          break;
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
