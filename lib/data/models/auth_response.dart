import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  final String token;
  final int userId;

  const AuthResponse({required this.token, required this.userId});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(token: json['token'], userId: json['userId']);
  }

  @override
  List<Object?> get props => [token, userId];
}
