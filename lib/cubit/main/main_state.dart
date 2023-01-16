part of 'main_cubit.dart';

class MainState {
  MainState({
    required this.round,
    required this.duration,
    required this.isStart,
    required this.todos,
    required this.history,
    this.focusTodo,
    required this.status,
    required this.indexTab,
    required this.backgroundMusic,
    required this.projects,
    this.selectedProject,
    required this.loadingAddTimeClockify,
    required this.indexTabPomodoro,
  });

  final int round;
  final Duration duration;
  final bool isStart;
  final List<Todo> todos;
  final List<History> history;
  final Todo? focusTodo;
  final String status;
  final int indexTab;
  final String backgroundMusic;
  final List<Project> projects;
  final Project? selectedProject;
  final bool loadingAddTimeClockify;
  final int indexTabPomodoro;

  MainState setFocusTodo(Todo? focusTodo) {
    return MainState(
      round: round,
      duration: duration,
      isStart: isStart,
      todos: todos,
      history: history,
      status: status,
      focusTodo: focusTodo,
      indexTab: indexTab,
      backgroundMusic: backgroundMusic,
      projects: projects,
      selectedProject: selectedProject,
      loadingAddTimeClockify: loadingAddTimeClockify,
      indexTabPomodoro: indexTabPomodoro,
    );
  }

  MainState setSelectedProject(Project? selectedProject) {
    return MainState(
      round: round,
      duration: duration,
      isStart: isStart,
      todos: todos,
      history: history,
      status: status,
      focusTodo: focusTodo,
      indexTab: indexTab,
      backgroundMusic: backgroundMusic,
      projects: projects,
      selectedProject: selectedProject,
      loadingAddTimeClockify: loadingAddTimeClockify,
      indexTabPomodoro: indexTabPomodoro,
    );
  }

  MainState copyWith({
    int? round,
    Duration? duration,
    bool? isStart,
    List<Todo>? todos,
    List<History>? history,
    String? status,
    int? indexTab,
    String? backgroundMusic,
    List<Project>? projects,
    bool? loadingAddTimeClockify,
    int? indexTabPomodoro,
  }) {
    return MainState(
      round: round ?? this.round,
      duration: duration ?? this.duration,
      isStart: isStart ?? this.isStart,
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
      indexTabPomodoro: indexTabPomodoro ?? this.indexTabPomodoro,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MainState &&
        other.round == round &&
        other.duration == duration &&
        other.isStart == isStart &&
        listEquals(other.todos, todos) &&
        listEquals(other.history, history) &&
        other.focusTodo == focusTodo &&
        other.status == status &&
        other.indexTab == indexTab &&
        other.backgroundMusic == backgroundMusic &&
        listEquals(other.projects, projects) &&
        other.selectedProject == selectedProject &&
        other.loadingAddTimeClockify == loadingAddTimeClockify &&
        other.indexTabPomodoro == indexTabPomodoro;
  }

  @override
  int get hashCode {
    return round.hashCode ^
        duration.hashCode ^
        isStart.hashCode ^
        todos.hashCode ^
        history.hashCode ^
        focusTodo.hashCode ^
        status.hashCode ^
        indexTab.hashCode ^
        backgroundMusic.hashCode ^
        projects.hashCode ^
        selectedProject.hashCode ^
        loadingAddTimeClockify.hashCode ^
        indexTabPomodoro.hashCode;
  }
}
