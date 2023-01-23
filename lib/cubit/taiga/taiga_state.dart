part of 'taiga_cubit.dart';

class TaigaState {
  TaigaState({
    required this.loadingGlobal,
    required this.loadingProjectDetail,
    required this.loadingMilestone,
    required this.loadingTask,
    required this.loadingFilterIssue,
    required this.loadingIssue,
    required this.loadingContent,
    required this.projects,
    this.selectedProject,
    this.projectDetail,
    required this.tasks,
    required this.filteredTasks,
    required this.selectedMilestoneId,
    required this.taskToTodo,
    required this.allTaskChecklist,
    this.filterAssign,
    this.filterProgress,
    this.milestone,
    required this.userStoryWithTask,
    required this.todos,
    required this.projectsClockify,
    this.selectedProjectClockify,
    this.filterIssue,
    required this.selectedFilterIssue,
    required this.issues,
    required this.paginationIssues,
    required this.selectedPageIssue,
    required this.issueToTodo,
    required this.allIssueChecklist,
  });

  final bool loadingGlobal;
  final bool loadingProjectDetail;
  final bool loadingMilestone;
  final bool loadingTask;
  final bool loadingFilterIssue;
  final bool loadingIssue;
  final bool loadingContent;
  final List<ProjectTaigaResponse> projects;
  final ProjectTaigaResponse? selectedProject;
  final ProjectDetailTaigaResponse? projectDetail;
  final List<TasksResponse> tasks;
  final List<TasksResponse> filteredTasks;
  final int selectedMilestoneId;
  final List<TasksResponse> taskToTodo;
  final bool allTaskChecklist;
  final MembersProjectDetailTaiga? filterAssign;
  final TaskStatusesProjectDetailTaiga? filterProgress;
  final MilestoneResponse? milestone;
  final List<GroupUserStoryWithTask> userStoryWithTask;
  final List<Todo> todos;
  final List<ProjectClockify> projectsClockify;
  final ProjectClockify? selectedProjectClockify;
  final FilterIssueResponse? filterIssue;
  final FilterIssueResponse selectedFilterIssue;
  final List<IssueResponse> issues;
  final Pagination paginationIssues;
  final int selectedPageIssue;
  final List<IssueResponse> issueToTodo;
  final bool allIssueChecklist;

  TaigaState setFilterAssign({
    MembersProjectDetailTaiga? filterAssign,
  }) {
    return TaigaState(
      loadingGlobal: loadingGlobal,
      loadingProjectDetail: loadingProjectDetail,
      loadingMilestone: loadingMilestone,
      loadingTask: loadingTask,
      loadingFilterIssue: loadingFilterIssue,
      loadingIssue: loadingIssue,
      loadingContent: loadingContent,
      projects: projects,
      selectedProject: selectedProject,
      projectDetail: projectDetail,
      tasks: tasks,
      selectedMilestoneId: selectedMilestoneId,
      taskToTodo: taskToTodo,
      allTaskChecklist: allTaskChecklist,
      filterAssign: filterAssign,
      filterProgress: filterProgress,
      filteredTasks: filteredTasks,
      milestone: milestone,
      userStoryWithTask: userStoryWithTask,
      todos: todos,
      projectsClockify: projectsClockify,
      selectedProjectClockify: selectedProjectClockify,
      filterIssue: filterIssue,
      selectedFilterIssue: selectedFilterIssue,
      issues: issues,
      paginationIssues: paginationIssues,
      selectedPageIssue: selectedPageIssue,
      issueToTodo: issueToTodo,
      allIssueChecklist: allIssueChecklist,
    );
  }

  TaigaState setFilterProgress(
      {TaskStatusesProjectDetailTaiga? filterProgress}) {
    return TaigaState(
      loadingGlobal: loadingGlobal,
      loadingProjectDetail: loadingProjectDetail,
      loadingMilestone: loadingMilestone,
      loadingTask: loadingTask,
      loadingFilterIssue: loadingFilterIssue,
      loadingIssue: loadingIssue,
      loadingContent: loadingContent,
      projects: projects,
      selectedProject: selectedProject,
      projectDetail: projectDetail,
      tasks: tasks,
      selectedMilestoneId: selectedMilestoneId,
      taskToTodo: taskToTodo,
      allTaskChecklist: allTaskChecklist,
      filterAssign: filterAssign,
      filterProgress: filterProgress,
      filteredTasks: filteredTasks,
      milestone: milestone,
      userStoryWithTask: userStoryWithTask,
      todos: todos,
      projectsClockify: projectsClockify,
      selectedProjectClockify: selectedProjectClockify,
      filterIssue: filterIssue,
      selectedFilterIssue: selectedFilterIssue,
      issues: issues,
      paginationIssues: paginationIssues,
      selectedPageIssue: selectedPageIssue,
      issueToTodo: issueToTodo,
      allIssueChecklist: allIssueChecklist,
    );
  }

  TaigaState setSelectedProjectClockify({
    ProjectClockify? selectedProjectClockify,
  }) {
    return TaigaState(
      loadingGlobal: loadingGlobal,
      loadingProjectDetail: loadingProjectDetail,
      loadingMilestone: loadingMilestone,
      loadingTask: loadingTask,
      loadingFilterIssue: loadingFilterIssue,
      loadingIssue: loadingIssue,
      loadingContent: loadingContent,
      projects: projects,
      selectedProject: selectedProject,
      projectDetail: projectDetail,
      tasks: tasks,
      selectedMilestoneId: selectedMilestoneId,
      taskToTodo: taskToTodo,
      allTaskChecklist: allTaskChecklist,
      filterAssign: filterAssign,
      filterProgress: filterProgress,
      filteredTasks: filteredTasks,
      milestone: milestone,
      userStoryWithTask: userStoryWithTask,
      todos: todos,
      projectsClockify: projectsClockify,
      selectedProjectClockify: selectedProjectClockify,
      filterIssue: filterIssue,
      selectedFilterIssue: selectedFilterIssue,
      issues: issues,
      paginationIssues: paginationIssues,
      selectedPageIssue: selectedPageIssue,
      issueToTodo: issueToTodo,
      allIssueChecklist: allIssueChecklist,
    );
  }

  TaigaState copyWith({
    bool? loadingGlobal,
    bool? loadingProjectDetail,
    bool? loadingMilestone,
    bool? loadingTask,
    bool? loadingFilterIssue,
    bool? loadingIssue,
    bool? loadingContent,
    List<ProjectTaigaResponse>? projects,
    ProjectTaigaResponse? selectedProject,
    ProjectDetailTaigaResponse? projectDetail,
    List<TasksResponse>? tasks,
    List<TasksResponse>? filteredTasks,
    int? selectedMilestoneId,
    List<TasksResponse>? taskToTodo,
    bool? allTaskChecklist,
    MilestoneResponse? milestone,
    List<GroupUserStoryWithTask>? userStoryWithTask,
    List<Todo>? todos,
    List<ProjectClockify>? projectsClockify,
    FilterIssueResponse? filterIssue,
    FilterIssueResponse? selectedFilterIssue,
    List<IssueResponse>? issues,
    Pagination? paginationIssues,
    int? selectedPageIssue,
    List<IssueResponse>? issueToTodo,
    bool? allIssueChecklist,
  }) {
    return TaigaState(
      loadingGlobal: loadingGlobal ?? this.loadingGlobal,
      loadingProjectDetail: loadingProjectDetail ?? this.loadingProjectDetail,
      loadingMilestone: loadingMilestone ?? this.loadingMilestone,
      loadingTask: loadingTask ?? this.loadingTask,
      loadingFilterIssue: loadingFilterIssue ?? this.loadingFilterIssue,
      loadingIssue: loadingIssue ?? this.loadingIssue,
      loadingContent: loadingContent ?? this.loadingContent,
      projects: projects ?? this.projects,
      selectedProject: selectedProject ?? this.selectedProject,
      projectDetail: projectDetail ?? this.projectDetail,
      tasks: tasks ?? this.tasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      selectedMilestoneId: selectedMilestoneId ?? this.selectedMilestoneId,
      taskToTodo: taskToTodo ?? this.taskToTodo,
      allTaskChecklist: allTaskChecklist ?? this.allTaskChecklist,
      filterAssign: filterAssign,
      filterProgress: filterProgress,
      milestone: milestone ?? this.milestone,
      userStoryWithTask: userStoryWithTask ?? this.userStoryWithTask,
      todos: todos ?? this.todos,
      projectsClockify: projectsClockify ?? this.projectsClockify,
      selectedProjectClockify: selectedProjectClockify,
      filterIssue: filterIssue ?? this.filterIssue,
      selectedFilterIssue: selectedFilterIssue ?? this.selectedFilterIssue,
      issues: issues ?? this.issues,
      paginationIssues: paginationIssues ?? this.paginationIssues,
      selectedPageIssue: selectedPageIssue ?? this.selectedPageIssue,
      issueToTodo: issueToTodo ?? this.issueToTodo,
      allIssueChecklist: allIssueChecklist ?? this.allIssueChecklist,
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
        other.loadingFilterIssue == loadingFilterIssue &&
        other.loadingIssue == loadingIssue &&
        other.loadingContent == loadingContent &&
        listEquals(other.projects, projects) &&
        other.selectedProject == selectedProject &&
        other.projectDetail == projectDetail &&
        listEquals(other.tasks, tasks) &&
        listEquals(other.filteredTasks, filteredTasks) &&
        other.selectedMilestoneId == selectedMilestoneId &&
        listEquals(other.taskToTodo, taskToTodo) &&
        other.allTaskChecklist == allTaskChecklist &&
        other.filterAssign == filterAssign &&
        other.filterProgress == filterProgress &&
        other.milestone == milestone &&
        listEquals(other.userStoryWithTask, userStoryWithTask) &&
        listEquals(other.todos, todos) &&
        listEquals(other.projectsClockify, projectsClockify) &&
        other.selectedProjectClockify == selectedProjectClockify &&
        other.filterIssue == filterIssue &&
        other.selectedFilterIssue == selectedFilterIssue &&
        listEquals(other.issues, issues) &&
        other.paginationIssues == paginationIssues &&
        other.selectedPageIssue == selectedPageIssue &&
        listEquals(other.issueToTodo, issueToTodo) &&
        other.allIssueChecklist == allIssueChecklist;
  }

  @override
  int get hashCode {
    return loadingGlobal.hashCode ^
        loadingProjectDetail.hashCode ^
        loadingMilestone.hashCode ^
        loadingTask.hashCode ^
        loadingFilterIssue.hashCode ^
        loadingIssue.hashCode ^
        loadingContent.hashCode ^
        projects.hashCode ^
        selectedProject.hashCode ^
        projectDetail.hashCode ^
        tasks.hashCode ^
        filteredTasks.hashCode ^
        selectedMilestoneId.hashCode ^
        taskToTodo.hashCode ^
        allTaskChecklist.hashCode ^
        filterAssign.hashCode ^
        filterProgress.hashCode ^
        milestone.hashCode ^
        userStoryWithTask.hashCode ^
        todos.hashCode ^
        projectsClockify.hashCode ^
        selectedProjectClockify.hashCode ^
        filterIssue.hashCode ^
        selectedFilterIssue.hashCode ^
        issues.hashCode ^
        paginationIssues.hashCode ^
        selectedPageIssue.hashCode ^
        issueToTodo.hashCode ^
        allIssueChecklist.hashCode;
  }
}
