import 'package:breach/data/models/categories_list_reponse.dart';
import 'package:breach/data/models/post_entity.dart';

class StreamItem {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;
  final PostAuthor author;
  final Category category;
  final PostSeries series;

  const StreamItem({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.author,
    required this.category,
    required this.series,
  });

  factory StreamItem.fromJson(Map<String, dynamic> json) => StreamItem(
        id: json['id'] as int,
        title: json['title'] as String,
        content: json['content'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        author: PostAuthor.fromJson(json['author'] as Map<String, dynamic>),
        category: Category.fromJson(json['category'] as Map<String, dynamic>),
        series: PostSeries.fromJson(json['series'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
        'author': author.toJson(),
        'category': category.toJson(),
        'series': series.toJson(),
      };

  @override
  String toString() {
    return 'StreamItem(id: '
        '$id, title: $title, category: ${category.name}, author: ${author.name})';
  }
}
