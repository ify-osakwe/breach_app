import 'package:breach/data/breach_api.dart';
import 'package:breach/data/common/api_response_model.dart';
import 'package:breach/data/local/secure_storage.dart';
import 'package:breach/data/models/user_interest_response.dart';
import 'package:breach/screens/posts/model/posts_state.dart';
import 'package:flutter/material.dart';
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

final postsProvider = NotifierProvider<PostsNotifier, PostsState>(
  PostsNotifier.new,
);

class PostsNotifier extends Notifier<PostsState> {
  @override
  PostsState build() {
    return PostsState(isLoading: false, postsList: []);
  }

  Future<void> getPostByCategory({required int categoryId}) async {
    final authToken = await SecureStorage.instance.getAuthToken() ?? '';
    state = state.copyWith(isLoading: true);
    try {
      final apiResult = await BreachApi.instance.getPostsByCategory(
        categoryId: categoryId,
        authToken: authToken,
      );
      switch (apiResult) {
        case ApiSuccess(data: final response):
          state = state.copyWith(
            isLoading: false,
            postsList: [...response.posts, ...state.postsList],
          );
          break;
        case ApiFailure(error: final error):
          debugPrint("Error fetching lists: ${error.message}");
          break;
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
