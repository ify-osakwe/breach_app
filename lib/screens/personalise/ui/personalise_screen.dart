import 'package:breach/screens/personalise/notifier/personalise_notifier.dart';
import 'package:breach/screens/personalise/ui_widget/personalise_title.dart';
import 'package:breach/utils/theme/app_colors.dart';
import 'package:breach/utils/widgets/app_scaffold.dart';
import 'package:breach/utils/widgets/overlays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonaliseScreen extends ConsumerStatefulWidget {
  const PersonaliseScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersonaliseScreenState();
}

class _PersonaliseScreenState extends ConsumerState<PersonaliseScreen> {
  //
  final Set<int> _selectedIds = <int>{};

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(personaliseProvider);
    final categories = ref.watch(categoriesProvider);

    return AppScaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            LinearLoadingIndicator(loading: state.isLoading),
            PersonaliseTitle(),
            Expanded(
              child: categories.when(
                data: (data) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: data.categories.map((category) {
                        final isSelected = _selectedIds.contains(category.id);
                        return FilterChip(
                          showCheckmark: false,
                          label: Text(
                            "${category.icon} ${category.name}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedIds.add(category.id);
                              } else {
                                _selectedIds.remove(category.id);
                              }
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
            //
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 6, 24, 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    debugPrint("Selected IDs: $_selectedIds");
                    ref
                        .read(personaliseProvider.notifier)
                        .saveUserInterests(_selectedIds.toList(), context);
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
