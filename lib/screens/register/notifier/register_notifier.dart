import 'package:breach/data/breach_api.dart';
import 'package:breach/data/common/api_response_model.dart';
import 'package:breach/data/local/secure_storage.dart';
import 'package:breach/data/models/auth_request.dart';
import 'package:breach/screens/register/model/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerProvider = NotifierProvider<RegisterNotifier, RegisterState>(
  RegisterNotifier.new,
);

class RegisterNotifier extends Notifier<RegisterState> {
  @override
  RegisterState build() {
    return RegisterState(
      isLoading: false,
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
    );
  }

  Future<void> register({required BuildContext context}) async {
    final request = AuthRequest(
      email: state.emailController.text,
      password: state.passwordController.text,
    );
    state = state.copyWith(isLoading: true);
    try {
      final apiResult = await BreachApi.instance.register(request: request);
      switch (apiResult) {
        case ApiSuccess(data: final authResponse):
          await SecureStorage.instance.setAuthToken(authResponse.token);
          await SecureStorage.instance.setUserId("${authResponse.userId}");
        case ApiFailure(error: final errorResponse):
          debugPrint("Error ${errorResponse.error},${errorResponse.message}");
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
