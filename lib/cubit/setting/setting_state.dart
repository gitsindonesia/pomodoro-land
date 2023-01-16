part of 'setting_cubit.dart';

class SettingState {
  SettingState({
    required this.loadingCheckClockify,
    this.user,
    required this.workspaces,
    this.selectedWorkspace,
    required this.loadingProjects,
    required this.projects,
  });

  final bool loadingCheckClockify;
  final User? user;
  final List<Workspace> workspaces;
  final Workspace? selectedWorkspace;
  final bool loadingProjects;
  final List<Project> projects;

  SettingState copyWith({
    bool? loadingCheckClockify,
    List<Workspace>? workspaces,
    List<Project>? projects,
    bool? loadingProjects,
  }) {
    return SettingState(
      loadingCheckClockify: loadingCheckClockify ?? this.loadingCheckClockify,
      workspaces: workspaces ?? this.workspaces,
      selectedWorkspace: selectedWorkspace,
      user: user,
      projects: projects ?? this.projects,
      loadingProjects: loadingProjects ?? this.loadingProjects,
    );
  }

  SettingState setUser({
    User? user,
  }) {
    return SettingState(
      loadingCheckClockify: loadingCheckClockify,
      user: user,
      workspaces: workspaces,
      selectedWorkspace: selectedWorkspace,
      projects: projects,
      loadingProjects: loadingProjects,
    );
  }

  SettingState setSelectedWorkspace({
    Workspace? selectedWorkspace,
  }) {
    return SettingState(
      loadingCheckClockify: loadingCheckClockify,
      user: user,
      workspaces: workspaces,
      selectedWorkspace: selectedWorkspace,
      projects: projects,
      loadingProjects: loadingProjects,
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
        listEquals(other.projects, projects);
  }

  @override
  int get hashCode {
    return loadingCheckClockify.hashCode ^
        user.hashCode ^
        workspaces.hashCode ^
        selectedWorkspace.hashCode ^
        loadingProjects.hashCode ^
        projects.hashCode;
  }
}
