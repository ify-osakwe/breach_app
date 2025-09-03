import 'package:breach/screens/streams/ui_widget/stream_list_item.dart';
import 'package:breach/screens/streams/ui_widget/stream_screen_appbar.dart';
import 'package:breach/utils/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StreamScreen extends ConsumerStatefulWidget {
  const StreamScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StreamScreenState();
}

class _StreamScreenState extends ConsumerState<StreamScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: StreamScreenAppbar(),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: sampleArticles.length,
        separatorBuilder: (_, __) => const SizedBox(height: 28),
        itemBuilder: (context, index) {
          final a = sampleArticles[index];
          return StreamListItem(article: a);
        },
      ),
    );
  }
}
