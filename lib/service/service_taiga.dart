import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pomodoro_land/model/taiga/body/login_taiga_body.dart';
import 'package:pomodoro_land/model/taiga/response/login_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/milestone_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_detail_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/tasks_response.dart';
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
}
