import 'package:equatable/equatable.dart';

class AuthRequest extends Equatable {
  final String email;
  final String password;

  const AuthRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {"email": email, "password": password};

  @override
  List<Object?> get props => [email, password];
}
