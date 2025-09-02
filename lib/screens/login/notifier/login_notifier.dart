// ignore_for_file: use_build_context_synchronously

import 'package:breach/data/breach_api.dart';
import 'package:breach/data/common/api_response_model.dart';
import 'package:breach/data/local/secure_storage.dart';
import 'package:breach/data/models/auth_request.dart';
import 'package:breach/routes/routes.dart';
import 'package:breach/screens/login/model/login_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);

class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    return LoginState(
      isLoading: false,
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
    );
  }

  Future<void> login({required BuildContext context}) async {
    final request = AuthRequest(
      email: state.emailController.text,
      password: state.passwordController.text,
    );
    state = state.copyWith(isLoading: true);
    try {
      final apiResult = await BreachApi.instance.login(request: request);
      switch (apiResult) {
        case ApiSuccess(data: final authResponse):
          debugPrint('Login succesful');
          await SecureStorage.instance.setAuthToken(authResponse.token);
          await SecureStorage.instance.setUserId("${authResponse.userId}");
          context.go(Routes.posts);
          break;
        case ApiFailure(error: final errorResponse):
          break;
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
