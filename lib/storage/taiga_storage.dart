import 'dart:convert';

import 'package:pomodoro_land/model/taiga/response/filter_issue_response.dart';
import 'package:pomodoro_land/model/taiga/response/login_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/milestone_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_detail_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/tasks_response.dart';

import 'cache_storage.dart';

class TaigaStorage {
  static final TaigaStorage _instance = TaigaStorage._();

  factory TaigaStorage() {
    return _instance;
  }

  TaigaStorage._();

  final storage = CacheStorage('taiga');

  Future<void> writeLogin(LoginTaigaResponse response) =>
      storage.write('user', response.toJson());
  Future<LoginTaigaResponse?> readLogin() async {
    final data = await storage.read('user');
    if (data == null) return null;
    return LoginTaigaResponse.fromJson(data);
  }

  Future<void> writeProjects(int userId, List<ProjectTaigaResponse> projects) =>
      storage.write('projects_$userId',
          jsonEncode(projects.map((e) => e.toMap()).toList()));
  Future<List<ProjectTaigaResponse>> readProjects(int userId) async {
    final data = await storage.read('projects_$userId');
    if (data == null) return [];
    final decode = jsonDecode(data);
    return (decode as List)
        .map((e) => ProjectTaigaResponse.fromMap(e))
        .toList();
  }

  Future<void> writeProjectDetail(
          String slug, ProjectDetailTaigaResponse projectDetail) =>
      storage.write('project_detail_$slug', projectDetail.toJson());
  Future<ProjectDetailTaigaResponse?> readProjectDetail(String slug) async {
    final data = await storage.read('project_detail_$slug');
    if (data == null) return null;
    return ProjectDetailTaigaResponse.fromJson(data);
  }

  Future<void> writeMilestone(int milestoneId, MilestoneResponse milestone) =>
      storage.write('milestone_$milestoneId', milestone.toJson());
  Future<MilestoneResponse?> readMilestone(int milestoneId) async {
    final data = await storage.read('milestone_$milestoneId');
    if (data == null) return null;
    return MilestoneResponse.fromJson(data);
  }

  Future<void> writeTasks(
    int projectId,
    int milestoneId,
    List<TasksResponse> tasks,
  ) =>
      storage.write('task_${projectId}_$milestoneId',
          jsonEncode(tasks.map((e) => e.toMap()).toList()));
  Future<List<TasksResponse>> readTasks(
    int projectId,
    int milestoneId,
  ) async {
    final data = await storage.read('task_${projectId}_$milestoneId');
    if (data == null) return [];
    final decode = jsonDecode(data);
    return (decode as List).map((e) => TasksResponse.fromMap(e)).toList();
  }

  Future<void> writeFilterIssue(
          int projectId, FilterIssueResponse filterIssue) =>
      storage.write('filter_issue_$projectId', filterIssue.toJson());
  Future<FilterIssueResponse?> readFilterIssue(int projectId) async {
    final data = await storage.read('filter_issue_$projectId');
    if (data == null) return null;
    return FilterIssueResponse.fromJson(data);
  }

  Future<void> writeSelectedFilterIssue(
          int projectId, FilterIssueResponse filterIssue) =>
      storage.write('selected_filter_issue_$projectId', filterIssue.toJson());
  Future<FilterIssueResponse?> readSelectedFilterIssue(int projectId) async {
    final data = await storage.read('selected_filter_issue_$projectId');
    if (data == null) return null;
    return FilterIssueResponse.fromJson(data);
  }
}
