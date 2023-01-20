import 'dart:convert';

import 'package:pomodoro_land/model/taiga/response/project_detail_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/tasks_response.dart';

class Taiga {
  Taiga({
    required this.projectDetail,
    required this.taskTaiga,
  });
  final ProjectDetailTaigaResponse projectDetail;
  final TasksResponse taskTaiga;

  Map<String, dynamic> toMap() {
    return {
      'project_detail': projectDetail.toMap(),
      'task_taiga': taskTaiga.toMap(),
    };
  }

  factory Taiga.fromMap(Map<String, dynamic> map) {
    return Taiga(
      projectDetail: ProjectDetailTaigaResponse.fromMap(map['project_detail']),
      taskTaiga: TasksResponse.fromMap(map['task_taiga']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Taiga.fromJson(String source) => Taiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Taiga &&
        other.projectDetail == projectDetail &&
        other.taskTaiga == taskTaiga;
  }

  @override
  int get hashCode => projectDetail.hashCode ^ taskTaiga.hashCode;
}
