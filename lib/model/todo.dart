import 'dart:convert';

import 'package:pomodoro_land/model/clockify/project_clockify.dart';
import 'package:pomodoro_land/model/taiga.dart';
import 'package:pomodoro_land/utils/extension.dart';

class Todo {
  Todo({
    required this.checklist,
    required this.task,
    required this.dateTime,
    this.project,
    this.taiga,
  });

  final bool checklist;
  final String task;
  final DateTime dateTime;
  final ProjectClockify? project;
  final Taiga? taiga;

  Map<String, dynamic> toMap() {
    return {
      'checklist': checklist,
      'task': task,
      'date_time': dateTime.toMap(),
      'project': project?.toMap(),
      'taiga': taiga?.toMap(),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      checklist: map['checklist'] ?? false,
      task: map['task'] ?? '',
      dateTime: DateTime.parse(map['date_time']),
      project: map['project'] != null
          ? ProjectClockify.fromMap(map['project'])
          : null,
      taiga: map['taiga'] != null ? Taiga.fromMap(map['taiga']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.checklist == checklist &&
        other.task == task &&
        other.dateTime == dateTime &&
        other.project == project &&
        other.taiga == taiga;
  }

  @override
  int get hashCode {
    return checklist.hashCode ^
        task.hashCode ^
        dateTime.hashCode ^
        project.hashCode ^
        taiga.hashCode;
  }
}
