part of 'taiga_cubit.dart';

class TaigaState {
  TaigaState({
    required this.loadingGlobal,
    required this.loadingMilestone,
    required this.loadingTask,
    required this.projects,
    this.selectedProject,
    this.projectDetail,
    required this.tasks,
    required this.selectedMilestoneId,
  });

  final bool loadingGlobal;
  final bool loadingMilestone;
  final bool loadingTask;
  final List<ProjectTaigaResponse> projects;
  final ProjectTaigaResponse? selectedProject;
  final ProjectDetailTaigaResponse? projectDetail;
  final List<TasksResponse> tasks;
  final int selectedMilestoneId;

  TaigaState copyWith({
    bool? loadingGlobal,
    bool? loadingMilestone,
    bool? loadingTask,
    List<ProjectTaigaResponse>? projects,
    ProjectTaigaResponse? selectedProject,
    ProjectDetailTaigaResponse? projectDetail,
    List<TasksResponse>? tasks,
    int? selectedMilestoneId,
  }) {
    return TaigaState(
      loadingGlobal: loadingGlobal ?? this.loadingGlobal,
      loadingMilestone: loadingMilestone ?? this.loadingMilestone,
      loadingTask: loadingTask ?? this.loadingTask,
      projects: projects ?? this.projects,
      selectedProject: selectedProject ?? this.selectedProject,
      projectDetail: projectDetail ?? this.projectDetail,
      tasks: tasks ?? this.tasks,
      selectedMilestoneId: selectedMilestoneId ?? this.selectedMilestoneId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaigaState &&
        other.loadingGlobal == loadingGlobal &&
        other.loadingMilestone == loadingMilestone &&
        other.loadingTask == loadingTask &&
        listEquals(other.projects, projects) &&
        other.selectedProject == selectedProject &&
        other.projectDetail == projectDetail &&
        listEquals(other.tasks, tasks) &&
        other.selectedMilestoneId == selectedMilestoneId;
  }

  @override
  int get hashCode {
    return loadingGlobal.hashCode ^
        loadingMilestone.hashCode ^
        loadingTask.hashCode ^
        projects.hashCode ^
        selectedProject.hashCode ^
        projectDetail.hashCode ^
        tasks.hashCode ^
        selectedMilestoneId.hashCode;
  }
}
