import 'package:breach/utils/functions/on_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsScreenListStatic extends ConsumerStatefulWidget {
  const PostsScreenListStatic({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostsScreenListStaticState();
}

class _PostsScreenListStaticState extends ConsumerState<PostsScreenListStatic> {
  @override
  Widget build(BuildContext context) {
    return examplePosts.isEmpty
        ? const Center(child: Text('No Posts yet'))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: examplePosts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (context, index) =>
                PostTileStatic(post: examplePosts[index]),
          );
  }
}

class PostTileStatic extends ConsumerWidget {
  const PostTileStatic({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 130,
              height: 90,
              child: Image.network(
                post.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                Text(
                  post.category.toUpperCase(),
                  style: theme.labelSmall?.copyWith(
                    letterSpacing: 1.1,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                // Title
                Text(
                  post.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 6),
                // Excerpt
                Text(
                  post.excerpt,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.bodySmall?.copyWith(
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                // Meta: author • date
                Text(
                  '${post.author.toUpperCase()} • ${formatDateUpper(post.date)}',
                  style: theme.labelSmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Post {
  final String category;
  final String title;
  final String excerpt;
  final String author;
  final DateTime date;
  final String imageUrl;

  Post({
    required this.category,
    required this.title,
    required this.excerpt,
    required this.author,
    required this.date,
    required this.imageUrl,
  });
}

final examplePosts = <Post>[
  Post(
    category: 'Work in Progress',
    title: 'On migration and maintaining friendships',
    excerpt:
        'I went to boarding school and left pretty early, so I had some experience with losing friends to relocation...',
    author: 'Lota Anidi',
    date: DateTime(2022, 12, 12),
    imageUrl: 'https://picsum.photos/seed/wip1/800/500',
  ),
  Post(
    category: 'The Crypto Verse',
    title: 'I haven’t given up on holding Bitcoin. Here’s why',
    excerpt:
        'From early experiments to long-term conviction—lessons I learned along the way and the risks I still watch.',
    author: 'Chinyere Eze',
    date: DateTime(2022, 12, 12),
    imageUrl: 'https://picsum.photos/seed/crypto/800/500',
  ),
  Post(
    category: 'Work in Progress',
    title: 'Welcome to Work in Progress',
    excerpt:
        'We\'re going to have some emotionally freeing fun as we explore stories, ideas, and growth.',
    author: 'Fu\'ad Lawal',
    date: DateTime(2022, 12, 12),
    imageUrl: 'https://picsum.photos/seed/logo/800/500',
  ),
  Post(
    category: 'Schooled by BREACHx',
    title: 'Is liquidity always important in investing?',
    excerpt:
        'Have you ever considered investing with a group of friends? Here’s how that went (spoiler: not great).',
    author: 'Yemi Johnson',
    date: DateTime(2022, 12, 12),
    imageUrl: 'https://picsum.photos/seed/liquidity/800/500',
  ),
  Post(
    category: 'Sceptic vs Optimist',
    title: 'Is the metaverse the most ridiculous concept ever',
    excerpt:
        'I went to boarding school and left pretty early, so I had some experience with losing friends to relocation...',
    author: 'Hillary Omitogun',
    date: DateTime(2022, 12, 12),
    imageUrl: 'https://picsum.photos/seed/metaverse/800/500',
  ),
];
