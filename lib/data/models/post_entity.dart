import 'dart:convert';

import 'package:breach/data/models/categories_list_reponse.dart';

class PostEntity {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime createdAt;
  final PostAuthor author;
  final Category category;
  final PostSeries series;

  const PostEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
    required this.author,
    required this.category,
    required this.series,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) => PostEntity(
    id: json['id'] as int,
    title: json['title'] as String,
    content: json['content'] as String,
    imageUrl: json['imageUrl'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    author: PostAuthor.fromJson(json['author'] as Map<String, dynamic>),
    category: Category.fromJson(json['category'] as Map<String, dynamic>),
    series: PostSeries.fromJson(json['series'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'imageUrl': imageUrl,
    'createdAt': createdAt.toIso8601String(),
    'author': author.toJson(),
    'category': category.toJson(),
    'series': series.toJson(),
  };

  @override
  String toString() {
    return 'PostEntity(id: '
        '$id, title: $title, category: ${category.name}, author: ${author.name})';
  }
}

class PostAuthor {
  final int id;
  final String name;

  const PostAuthor({required this.id, required this.name});

  factory PostAuthor.fromJson(Map<String, dynamic> json) =>
      PostAuthor(id: json['id'] as int, name: json['name'] as String);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class PostSeries {
  final int id;
  final String name;

  const PostSeries({required this.id, required this.name});

  factory PostSeries.fromJson(Map<String, dynamic> json) =>
      PostSeries(id: json['id'] as int, name: json['name'] as String);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class CategoriesPostResponse {
  final List<PostEntity> posts;

  const CategoriesPostResponse({required this.posts});

  factory CategoriesPostResponse.fromJsonList(List<dynamic> json) =>
      CategoriesPostResponse(
        posts: json
            .map((e) => PostEntity.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  factory CategoriesPostResponse.fromJsonString(String source) {
    final decoded = jsonDecode(source);
    if (decoded is! List) {
      throw const FormatException(
        'Expected a JSON array for categories response',
      );
    }
    return CategoriesPostResponse.fromJsonList(decoded);
  }

  List<Map<String, dynamic>> toJson() => posts.map((c) => c.toJson()).toList();
}
