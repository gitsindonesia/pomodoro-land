import 'dart:convert';

import 'package:pomodoro_land/storage/cache_storage.dart';

import '../model/todo.dart';

class TodoStorage {
  static final TodoStorage _instance = TodoStorage._();

  factory TodoStorage() {
    return _instance;
  }

  TodoStorage._();

  final storage = CacheStorage('todo');

  Future<void> write(List<Todo> todos) async {
    await storage.write(
        'todos', jsonEncode(todos.map((e) => e.toMap()).toList()));
  }

  Future<List<Todo>> read() async {
    final jsonString = await storage.read('todos');
    if (jsonString == null) return [];
    final json = jsonDecode(jsonString);
    return (json as List).map((e) => Todo.fromMap(e)).toList();
  }

  Future<void> clear() => storage.clear();
}
