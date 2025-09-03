import 'dart:convert';

import 'package:breach/data/models/categories_list_reponse.dart';

class UserLite {
  final int id;
  final String email;

  const UserLite({required this.id, required this.email});

  factory UserLite.fromJson(Map<String, dynamic> json) =>
      UserLite(
        id: json['id'] as int,
        email: json['email'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
      };
}

class UserInterest {
  final int id;
  final UserLite user;
  final Category category;

  const UserInterest({
    required this.id,
    required this.user,
    required this.category,
  });

  factory UserInterest.fromJson(Map<String, dynamic> json) => UserInterest(
        id: json['id'] as int,
        user: UserLite.fromJson(json['user'] as Map<String, dynamic>),
        category: Category.fromJson(json['category'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user.toJson(),
        'category': category.toJson(),
      };
}

class UserInterestResponse {
  final List<UserInterest> interests;

  const UserInterestResponse({required this.interests});

  UserInterestResponse.empty() : interests = const [];

  factory UserInterestResponse.fromJsonList(List<dynamic> json) =>
      UserInterestResponse(
        interests: json
            .map((e) => UserInterest.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  factory UserInterestResponse.fromJsonString(String source) {
    final decoded = jsonDecode(source);
    if (decoded is! List) {
      throw const FormatException(
        'Expected a JSON array for user interests response',
      );
    }
    return UserInterestResponse.fromJsonList(decoded);
  }

  List<Map<String, dynamic>> toJson() =>
      interests.map((e) => e.toJson()).toList();
}
