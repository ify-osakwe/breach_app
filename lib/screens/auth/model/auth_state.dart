import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool enableButton;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AuthState({
    required this.isLoading,
    required this.enableButton,
    required this.emailController,
    required this.passwordController,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? enableButton,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      enableButton: enableButton ?? this.enableButton,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    enableButton,
    emailController,
    passwordController,
  ];
}
