part of 'setting_cubit.dart';

class SettingState {
  SettingState({
    required this.loadingCheckClockify,
    this.user,
    required this.workspaces,
    this.selectedWorkspace,
    required this.loadingProjects,
    required this.projects,
    required this.autoStartBreak,
    required this.autoStartPomodoro,
  });

  final bool loadingCheckClockify;
  final UserClockify? user;
  final List<WorkspaceClockify> workspaces;
  final WorkspaceClockify? selectedWorkspace;
  final bool loadingProjects;
  final List<ProjectClockify> projects;
  final bool autoStartBreak;
  final bool autoStartPomodoro;

  SettingState copyWith({
    bool? loadingCheckClockify,
    List<WorkspaceClockify>? workspaces,
    List<ProjectClockify>? projects,
    bool? loadingProjects,
    bool? autoStartBreak,
    bool? autoStartPomodoro,
  }) {
    return SettingState(
      loadingCheckClockify: loadingCheckClockify ?? this.loadingCheckClockify,
      workspaces: workspaces ?? this.workspaces,
      selectedWorkspace: selectedWorkspace,
      user: user,
      projects: projects ?? this.projects,
      loadingProjects: loadingProjects ?? this.loadingProjects,
      autoStartBreak: autoStartBreak ?? this.autoStartBreak,
      autoStartPomodoro: autoStartPomodoro ?? this.autoStartPomodoro,
    );
  }

  SettingState setUser({
    UserClockify? user,
  }) {
    return SettingState(
      loadingCheckClockify: loadingCheckClockify,
      user: user,
      workspaces: workspaces,
      selectedWorkspace: selectedWorkspace,
      projects: projects,
      loadingProjects: loadingProjects,
      autoStartBreak: autoStartBreak,
      autoStartPomodoro: autoStartPomodoro,
    );
  }

  SettingState setSelectedWorkspace({
    WorkspaceClockify? selectedWorkspace,
  }) {
    return SettingState(
      loadingCheckClockify: loadingCheckClockify,
      user: user,
      workspaces: workspaces,
      selectedWorkspace: selectedWorkspace,
      projects: projects,
      loadingProjects: loadingProjects,
      autoStartBreak: autoStartBreak,
      autoStartPomodoro: autoStartPomodoro,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingState &&
        other.loadingCheckClockify == loadingCheckClockify &&
        other.user == user &&
        listEquals(other.workspaces, workspaces) &&
        other.selectedWorkspace == selectedWorkspace &&
        other.loadingProjects == loadingProjects &&
        listEquals(other.projects, projects) &&
        other.autoStartBreak == autoStartBreak &&
        other.autoStartPomodoro == autoStartPomodoro;
  }

  @override
  int get hashCode {
    return loadingCheckClockify.hashCode ^
        user.hashCode ^
        workspaces.hashCode ^
        selectedWorkspace.hashCode ^
        loadingProjects.hashCode ^
        projects.hashCode ^
        autoStartBreak.hashCode ^
        autoStartPomodoro.hashCode;
  }
}
