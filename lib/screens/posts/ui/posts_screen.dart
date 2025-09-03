import 'package:breach/screens/posts/notifier/posts_notifier.dart';
import 'package:breach/utils/theme/app_colors.dart';
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
  int? _selectedId;

  @override
  Widget build(BuildContext context) {
    final userInterests = ref.watch(userInterestsProvider);
    return AppScaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: userInterests.when(
              data: (data) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: data.interests.map((value) {
                      final isSelected = _selectedId == value.id;
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
                            _selectedId = selected ? value.id : null;
                          });
                        },
                        backgroundColor: AppColors.white,
                        selectedColor: AppColors.purple2,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        shape: StadiumBorder(
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.purple2
                                : AppColors.white2,
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
              error: (error, _) =>
                  Center(child: Text('Unable to fetch interests')),
              loading: () => Center(child: CupertinoActivityIndicator()),
            ),
          ),
          Expanded(child: ListView()),
        ],
      ),
    );
  }
}
