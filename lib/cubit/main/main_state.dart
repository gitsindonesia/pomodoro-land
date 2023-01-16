part of 'main_cubit.dart';

class MainState {
  MainState({
    required this.round,
    required this.duration,
    required this.isStart,
    required this.isBreak,
    required this.todos,
    required this.history,
    this.focusTodo,
    required this.status,
    required this.indexTab,
    required this.backgroundMusic,
    required this.projects,
    this.selectedProject,
    required this.loadingAddTimeClockify,
  });

  final int round;
  final Duration duration;
  final bool isStart;
  final bool isBreak;
  final List<Todo> todos;
  final List<History> history;
  final Todo? focusTodo;
  final String status;
  final int indexTab;
  final String backgroundMusic;
  final List<Project> projects;
  final Project? selectedProject;
  final bool loadingAddTimeClockify;

  MainState setFocusTodo(Todo? focusTodo) {
    return MainState(
      round: round,
      duration: duration,
      isStart: isStart,
      isBreak: isBreak,
      todos: todos,
      history: history,
      status: status,
      focusTodo: focusTodo,
      indexTab: indexTab,
      backgroundMusic: backgroundMusic,
      projects: projects,
      selectedProject: selectedProject,
      loadingAddTimeClockify: loadingAddTimeClockify,
    );
  }

  MainState setSelectedProject(Project? selectedProject) {
    return MainState(
      round: round,
      duration: duration,
      isStart: isStart,
      isBreak: isBreak,
      todos: todos,
      history: history,
      status: status,
      focusTodo: focusTodo,
      indexTab: indexTab,
      backgroundMusic: backgroundMusic,
      projects: projects,
      selectedProject: selectedProject,
      loadingAddTimeClockify: loadingAddTimeClockify,
    );
  }

  MainState copyWith({
    int? round,
    Duration? duration,
    bool? isStart,
    bool? isBreak,
    List<Todo>? todos,
    List<History>? history,
    String? status,
    int? indexTab,
    String? backgroundMusic,
    List<Project>? projects,
    bool? loadingAddTimeClockify,
  }) {
    return MainState(
      round: round ?? this.round,
      duration: duration ?? this.duration,
      isStart: isStart ?? this.isStart,
      isBreak: isBreak ?? this.isBreak,
      todos: todos ?? this.todos,
      history: history ?? this.history,
      focusTodo: focusTodo,
      status: status ?? this.status,
      indexTab: indexTab ?? this.indexTab,
      backgroundMusic: backgroundMusic ?? this.backgroundMusic,
      projects: projects ?? this.projects,
      selectedProject: selectedProject,
      loadingAddTimeClockify:
          loadingAddTimeClockify ?? this.loadingAddTimeClockify,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MainState &&
        other.round == round &&
        other.duration == duration &&
        other.isStart == isStart &&
        other.isBreak == isBreak &&
        listEquals(other.todos, todos) &&
        listEquals(other.history, history) &&
        other.focusTodo == focusTodo &&
        other.status == status &&
        other.indexTab == indexTab &&
        other.backgroundMusic == backgroundMusic &&
        listEquals(other.projects, projects) &&
        other.selectedProject == selectedProject &&
        other.loadingAddTimeClockify == loadingAddTimeClockify;
  }

  @override
  int get hashCode {
    return round.hashCode ^
        duration.hashCode ^
        isStart.hashCode ^
        isBreak.hashCode ^
        todos.hashCode ^
        history.hashCode ^
        focusTodo.hashCode ^
        status.hashCode ^
        indexTab.hashCode ^
        backgroundMusic.hashCode ^
        projects.hashCode ^
        selectedProject.hashCode ^
        loadingAddTimeClockify.hashCode;
  }
}
