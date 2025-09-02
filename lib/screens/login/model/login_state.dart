import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginState({
    required this.isLoading,
    required this.emailController,
    required this.passwordController,
  });

  LoginState copyWith({
    bool? isLoading,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
    );
  }

  @override
  List<Object?> get props => [isLoading, emailController, passwordController];
}
