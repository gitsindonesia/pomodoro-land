import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pomodoro_land/model/pagination.dart';
import 'package:pomodoro_land/model/taiga/body/login_taiga_body.dart';
import 'package:pomodoro_land/model/taiga/response/filter_issue_response.dart';
import 'package:pomodoro_land/model/taiga/response/issue_response.dart';
import 'package:pomodoro_land/model/taiga/response/login_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/milestone_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_detail_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/task_detail_response.dart';
import 'package:pomodoro_land/model/taiga/response/tasks_response.dart';
import 'package:pomodoro_land/model/tuple.dart';
import 'package:pomodoro_land/storage/taiga_storage.dart';

abstract class ServiceTaiga {
  static Uri taigaUrl(String path) =>
      Uri.parse('https://taiga.gits.id/api/v1$path');
  static Map<String, String> getHeaders(String token,
      [Map<String, String>? custom]) {
    final header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    header.addAll(custom ?? {});
    return header;
  }

  static Future<LoginTaigaResponse> login(LoginTaigaBody body) async {
    final response = await http.post(
      taigaUrl('/auth'),
      headers: {'Content-Type': 'application/json'},
      body: body.toJson(),
    );
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['detail'] ??
          'Invalid username or password');
    }
    return LoginTaigaResponse.fromJson(response.body);
  }

  static Future<List<ProjectTaigaResponse>> projects(
    String token,
    int userId,
  ) async {
    final response = await http.get(
      taigaUrl('/projects?member=$userId&order_by=user_order&slight=true'),
      headers: getHeaders(token),
    );
    if (response.statusCode != 200) {
      throw Exception(
          jsonDecode(response.body)['detail'] ?? 'Projects not found');
    }
    final data = jsonDecode(response.body);
    if (data is List) {
      final projects =
          (data).map((e) => ProjectTaigaResponse.fromMap(e)).toList();
      await TaigaStorage().writeProjects(userId, projects);
      return projects;
    }
    throw Exception('Projects not found');
  }

  static Future<ProjectDetailTaigaResponse> projectDetail(
      String token, String slug) async {
    final response = await http.get(
      taigaUrl('/projects/by_slug?slug=$slug'),
      headers: getHeaders(token),
    );
    if (response.statusCode != 200) {
      throw Exception(
          jsonDecode(response.body)['detail'] ?? 'Project not found');
    }
    final projectDetail = ProjectDetailTaigaResponse.fromJson(response.body);
    await TaigaStorage().writeProjectDetail(slug, projectDetail);
    return projectDetail;
  }

  static Future<MilestoneResponse> milestone(
      String token, int milestoneId) async {
    final response = await http.get(
      taigaUrl('/milestones/$milestoneId'),
      headers: getHeaders(token),
    );
    if (response.statusCode != 200) {
      throw Exception(
          jsonDecode(response.body)['detail'] ?? 'Milestone not found');
    }
    final milestone = MilestoneResponse.fromJson(response.body);
    await TaigaStorage().writeMilestone(milestoneId, milestone);
    return milestone;
  }

  static Future<List<TasksResponse>> tasks(
    String token,
    int projectId,
    int milestoneId,
  ) async {
    final response = await http.get(
      taigaUrl(
          '/tasks?project=$projectId&milestone=$milestoneId&order_by=us_order'),
      headers: getHeaders(token, {'x-disable-pagination': '1'}),
    );
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['detail'] ?? 'Tasks not found');
    }
    final data = jsonDecode(response.body);
    if (data is List) {
      final tasks = (data).map((e) => TasksResponse.fromMap(e)).toList();
      await TaigaStorage().writeTasks(projectId, milestoneId, tasks);
      return tasks;
    }
    throw Exception('Tasks not found');
  }

  static Future<TaskDetailResponse> taskDetail(
    String token, {
    required int projectId,
    required int milestoneId,
    required int ref,
  }) async {
    final response = await http.get(
      taigaUrl(
          '/tasks/by_ref?milestone=$milestoneId&project=$projectId&ref=$ref'),
      headers: getHeaders(token),
    );
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['detail'] ?? 'Task not found');
    }
    return TaskDetailResponse.fromJson(response.body);
  }

  static Future<bool> changeTaskStatus(
    String token, {
    required int taskId,
    required int statusId,
    required int version,
  }) async {
    final response = await http.patch(
      taigaUrl('/tasks/$taskId'),
      headers: getHeaders(token),
      body: jsonEncode({
        'status': statusId,
        'version': version,
      }),
    );
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  static Future<FilterIssueResponse> filterIssue(
      String token, int projectId) async {
    final response = await http.get(
      taigaUrl('/issues/filters_data?project=$projectId'),
      headers: getHeaders(token),
    );
    if (response.statusCode != 200) {
      throw Exception(
          jsonDecode(response.body)['detail'] ?? 'Filter issue not found');
    }
    final filterIssue = FilterIssueResponse.fromJson(response.body);
    await TaigaStorage().writeFilterIssue(projectId, filterIssue);
    return filterIssue;
  }

  static Future<Tuple2<Pagination, List<IssueResponse>>> issues({
    required String token,
    required int page,
    required int projectId,
    required FilterIssueResponse filterIssue,
  }) async {
    final type = filterIssue.types?.isEmpty ?? true
        ? ''
        : '&type=${filterIssue.types?.map((e) => e.id).join() ?? ''}';
    final severity = filterIssue.severities?.isEmpty ?? true
        ? ''
        : '&severity=${filterIssue.severities?.map((e) => e.id).join() ?? ''}';
    final priority = filterIssue.priorities?.isEmpty ?? true
        ? ''
        : '&priority=${filterIssue.priorities?.map((e) => e.id).join() ?? ''}';
    final status = filterIssue.statuses?.isEmpty ?? true
        ? ''
        : '&status=${filterIssue.statuses?.map((e) => e.id).join() ?? ''}';
    final tag = filterIssue.tags?.isEmpty ?? true
        ? ''
        : '&tag=${filterIssue.tags?.map((e) => e.name).join() ?? ''}';
    final assignedTo = filterIssue.assignedTo?.isEmpty ?? true
        ? ''
        : '&assigned_to=${filterIssue.assignedTo?.map((e) => e.id).join() ?? ''}';
    final role = filterIssue.roles?.isEmpty ?? true
        ? ''
        : '&role=${filterIssue.roles?.map((e) => e.id).join() ?? ''}';
    final owner = filterIssue.owners?.isEmpty ?? true
        ? ''
        : '&owner=${filterIssue.owners?.map((e) => e.id).join() ?? ''}';

    final url = taigaUrl(
        '/issues?page=$page&project=$projectId$type$severity$priority$status$tag$assignedTo$role$owner');

    final response = await http.get(
      url,
      headers: getHeaders(token),
    );
    if (response.statusCode != 200) {
      throw Exception(
          jsonDecode(response.body)['detail'] ?? 'Issues not found');
    }
    final data = jsonDecode(response.body);
    if (data is List) {
      final issues = (data).map((e) => IssueResponse.fromMap(e)).toList();
      final pagination = Pagination.fromMap(response.headers);
      return Tuple2(pagination, issues);
    }
    throw Exception('Tasks not found');
  }
}
