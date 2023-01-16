import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pomodoro_land/model/todo.dart';
import 'package:pomodoro_land/utils/extension.dart';

class History {
  History({
    required this.date,
    required this.todos,
  });

  final DateTime date;
  final List<Todo> todos;

  Map<String, dynamic> toMap() {
    return {
      'date': date.toMap(),
      'todos': todos.map((x) => x.toMap()).toList(),
    };
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      date: DateTime.parse(map['date']),
      todos: List<Todo>.from(map['todos']?.map((x) => Todo.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory History.fromJson(String source) =>
      History.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is History &&
        other.date == date &&
        listEquals(other.todos, todos);
  }

  @override
  int get hashCode => date.hashCode ^ todos.hashCode;
}
