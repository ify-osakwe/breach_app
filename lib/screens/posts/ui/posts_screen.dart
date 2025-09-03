import 'package:breach/screens/posts/notifier/posts_notifier.dart';
import 'package:breach/utils/widgets/app_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    final userInterests = ref.watch(userInterestsProvider);
    return AppScaffold(
      body: userInterests.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.interests.length,
            itemBuilder: (context, index) {
              final item = data.interests;
              return ListTile(
                title: Text(item[index].category.name),
                subtitle: Text(item[index].category.icon),
              );
            },
          );
        },
        error: (error, _) => Center(child: Text('Unable to fetch interests')),
        loading: () => Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
