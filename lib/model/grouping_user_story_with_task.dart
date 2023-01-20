import 'package:flutter/foundation.dart';
import 'package:pomodoro_land/model/taiga/response/milestone_response.dart';
import 'package:pomodoro_land/model/taiga/response/tasks_response.dart';

class GroupUserStoryWithTask {
  GroupUserStoryWithTask({
    required this.userStory,
    required this.tasks,
  });

  final UserStoriesMilestone? userStory;
  final List<TasksResponse> tasks;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupUserStoryWithTask &&
        other.userStory == userStory &&
        listEquals(other.tasks, tasks);
  }

  @override
  int get hashCode => userStory.hashCode ^ tasks.hashCode;
}
