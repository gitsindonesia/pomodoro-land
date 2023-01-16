import 'package:hive/hive.dart';

class CacheStorage {
  CacheStorage(
    this.boxName,
  );

  final String boxName;

  Future<void> clear() async {
    final box = await Hive.openBox(boxName);
    await box.clear();
  }

  Future<void> delete(String key) async {
    final box = await Hive.openBox(boxName);
    return box.delete(key);
  }

  Future<String?> read(String key) async {
    final box = await Hive.openBox(boxName);
    return box.get(key);
  }

  Future<Iterable?> keys() async {
    final box = await Hive.openBox(boxName);
    return box.keys;
  }

  Future<void> write(String key, String value) async {
    final box = await Hive.openBox(boxName);
    return box.put(key, value);
  }
}
