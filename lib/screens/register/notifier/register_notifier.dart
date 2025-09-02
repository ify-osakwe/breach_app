import 'package:breach/data/breach_api.dart';
import 'package:breach/data/common/api_response_model.dart';
import 'package:breach/data/models/register_request.dart';
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
    final request = RegisterRequest(
      email: state.emailController.text,
      password: state.passwordController.text,
    );
    state = state.copyWith(isLoading: true);
    try {
      final apiResult = await BreachApi.instance.register(request: request);
      switch (apiResult) {
        case ApiSuccess(data: final register):
          print("RegisterResponse ${register.token} ... ${register.userId}");
        case ApiFailure(error: final response):
          print("Error ${response.error} ... ${response.message}");
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
