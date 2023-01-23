import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/clockify/project_clockify.dart';
import '../model/clockify/user_clockify.dart';
import '../model/clockify/workspace_clockify.dart';

abstract class ServiceClockify {
  static Uri clockifyUrl(String path) =>
      Uri.parse('https://api.clockify.me/api/v1$path');
  static Map<String, String> getHeaders(String apiKey) => {
        'Content-Type': 'application/json',
        'X-Api-Key': apiKey,
      };

  static Future<UserClockify> getUser(String apiKey) async {
    final response =
        await http.get(clockifyUrl('/user'), headers: getHeaders(apiKey));
    return UserClockify.fromJson(response.body);
  }

  static Future<List<WorkspaceClockify>> getWorkspaces(String apiKey) async {
    final response =
        await http.get(clockifyUrl('/workspaces'), headers: getHeaders(apiKey));
    return (jsonDecode(response.body) as List)
        .map((e) => WorkspaceClockify.fromMap(e))
        .toList();
  }

  static Future<List<ProjectClockify>> getProjects(
      String apiKey, String workspaceId) async {
    final response = await http.get(
      clockifyUrl('/workspaces/$workspaceId/projects').replace(
        queryParameters: {'page-size': '5000'},
      ),
      headers: getHeaders(apiKey),
    );
    return (jsonDecode(response.body) as List)
        .map((e) => ProjectClockify.fromMap(e))
        .toList();
  }

  static Future<bool> addTimeEntry({
    required String apiKey,
    required String workspaceId,
    required String projectId,
    required DateTime startTime,
    required DateTime endTime,
    required String description,
  }) async {
    final response = await http.post(
      clockifyUrl('/workspaces/$workspaceId/time-entries'),
      headers: getHeaders(apiKey),
      body: jsonEncode({
        "projectId": projectId,
        "description": description,
        "billable": "true",
        "start": startTime.toUtc().toIso8601String(),
        "end": endTime.toUtc().toIso8601String(),
      }),
    );
    return response.statusCode == 201;
  }
}
