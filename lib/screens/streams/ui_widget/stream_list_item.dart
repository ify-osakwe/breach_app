import 'package:breach/data/models/categories_list_reponse.dart';
import 'package:breach/data/models/post_entity.dart';
import 'package:breach/data/models/stream_item.dart';
import 'package:flutter/material.dart';

class StreamListItem extends StatelessWidget {
  const StreamListItem({super.key, required this.article});

  final StreamItem article;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title.toUpperCase(),
          style: t.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Text(
          article.content,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: t.bodyLarge?.copyWith(
            height: 1.5,
            color: Colors.black.withValues(alpha: 0.85),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '${article.author.name} • ${_formatDate(article.createdAt)}',
          style: t.bodySmall?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}

const sampleExcerpt =
    'I went to boarding school and left pretty early, so I had some experience with losing friends to…';

final List<StreamItem> sampleArticles = [
  StreamItem(
    title: 'Migrations Series: Canada',
    content: sampleExcerpt,
    author: PostAuthor(id: 1, name: 'Lota Anidi'),
    createdAt: DateTime(2022, 12, 12),
    id: 4,
    category: Category(id: 2, name: 'Listless', icon: '🥸'),
    series: PostSeries(id: 3, name: 'Seriesless'),
  ),
  StreamItem(
    title: 'Does Bitcoin Really Solve This?',
    content: sampleExcerpt,
    author: PostAuthor(id: 1, name: 'Lota Anidi'),
    createdAt: DateTime(2022, 12, 12),
    id: 4,
    category: Category(id: 2, name: 'Listless', icon: '🥸'),
    series: PostSeries(id: 3, name: 'Seriesless'),
  ),
  StreamItem(
    title: 'Where is the Naira Going?',
    content: sampleExcerpt,
    author: PostAuthor(id: 1, name: 'Lota Anidi'),
    createdAt: DateTime(2022, 12, 12),
    id: 4,
    category: Category(id: 2, name: 'Listless', icon: '🥸'),
    series: PostSeries(id: 3, name: 'Seriesless'),
  ),
  StreamItem(
    title: 'Productivity Impacts of Design Systems',
    content: sampleExcerpt,
    author: PostAuthor(id: 1, name: 'Lota Anidi'),
    createdAt: DateTime(2022, 12, 12),
    id: 4,
    category: Category(id: 2, name: 'Listless', icon: '🥸'),
    series: PostSeries(id: 3, name: 'Seriesless'),
  ),
  StreamItem(
    title: 'Liquidity in Investments',
    content: sampleExcerpt,
    author: PostAuthor(id: 1, name: 'Lota Anidi'),
    createdAt: DateTime(2022, 12, 12),
    id: 4,
    category: Category(id: 2, name: 'Listless', icon: '🥸'),
    series: PostSeries(id: 3, name: 'Seriesless'),
  ),
];

String _formatDate(DateTime dt) {
  const months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];
  final d = dt.day.toString().padLeft(2, '0');
  return '$d ${months[dt.month - 1]} ${dt.year}';
}
