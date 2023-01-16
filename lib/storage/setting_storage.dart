import 'dart:convert';

import 'package:pomodoro_land/model/project.dart';
import 'package:pomodoro_land/model/workspace.dart';
import 'package:pomodoro_land/storage/cache_storage.dart';

import '../model/user.dart';

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

  Future<void> writeUserClockify(User user) =>
      storage.write('user_clockify', user.toJson());
  Future<User?> readUserClockify() async {
    final data = await storage.read('user_clockify');
    if (data == null) return null;
    return User.fromJson(data);
  }

  Future<void> writeWorkspacesClockify(List<Workspace> workspaces) =>
      storage.write('workspaces_clockify',
          jsonEncode(workspaces.map((e) => e.toMap()).toList()));
  Future<List<Workspace>> readWorkspacesClockify() async {
    final data = await storage.read('workspaces_clockify');
    if (data == null) return [];
    final decode = jsonDecode(data);
    return (decode as List).map((e) => Workspace.fromMap(e)).toList();
  }

  Future<void> writeSelectedWorkspaceClockify(Workspace workspaces) =>
      storage.write('selected_workspace_clockify', workspaces.toJson());
  Future<Workspace?> readSelectedWorkspaceClockify() async {
    final data = await storage.read('selected_workspace_clockify');
    if (data == null) return null;
    return Workspace.fromJson(data);
  }

  Future<void> writeProjectsClockify(List<Project> project) => storage.write(
      'project_clockify', jsonEncode(project.map((e) => e.toMap()).toList()));
  Future<List<Project>> readProjectsClockify() async {
    final data = await storage.read('project_clockify');
    if (data == null) return [];
    final decode = jsonDecode(data);
    return (decode as List).map((e) => Project.fromMap(e)).toList();
  }

  Future<void> writeSelectedProjectClockify(Project? project) async {
    if (project == null) {
      await storage.delete('selected_project_clockify');
    } else {
      await storage.write('selected_project_clockify', project.toJson());
    }
  }

  Future<Project?> readSelectedProjectClockify() async {
    final data = await storage.read('selected_project_clockify');
    if (data == null) return null;
    return Project.fromJson(data);
  }
}
