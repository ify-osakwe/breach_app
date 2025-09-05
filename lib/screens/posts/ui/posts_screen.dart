import 'package:breach/screens/posts/notifier/posts_notifier.dart';
import 'package:breach/screens/posts/ui_widget/posts_screen_category.dart';
import 'package:breach/screens/posts/ui_widget/posts_screen_list.dart';
import 'package:breach/utils/widgets/custom_appbar.dart';
import 'package:breach/utils/theme/app_colors.dart';
import 'package:breach/utils/widgets/app_scaffold.dart';
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
    return AppScaffold(
      padding: EdgeInsets.all(0),
      isLoading: ref.watch(postsProvider).isLoading,
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppbar(
        title: 'Categories',
        subtitle: 'Discover content from topics you care about',
      ),
      body: Column(
        children: [
          Divider(indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: PostsScreenCategory(),
          ),
          Expanded(child: PostsScreenList()),
        ],
      ),
    );
  }
}
