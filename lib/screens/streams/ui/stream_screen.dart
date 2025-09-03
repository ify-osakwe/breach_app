import 'package:breach/screens/streams/notifier/stream_notifier.dart';
import 'package:breach/screens/streams/ui_widget/stream_list_item.dart';
import 'package:breach/screens/streams/ui_widget/stream_screen_appbar.dart';
import 'package:breach/utils/widgets/app_scaffold.dart';
import 'package:breach/data/models/stream_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StreamScreen extends ConsumerWidget {
  const StreamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<StreamItem>>(streamNewsProvider, (prev, next) {
      next.whenData((item) {
        ref.read(recentStreamItemsProvider.notifier).add(item);
      });
    });
    final recentItems = ref.watch(recentStreamItemsProvider);
    //
    return AppScaffold(
      appBar: StreamScreenAppbar(),
      body: recentItems.isEmpty
          ? Center(
              child: Text(
                'No items yet',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.black54),
              ),
            )
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: recentItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: 28),
              itemBuilder: (context, index) {
                final a = recentItems[index];
                return StreamListItem(article: a);
              },
            ),
    );
  }
}
