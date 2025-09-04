import 'dart:convert';

import 'package:breach/data/common/api_path.dart';
import 'package:breach/data/local/secure_storage.dart';
import 'package:breach/data/models/stream_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';

final streamNewsProvider = StreamProvider.autoDispose<StreamItem>((ref) async* {
  final authToken = await SecureStorage.instance.getAuthToken() ?? '';
  final channel = IOWebSocketChannel.connect(
    Uri.parse(ApiPath.socketUrl(authToken)),
  );

  ref.onDispose(() => channel.sink.close());
  try {
    await for (final value in channel.stream) {
      final data = jsonDecode(value) as Map<String, dynamic>;
      yield StreamItem.fromJson(data);
    }
  } catch (e) {
    debugPrint("Error streaming : ${e.toString()}");
  }
});

/// Holds the most recent stream items (up to 5)
class RecentStreamItemsNotifier extends Notifier<List<StreamItem>> {
  @override
  List<StreamItem> build() => const [];

  void add(StreamItem item) {
    state = [item, ...state.take(4)];
  }

  void clear() => state = const [];
}

final recentStreamItemsProvider =
    NotifierProvider<RecentStreamItemsNotifier, List<StreamItem>>(
      RecentStreamItemsNotifier.new,
    );
