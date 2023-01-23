part of 'main_cubit.dart';

class MainState {
  MainState({
    required this.round,
    required this.duration,
    required this.isStart,
    required this.todos,
    required this.history,
    this.focusTodo,
    required this.indexTab,
    required this.backgroundMusic,
    required this.projects,
    this.selectedProject,
    required this.loadingAddTimeClockify,
    required this.indexTabPomodoro,
    required this.startDateTimeTask,
    required this.loadingGlobal,
  });

  final int round;
  final Duration duration;
  final bool isStart;
  final List<Todo> todos;
  final List<History> history;
  final Todo? focusTodo;
  final int indexTab;
  final String backgroundMusic;
  final List<ProjectClockify> projects;
  final ProjectClockify? selectedProject;
  final bool loadingAddTimeClockify;
  final int indexTabPomodoro;
  final DateTime startDateTimeTask;
  final bool loadingGlobal;

  MainState setFocusTodo(Todo? focusTodo) {
    return MainState(
      round: round,
      duration: duration,
      isStart: isStart,
      todos: todos,
      history: history,
      focusTodo: focusTodo,
      indexTab: indexTab,
      backgroundMusic: backgroundMusic,
      projects: projects,
      selectedProject: selectedProject,
      loadingAddTimeClockify: loadingAddTimeClockify,
      indexTabPomodoro: indexTabPomodoro,
      startDateTimeTask: startDateTimeTask,
      loadingGlobal: loadingGlobal,
    );
  }

  MainState setSelectedProject(ProjectClockify? selectedProject) {
    return MainState(
      round: round,
      duration: duration,
      isStart: isStart,
      todos: todos,
      history: history,
      focusTodo: focusTodo,
      indexTab: indexTab,
      backgroundMusic: backgroundMusic,
      projects: projects,
      selectedProject: selectedProject,
      loadingAddTimeClockify: loadingAddTimeClockify,
      indexTabPomodoro: indexTabPomodoro,
      startDateTimeTask: startDateTimeTask,
      loadingGlobal: loadingGlobal,
    );
  }

  MainState copyWith({
    int? round,
    Duration? duration,
    bool? isStart,
    List<Todo>? todos,
    List<History>? history,
    int? indexTab,
    String? backgroundMusic,
    List<ProjectClockify>? projects,
    bool? loadingAddTimeClockify,
    int? indexTabPomodoro,
    DateTime? startDateTimeTask,
    bool? loadingGlobal,
  }) {
    return MainState(
      round: round ?? this.round,
      duration: duration ?? this.duration,
      isStart: isStart ?? this.isStart,
      todos: todos ?? this.todos,
      history: history ?? this.history,
      focusTodo: focusTodo,
      indexTab: indexTab ?? this.indexTab,
      backgroundMusic: backgroundMusic ?? this.backgroundMusic,
      projects: projects ?? this.projects,
      selectedProject: selectedProject,
      loadingAddTimeClockify:
          loadingAddTimeClockify ?? this.loadingAddTimeClockify,
      indexTabPomodoro: indexTabPomodoro ?? this.indexTabPomodoro,
      startDateTimeTask: startDateTimeTask ?? this.startDateTimeTask,
      loadingGlobal: loadingGlobal ?? this.loadingGlobal,
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
        other.indexTab == indexTab &&
        other.backgroundMusic == backgroundMusic &&
        listEquals(other.projects, projects) &&
        other.selectedProject == selectedProject &&
        other.loadingAddTimeClockify == loadingAddTimeClockify &&
        other.indexTabPomodoro == indexTabPomodoro &&
        other.startDateTimeTask == startDateTimeTask &&
        other.loadingGlobal == loadingGlobal;
  }

  @override
  int get hashCode {
    return round.hashCode ^
        duration.hashCode ^
        isStart.hashCode ^
        todos.hashCode ^
        history.hashCode ^
        focusTodo.hashCode ^
        indexTab.hashCode ^
        backgroundMusic.hashCode ^
        projects.hashCode ^
        selectedProject.hashCode ^
        loadingAddTimeClockify.hashCode ^
        indexTabPomodoro.hashCode ^
        startDateTimeTask.hashCode ^
        loadingGlobal.hashCode;
  }
}
