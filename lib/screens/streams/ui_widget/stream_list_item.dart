import 'package:breach/data/models/stream_item.dart';
import 'package:breach/utils/functions/on_date.dart';
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
          style: t.titleLarge?.copyWith(fontWeight: FontWeight.w600),
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
          '${article.author.name} • ${formatDate(article.createdAt)}',
          style: t.bodySmall?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}
