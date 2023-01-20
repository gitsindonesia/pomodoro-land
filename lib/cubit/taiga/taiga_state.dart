part of 'taiga_cubit.dart';

class TaigaState {
  TaigaState({
    required this.loadingGlobal,
    required this.loadingProjectDetail,
    required this.loadingMilestone,
    required this.loadingTask,
    required this.loadingContent,
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
    this.milestone,
    required this.userStoryWithTask,
    required this.todos,
  });

  final bool loadingGlobal;
  final bool loadingProjectDetail;
  final bool loadingMilestone;
  final bool loadingTask;
  final bool loadingContent;
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
  final MilestoneResponse? milestone;
  final List<GroupUserStoryWithTask> userStoryWithTask;
  final List<Todo> todos;

  TaigaState setFilterAssign({
    MembersProjectDetailTaiga? filterAssign,
  }) {
    return TaigaState(
      loadingGlobal: loadingGlobal,
      loadingProjectDetail: loadingProjectDetail,
      loadingMilestone: loadingMilestone,
      loadingTask: loadingTask,
      loadingContent: loadingContent,
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
      milestone: milestone,
      userStoryWithTask: userStoryWithTask,
      todos: todos,
    );
  }

  TaigaState setFilterProgress(
      {TaskStatusesProjectDetailTaiga? filterProgress}) {
    return TaigaState(
      loadingGlobal: loadingGlobal,
      loadingProjectDetail: loadingProjectDetail,
      loadingMilestone: loadingMilestone,
      loadingTask: loadingTask,
      loadingContent: loadingContent,
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
      milestone: milestone,
      userStoryWithTask: userStoryWithTask,
      todos: todos,
    );
  }

  TaigaState copyWith({
    bool? loadingGlobal,
    bool? loadingProjectDetail,
    bool? loadingMilestone,
    bool? loadingTask,
    bool? loadingContent,
    List<ProjectTaigaResponse>? projects,
    ProjectTaigaResponse? selectedProject,
    ProjectDetailTaigaResponse? projectDetail,
    List<TasksResponse>? tasks,
    List<TasksResponse>? filteredTasks,
    int? selectedMilestoneId,
    List<TasksResponse>? taskToTodo,
    bool? allChecklist,
    MilestoneResponse? milestone,
    List<GroupUserStoryWithTask>? userStoryWithTask,
    List<Todo>? todos,
  }) {
    return TaigaState(
      loadingGlobal: loadingGlobal ?? this.loadingGlobal,
      loadingProjectDetail: loadingProjectDetail ?? this.loadingProjectDetail,
      loadingMilestone: loadingMilestone ?? this.loadingMilestone,
      loadingTask: loadingTask ?? this.loadingTask,
      loadingContent: loadingContent ?? this.loadingContent,
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
      milestone: milestone ?? this.milestone,
      userStoryWithTask: userStoryWithTask ?? this.userStoryWithTask,
      todos: todos ?? this.todos,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaigaState &&
        other.loadingGlobal == loadingGlobal &&
        other.loadingProjectDetail == loadingProjectDetail &&
        other.loadingMilestone == loadingMilestone &&
        other.loadingTask == loadingTask &&
        other.loadingContent == loadingContent &&
        listEquals(other.projects, projects) &&
        other.selectedProject == selectedProject &&
        other.projectDetail == projectDetail &&
        listEquals(other.tasks, tasks) &&
        listEquals(other.filteredTasks, filteredTasks) &&
        other.selectedMilestoneId == selectedMilestoneId &&
        listEquals(other.taskToTodo, taskToTodo) &&
        other.allChecklist == allChecklist &&
        other.filterAssign == filterAssign &&
        other.filterProgress == filterProgress &&
        other.milestone == milestone &&
        listEquals(other.userStoryWithTask, userStoryWithTask) &&
        listEquals(other.todos, todos);
  }

  @override
  int get hashCode {
    return loadingGlobal.hashCode ^
        loadingProjectDetail.hashCode ^
        loadingMilestone.hashCode ^
        loadingTask.hashCode ^
        loadingContent.hashCode ^
        projects.hashCode ^
        selectedProject.hashCode ^
        projectDetail.hashCode ^
        tasks.hashCode ^
        filteredTasks.hashCode ^
        selectedMilestoneId.hashCode ^
        taskToTodo.hashCode ^
        allChecklist.hashCode ^
        filterAssign.hashCode ^
        filterProgress.hashCode ^
        milestone.hashCode ^
        userStoryWithTask.hashCode ^
        todos.hashCode;
  }
}
