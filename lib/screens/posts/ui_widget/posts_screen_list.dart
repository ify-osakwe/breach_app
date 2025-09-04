import 'package:breach/screens/posts/notifier/posts_notifier.dart';
import 'package:breach/screens/posts/ui_widget/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsScreenList extends ConsumerStatefulWidget {
  const PostsScreenList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostsScreenListState();
}

class _PostsScreenListState extends ConsumerState<PostsScreenList> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postsProvider);
    return state.postsList.isEmpty
        ? const Center(child: Text('No Posts yet.'))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: state.postsList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (context, index) =>
                PostTile(post: state.postsList[index]),
          );
  }
}
