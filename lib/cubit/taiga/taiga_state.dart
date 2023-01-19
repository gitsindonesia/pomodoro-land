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
    required this.filteredTasks,
    required this.selectedMilestoneId,
    required this.taskToTodo,
    required this.allChecklist,
    this.filterAssign,
    this.filterProgress,
  });

  final bool loadingGlobal;
  final bool loadingMilestone;
  final bool loadingTask;
  final List<ProjectTaigaResponse> projects;
  final ProjectTaigaResponse? selectedProject;
  final ProjectDetailTaigaResponse? projectDetail;
  final List<TasksResponse> tasks;
  final List<TasksResponse> filteredTasks;
  final int selectedMilestoneId;
  final List<TasksResponse> taskToTodo;
  final bool allChecklist;
  final MembersProjectDetailTaiga? filterAssign;
  final TaskStatusesProjectDetailTaiga? filterProgress;

  TaigaState setFilterAssign({
    MembersProjectDetailTaiga? filterAssign,
  }) {
    return TaigaState(
      loadingGlobal: loadingGlobal,
      loadingMilestone: loadingMilestone,
      loadingTask: loadingTask,
      projects: projects,
      selectedProject: selectedProject,
      projectDetail: projectDetail,
      tasks: tasks,
      selectedMilestoneId: selectedMilestoneId,
      taskToTodo: taskToTodo,
      allChecklist: allChecklist,
      filterAssign: filterAssign,
      filterProgress: filterProgress,
      filteredTasks: filteredTasks,
    );
  }

  TaigaState setFilterProgress(
      {TaskStatusesProjectDetailTaiga? filterProgress}) {
    return TaigaState(
      loadingGlobal: loadingGlobal,
      loadingMilestone: loadingMilestone,
      loadingTask: loadingTask,
      projects: projects,
      selectedProject: selectedProject,
      projectDetail: projectDetail,
      tasks: tasks,
      selectedMilestoneId: selectedMilestoneId,
      taskToTodo: taskToTodo,
      allChecklist: allChecklist,
      filterAssign: filterAssign,
      filterProgress: filterProgress,
      filteredTasks: filteredTasks,
    );
  }

  TaigaState copyWith({
    bool? loadingGlobal,
    bool? loadingMilestone,
    bool? loadingTask,
    List<ProjectTaigaResponse>? projects,
    ProjectTaigaResponse? selectedProject,
    ProjectDetailTaigaResponse? projectDetail,
    List<TasksResponse>? tasks,
    List<TasksResponse>? filteredTasks,
    int? selectedMilestoneId,
    List<TasksResponse>? taskToTodo,
    bool? allChecklist,
  }) {
    return TaigaState(
      loadingGlobal: loadingGlobal ?? this.loadingGlobal,
      loadingMilestone: loadingMilestone ?? this.loadingMilestone,
      loadingTask: loadingTask ?? this.loadingTask,
      projects: projects ?? this.projects,
      selectedProject: selectedProject ?? this.selectedProject,
      projectDetail: projectDetail ?? this.projectDetail,
      tasks: tasks ?? this.tasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      selectedMilestoneId: selectedMilestoneId ?? this.selectedMilestoneId,
      taskToTodo: taskToTodo ?? this.taskToTodo,
      allChecklist: allChecklist ?? this.allChecklist,
      filterAssign: filterAssign,
      filterProgress: filterProgress,
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
        listEquals(other.filteredTasks, filteredTasks) &&
        other.selectedMilestoneId == selectedMilestoneId &&
        listEquals(other.taskToTodo, taskToTodo) &&
        other.allChecklist == allChecklist &&
        other.filterAssign == filterAssign &&
        other.filterProgress == filterProgress;
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
        filteredTasks.hashCode ^
        selectedMilestoneId.hashCode ^
        taskToTodo.hashCode ^
        allChecklist.hashCode ^
        filterAssign.hashCode ^
        filterProgress.hashCode;
  }
}
