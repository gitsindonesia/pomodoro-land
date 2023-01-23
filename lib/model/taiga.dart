import 'dart:convert';

import 'package:pomodoro_land/model/taiga/response/issue_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_detail_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/tasks_response.dart';

class Taiga {
  Taiga({
    required this.projectDetail,
    this.taskTaiga,
    this.issueTaiga,
  });
  final ProjectDetailTaigaResponse projectDetail;
  final TasksResponse? taskTaiga;
  final IssueResponse? issueTaiga;

  Map<String, dynamic> toMap() {
    return {
      'project_detail': projectDetail.toMap(),
      'task_taiga': taskTaiga?.toMap(),
      'issue_taiga': issueTaiga?.toMap(),
    };
  }

  factory Taiga.fromMap(Map<String, dynamic> map) {
    return Taiga(
      projectDetail: ProjectDetailTaigaResponse.fromMap(map['project_detail']),
      taskTaiga: map['task_taiga'] != null
          ? TasksResponse.fromMap(map['task_taiga'])
          : null,
      issueTaiga: map['issue_taiga'] != null
          ? IssueResponse.fromMap(map['issue_taiga'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Taiga.fromJson(String source) => Taiga.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Taiga &&
        other.projectDetail == projectDetail &&
        other.taskTaiga == taskTaiga &&
        other.issueTaiga == issueTaiga;
  }

  @override
  int get hashCode =>
      projectDetail.hashCode ^ taskTaiga.hashCode ^ issueTaiga.hashCode;

  Taiga copyWith({
    ProjectDetailTaigaResponse? projectDetail,
    TasksResponse? taskTaiga,
    IssueResponse? issueTaiga,
  }) {
    return Taiga(
      projectDetail: projectDetail ?? this.projectDetail,
      taskTaiga: taskTaiga ?? this.taskTaiga,
      issueTaiga: issueTaiga ?? this.issueTaiga,
    );
  }
}
