// ignore_for_file: use_build_context_synchronously

import 'package:breach/data/breach_api.dart';
import 'package:breach/data/common/api_response_model.dart';
import 'package:breach/data/local/secure_storage.dart';
import 'package:breach/data/models/auth_request.dart';
import 'package:breach/routes/routes.dart';
import 'package:breach/screens/register/model/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final registerProvider = NotifierProvider<RegisterNotifier, RegisterState>(
  RegisterNotifier.new,
);

class RegisterNotifier extends Notifier<RegisterState> {
  @override
  RegisterState build() {
    return RegisterState(
      isLoading: false,
      enableButton: false,
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
    );
  }

  void validateInputs() {
    final enabled = isValidInput();
    if (state.enableButton != enabled) {
      state = state.copyWith(enableButton: enabled);
    }
  }

  Future<void> register({required BuildContext context}) async {
    final email = state.emailController.text.trim();
    final pass = state.passwordController.text;
    final emailOkay = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    if (!emailOkay && pass.isEmpty) {
      return;
    }
    //
    state = state.copyWith(isLoading: true, enableButton: true);
    final request = AuthRequest(
      email: state.emailController.text,
      password: state.passwordController.text,
    );
    try {
      final apiResult = await BreachApi.instance.register(request: request);
      switch (apiResult) {
        case ApiSuccess(data: final authResponse):
          await SecureStorage.instance.setAuthToken(authResponse.token);
          await SecureStorage.instance.setUserId("${authResponse.userId}");
          context.go(Routes.personaliseIntro);
          break;
        case ApiFailure(error: final errorResponse):
          debugPrint("Error ${errorResponse.error},${errorResponse.message}");
      }
    } finally {
      state = state.copyWith(isLoading: false, enableButton: false);
    }
  }

  bool isValidInput() {
    final email = state.emailController.text.trim();
    final pass = state.passwordController.text;
    final emailOk = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    return emailOk && pass.isNotEmpty;
  }
}
