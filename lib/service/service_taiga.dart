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
import 'package:pomodoro_land/model/taiga/response/refresh_response.dart';
import 'package:pomodoro_land/model/taiga/response/task_detail_response.dart';
import 'package:pomodoro_land/model/taiga/response/tasks_response.dart';
import 'package:pomodoro_land/model/tuple.dart';
import 'package:pomodoro_land/storage/taiga_storage.dart';

import '../model/taiga/response/issue_detail_response.dart';

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

  static Future<LoginTaigaResponse?> refresh(
      LoginTaigaResponse? loginResponse) async {
    final response = await http.post(
      taigaUrl('/auth/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': loginResponse?.refresh}),
    );
    if (response.statusCode == 401) {
      final body = await TaigaStorage().readUsername();
      if (body == null) {
        throw Exception('Cannot refresh please logout and login again.');
      }
      final fetchLogin = await login(body);
      return fetchLogin;
    }
    final refreshResponse = RefreshResponse.fromJson(response.body);
    return loginResponse?.copyWith(
      authToken: refreshResponse.authToken,
      refresh: refreshResponse.refresh,
    );
  }

  static Future<http.Response> fetchWithAuth(
    Future<http.Response> Function(String token) fetch,
  ) async {
    LoginTaigaResponse? login = await TaigaStorage().readLogin();
    http.Response response = await fetch(login?.authToken ?? '');
    if (response.statusCode == 401) {
      login = await refresh(login);
      if (login != null) {
        await TaigaStorage().writeLogin(login);
      }
      response = await fetch(login?.authToken ?? '');
    }
    return response;
  }

  static Future<List<ProjectTaigaResponse>> projects(int userId) async {
    final response = await fetchWithAuth((token) => http.get(
          taigaUrl('/projects?member=$userId&order_by=user_order&slight=true'),
          headers: getHeaders(token),
        ));
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

  static Future<ProjectDetailTaigaResponse> projectDetail(String slug) async {
    final response = await fetchWithAuth((token) => http.get(
          taigaUrl('/projects/by_slug?slug=$slug'),
          headers: getHeaders(token),
        ));
    if (response.statusCode != 200) {
      throw Exception(
          jsonDecode(response.body)['detail'] ?? 'Project not found');
    }
    final projectDetail = ProjectDetailTaigaResponse.fromJson(response.body);
    await TaigaStorage().writeProjectDetail(slug, projectDetail);
    return projectDetail;
  }

  static Future<MilestoneResponse> milestone(int milestoneId) async {
    final response = await fetchWithAuth((token) => http.get(
          taigaUrl('/milestones/$milestoneId'),
          headers: getHeaders(token),
        ));
    if (response.statusCode != 200) {
      throw Exception(
          jsonDecode(response.body)['detail'] ?? 'Milestone not found');
    }
    final milestone = MilestoneResponse.fromJson(response.body);
    await TaigaStorage().writeMilestone(milestoneId, milestone);
    return milestone;
  }

  static Future<List<TasksResponse>> tasks(
    int projectId,
    int milestoneId,
  ) async {
    final response = await fetchWithAuth((token) => http.get(
          taigaUrl(
              '/tasks?project=$projectId&milestone=$milestoneId&order_by=us_order'),
          headers: getHeaders(token, {'x-disable-pagination': '1'}),
        ));
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

  static Future<TaskDetailResponse> taskDetail({
    required int projectId,
    required int milestoneId,
    required int ref,
  }) async {
    final response = await fetchWithAuth((token) => http.get(
          taigaUrl(
              '/tasks/by_ref?milestone=$milestoneId&project=$projectId&ref=$ref'),
          headers: getHeaders(token),
        ));
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['detail'] ?? 'Task not found');
    }
    return TaskDetailResponse.fromJson(response.body);
  }

  static Future<bool> changeTaskStatus({
    required int taskId,
    required int statusId,
    required int version,
  }) async {
    final response = await fetchWithAuth((token) => http.patch(
          taigaUrl('/tasks/$taskId'),
          headers: getHeaders(token),
          body: jsonEncode({
            'status': statusId,
            'version': version,
          }),
        ));
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  static Future<FilterIssueResponse> filterIssue(int projectId) async {
    final response = await fetchWithAuth((token) => http.get(
          taigaUrl('/issues/filters_data?project=$projectId'),
          headers: getHeaders(token),
        ));
    if (response.statusCode != 200) {
      throw Exception(
          jsonDecode(response.body)['detail'] ?? 'Filter issue not found');
    }
    final filterIssue = FilterIssueResponse.fromJson(response.body);
    await TaigaStorage().writeFilterIssue(projectId, filterIssue);
    return filterIssue;
  }

  static Future<Tuple2<Pagination, List<IssueResponse>>> issues({
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

    final response = await fetchWithAuth((token) => http.get(
          url,
          headers: getHeaders(token),
        ));
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

  static Future<IssueDetailResponse> issueDetail({
    required int projectId,
    required int ref,
  }) async {
    final response = await fetchWithAuth((token) => http.get(
          taigaUrl('/issues/by_ref?&project=$projectId&ref=$ref'),
          headers: getHeaders(token),
        ));
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['detail'] ?? 'Issue not found');
    }
    return IssueDetailResponse.fromJson(response.body);
  }

  static Future<bool> changeIssueStatus({
    required int issueId,
    required int statusId,
    required int version,
  }) async {
    final response = await fetchWithAuth((token) => http.patch(
          taigaUrl('/issues/$issueId'),
          headers: getHeaders(token),
          body: jsonEncode({
            'status': statusId,
            'version': version,
          }),
        ));
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }
}
