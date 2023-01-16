import 'dart:convert';

import 'package:pomodoro_land/storage/cache_storage.dart';
import 'package:pomodoro_land/utils/extension.dart';

import '../model/history.dart';

class HistoryStorage {
  final storage = CacheStorage('history');

  Future<void> write(DateTime dateTime, List<History> history) async {
    await storage.write(
        dateTime.toMap(), jsonEncode(history.map((e) => e.toMap()).toList()));
  }

  Future<List<History>> read() async {
    final keys = (await storage.keys())?.toList().reversed;
    List<History> history = [];
    keys?.forEach((element) async {
      final jsonString = await storage.read(element);
      if (jsonString == null) return;
      final json = jsonDecode(jsonString);
      history.addAll((json as List).map((e) => History.fromMap(e)));
    });
    return history;
  }

  Future<void> clear() => storage.clear();
}
