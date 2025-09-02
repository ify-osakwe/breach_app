import 'package:equatable/equatable.dart';

class RegisterResponse extends Equatable {
  final String token;
  final int userId;

  const RegisterResponse({required this.token, required this.userId});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(token: json['token'], userId: json['userId']);
  }

  @override
  List<Object?> get props => [token, userId];
}
