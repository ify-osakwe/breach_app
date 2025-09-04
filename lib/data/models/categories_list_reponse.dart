import 'dart:convert';

class Category {
  final int id;
  final String name;
  final String icon;

  const Category({required this.id, required this.name, required this.icon});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'] as int,
    name: json['name'] as String,
    icon: json['icon'] as String,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'icon': icon};
}

class CategoriesListResponse {
  final List<Category> categories;

  const CategoriesListResponse({required this.categories});

  CategoriesListResponse.empty() : categories = [];

  factory CategoriesListResponse.fromJsonList(List<dynamic> json) =>
      CategoriesListResponse(
        categories: json
            .map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  factory CategoriesListResponse.fromJsonString(String source) {
    final decoded = jsonDecode(source);
    if (decoded is! List) {
      throw const FormatException(
        'Expected a JSON array for categories response',
      );
    }
    return CategoriesListResponse.fromJsonList(decoded);
  }

  List<Map<String, dynamic>> toJson() =>
      categories.map((c) => c.toJson()).toList();
}
