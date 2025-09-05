import 'package:breach/routes/routes.dart';
import 'package:breach/screens/posts/notifier/posts_notifier.dart';
import 'package:breach/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PostsScreenCategory extends ConsumerStatefulWidget {
  const PostsScreenCategory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostsScreenCategoryState();
}

class _PostsScreenCategoryState extends ConsumerState<PostsScreenCategory> {
  int? _selectedId;

  @override
  Widget build(BuildContext context) {
    final userInterests = ref.watch(userInterestsProvider);
    return SizedBox(
      height: 50,
      child: userInterests.when(
        data: (data) {
          if (data.interests.isEmpty) {
            return GestureDetector(
              onTap: () => context.go(Routes.personaliseScreen),
              child: Center(
                child: Text(
                  'Personalise your screen',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: data.interests.map((value) {
                final isSelected = _selectedId == value.category.id;
                return ChoiceChip(
                  label: Text(
                    "${value.category.icon} ${value.category.name}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedId = selected ? value.category.id : null;
                    });
                    ref
                        .read(postsProvider.notifier)
                        .getPostByCategory(categoryId: value.category.id);
                  },
                  backgroundColor: AppColors.white,
                  selectedColor: AppColors.purple2,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: isSelected ? AppColors.purple2 : AppColors.white2,
                      width: 1.25,
                    ),
                  ),
                  elevation: 0,
                  pressElevation: 0,
                );
              }).toList(),
            ),
          );
        },
        error: (error, _) => Center(child: Text('Unable to fetch interests')),
        loading: () => Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
