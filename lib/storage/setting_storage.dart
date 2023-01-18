import 'dart:convert';

import 'package:pomodoro_land/model/clockify/project_clockify.dart';
import 'package:pomodoro_land/model/clockify/workspace_clockify.dart';
import 'package:pomodoro_land/storage/cache_storage.dart';

import '../model/clockify/user_clockify.dart';

class SettingStorage {
  final storage = CacheStorage('setting');

  Future<void> writePomodoroDuration(Duration duration) =>
      storage.write('pomodoro', duration.inMinutes.toString());
  Future<Duration> readPomodoroDuration() async {
    final data = await storage.read('pomodoro');
    if (data == null) return const Duration(minutes: 25);
    return Duration(minutes: int.parse(data));
  }

  Future<void> writeShortBreakDuration(Duration duration) =>
      storage.write('short_break', duration.inMinutes.toString());
  Future<Duration> readShortBreakDuration() async {
    final data = await storage.read('short_break');
    if (data == null) return const Duration(minutes: 5);
    return Duration(minutes: int.parse(data));
  }

  Future<void> writeLongBreakDuration(Duration duration) =>
      storage.write('long_break', duration.inMinutes.toString());
  Future<Duration> readLongBreakDuration() async {
    final data = await storage.read('long_break');
    if (data == null) return const Duration(minutes: 15);
    return Duration(minutes: int.parse(data));
  }

  Future<void> writeApiKeyClockify(String apiKey) =>
      storage.write('api_key_clockify', apiKey);
  Future<String?> readApiKeyClockify() async {
    return await storage.read('api_key_clockify');
  }

  Future<void> writeUserClockify(UserClockify user) =>
      storage.write('user_clockify', user.toJson());
  Future<UserClockify?> readUserClockify() async {
    final data = await storage.read('user_clockify');
    if (data == null) return null;
    return UserClockify.fromJson(data);
  }

  Future<void> writeWorkspacesClockify(List<WorkspaceClockify> workspaces) =>
      storage.write('workspaces_clockify',
          jsonEncode(workspaces.map((e) => e.toMap()).toList()));
  Future<List<WorkspaceClockify>> readWorkspacesClockify() async {
    final data = await storage.read('workspaces_clockify');
    if (data == null) return [];
    final decode = jsonDecode(data);
    return (decode as List).map((e) => WorkspaceClockify.fromMap(e)).toList();
  }

  Future<void> writeSelectedWorkspaceClockify(WorkspaceClockify workspaces) =>
      storage.write('selected_workspace_clockify', workspaces.toJson());
  Future<WorkspaceClockify?> readSelectedWorkspaceClockify() async {
    final data = await storage.read('selected_workspace_clockify');
    if (data == null) return null;
    return WorkspaceClockify.fromJson(data);
  }

  Future<void> writeProjectsClockify(List<ProjectClockify> project) =>
      storage.write('project_clockify',
          jsonEncode(project.map((e) => e.toMap()).toList()));
  Future<List<ProjectClockify>> readProjectsClockify() async {
    final data = await storage.read('project_clockify');
    if (data == null) return [];
    final decode = jsonDecode(data);
    return (decode as List).map((e) => ProjectClockify.fromMap(e)).toList();
  }

  Future<void> writeSelectedProjectClockify(ProjectClockify? project) async {
    if (project == null) {
      await storage.delete('selected_project_clockify');
    } else {
      await storage.write('selected_project_clockify', project.toJson());
    }
  }

  Future<ProjectClockify?> readSelectedProjectClockify() async {
    final data = await storage.read('selected_project_clockify');
    if (data == null) return null;
    return ProjectClockify.fromJson(data);
  }

  Future<void> writeAutoStartBreak(bool autoStart) =>
      storage.write('auto_start_break', autoStart.toString());
  Future<bool> readAutoStartBreak() async {
    final data = await storage.read('auto_start_break');
    return data == 'true';
  }

  Future<void> writeAutoStartPomodoro(bool autoStart) =>
      storage.write('auto_start_pomodoro', autoStart.toString());
  Future<bool> readAutoStartPomodoro() async {
    final data = await storage.read('auto_start_pomodoro');
    return data == 'true';
  }
}
