// ignore_for_file: use_build_context_synchronously

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/model/pagination.dart';
import 'package:pomodoro_land/model/taiga/response/filter_issue_response.dart';
import 'package:pomodoro_land/model/taiga/response/issue_response.dart';
import 'package:pomodoro_land/model/taiga/response/login_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/milestone_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_detail_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/tasks_response.dart';
import 'package:pomodoro_land/service/service_taiga.dart';
import 'package:pomodoro_land/storage/taiga_storage.dart';
import 'package:pomodoro_land/utils/extension.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../model/clockify/project_clockify.dart';
import '../../model/grouping_user_story_with_task.dart';
import '../../model/todo.dart';
import '../../storage/setting_storage.dart';
import '../../storage/todo_storage.dart';

part 'taiga_state.dart';

class TaigaCubit extends Cubit<TaigaState> {
  TaigaCubit()
      : super(TaigaState(
          loadingGlobal: false,
          loadingProjectDetail: false,
          loadingMilestone: false,
          loadingTask: false,
          loadingFilterIssue: false,
          loadingContent: false,
          projects: [],
          tasks: [],
          selectedMilestoneId: -1,
          taskToTodo: [],
          allTaskChecklist: false,
          filteredTasks: [],
          userStoryWithTask: [],
          todos: [],
          projectsClockify: [],
          selectedFilterIssue: FilterIssueResponse.fromMap({}),
          issues: [],
          paginationIssues: Pagination.fromMap({}),
          loadingIssue: false,
          selectedPageIssue: 1,
          issueToTodo: [],
          allIssueChecklist: false,
        ));

  LoginTaigaResponse? loginTaiga;

  Map<int, TaskStatusesProjectDetailTaiga?> mapTaskIdWithChangedStatus = {};
  Map<int, IssueStatusesProjectDetailTaiga?> mapIssueIdWithChangedStatus = {};

  void initState(BuildContext context) {}

  void initAfterLayout(BuildContext context) async {
    setupTodos();
    setupProjectClockfify();
    loginTaiga = await TaigaStorage().readLogin();
    if (loginTaiga != null) {
      await fetchProjects(context, loginTaiga?.id ?? 0);
    }
  }

  void setupTodos() async {
    List<Todo> todos = await TodoStorage().read();
    todos = todos.where((element) => element.taiga != null).toList();
    emit(state.copyWith(todos: todos));
  }

  void setupProjectClockfify() async {
    final projectsClockify = await SettingStorage().readProjectsClockify();
    final selectedProjectClockify =
        await SettingStorage().readSelectedProjectClockify();
    emit(state.copyWith(projectsClockify: projectsClockify));
    emit(state.setSelectedProjectClockify(
        selectedProjectClockify: selectedProjectClockify));
  }

  Future<void> fetchProjects(
    BuildContext context,
    int userId,
  ) async {
    emit(state.copyWith(loadingGlobal: true));
    final cached = await TaigaStorage().readProjects(userId);
    emit(state.copyWith(loadingGlobal: cached.isEmpty, projects: cached));
    try {
      final projects = await ServiceTaiga.projects(userId);
      emit(state.copyWith(projects: projects));
    } catch (e) {
      context.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[100],
          content: Text(
            e.toString(),
            style: TextStyle(fontSize: 20, color: Colors.red[700]),
          ),
        ),
      );
    }
    emit(state.copyWith(loadingGlobal: false));
  }

  void onProjectPressed(
    BuildContext context,
    ProjectTaigaResponse project,
  ) async {
    if (state.loadingProjectDetail) return;
    emit(state.copyWith(
      selectedProject: project,
      selectedMilestoneId: -1,
    ));
    await fetchProjectDetail(context, project);
  }

  Future<void> fetchProjectDetail(
    BuildContext context,
    ProjectTaigaResponse project,
  ) async {
    if (state.loadingProjectDetail) return;
    emit(state.copyWith(loadingMilestone: true));
    final cached = await TaigaStorage().readProjectDetail(project.slug ?? '');
    emit(state.copyWith(
        loadingMilestone: cached == null, projectDetail: cached));
    try {
      final projectDetail =
          await ServiceTaiga.projectDetail(project.slug ?? '');
      emit(state.copyWith(projectDetail: projectDetail));
    } catch (e) {
      context.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[100],
          content: Text(
            e.toString(),
            style: TextStyle(fontSize: 20, color: Colors.red[700]),
          ),
        ),
      );
    }
    emit(state.copyWith(loadingMilestone: false));
  }

  void onIssuePressed(
    BuildContext context,
    ProjectDetailTaigaResponse projectDetail,
  ) async {
    final selectedFilterIssue = await TaigaStorage().readSelectedFilterIssue(
      projectDetail.id ?? 0,
    );
    emit(state.copyWith(
      selectedMilestoneId: 0,
      loadingContent: true,
      selectedFilterIssue: selectedFilterIssue,
      selectedPageIssue: 1,
      taskToTodo: [],
      allTaskChecklist: false,
    ));
    await Future.wait([
      fetchFilterIssue(context, projectDetail.id ?? 0),
      fetchIssues(
        context: context,
        page: state.selectedPageIssue,
        projectId: projectDetail.id ?? 0,
      ),
    ]);

    emit(state.copyWith(loadingContent: false));
  }

  Future<void> fetchFilterIssue(
    BuildContext context,
    int projectId,
  ) async {
    if (state.loadingFilterIssue) return;
    emit(state.copyWith(loadingFilterIssue: true));
    final cached = await TaigaStorage().readFilterIssue(projectId);
    emit(state.copyWith(
        loadingFilterIssue: cached == null, filterIssue: cached));
    try {
      final filterIssue = await ServiceTaiga.filterIssue(projectId);
      emit(state.copyWith(filterIssue: filterIssue));
    } catch (e) {
      context.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[100],
          content: Text(
            e.toString(),
            style: TextStyle(fontSize: 20, color: Colors.red[700]),
          ),
        ),
      );
    }
    emit(state.copyWith(loadingFilterIssue: false));
  }

  void onMilestonePressed(
    BuildContext context,
    ProjectDetailTaigaResponse projectDetail,
    MilestonesProjectDetailTaiga milestone,
  ) async {
    if (state.loadingContent) return;
    emit(state.copyWith(
      selectedMilestoneId: milestone.id,
      loadingContent: true,
      issueToTodo: [],
      allIssueChecklist: false,
    ));
    await Future.wait([
      fetchMilestoneCache(context, milestone.id ?? 0),
      fetchTasksCache(context, projectDetail.id ?? 0, milestone.id ?? 0),
    ]);
    setupGroupingUserStoryWithTask();
    filterTask();

    await Future.wait([
      fetchMilestone(context, milestone.id ?? 0),
      fetchTasks(
        context,
        projectDetail.id ?? 0,
        milestone.id ?? 0,
      ),
    ]);
    setupGroupingUserStoryWithTask();
    filterTask();
    emit(state.copyWith(loadingContent: false));
  }

  void setupGroupingUserStoryWithTask() {
    List<GroupUserStoryWithTask> userStoryWithTask = [];
    for (var userStory in state.milestone?.userStories ?? []) {
      final tasks = state.filteredTasks
          .where((element) => element.userStory == userStory.id)
          .toList();
      userStoryWithTask.add(GroupUserStoryWithTask(
        userStory: userStory,
        tasks: tasks,
      ));
    }

    final storylessTask = state.filteredTasks
        .where((element) => element.userStory == null)
        .toList();
    userStoryWithTask.add(GroupUserStoryWithTask(
      userStory: null,
      tasks: storylessTask,
    ));

    emit(state.copyWith(userStoryWithTask: userStoryWithTask));
  }

  Future<void> fetchMilestoneCache(
    BuildContext context,
    int milestoneId,
  ) async {
    emit(state.copyWith(loadingMilestone: true));
    final cached = await TaigaStorage().readMilestone(milestoneId);
    emit(state.copyWith(loadingMilestone: false, milestone: cached));
  }

  Future<void> fetchMilestone(
    BuildContext context,
    int milestoneId,
  ) async {
    if (state.loadingMilestone) return;
    emit(state.copyWith(loadingMilestone: true));
    try {
      final milestone = await ServiceTaiga.milestone(milestoneId);
      emit(state.copyWith(milestone: milestone));
    } catch (e) {
      context.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[100],
          content: Text(
            e.toString(),
            style: TextStyle(fontSize: 20, color: Colors.red[700]),
          ),
        ),
      );
    }
    emit(state.copyWith(loadingMilestone: false));
  }

  Future<void> fetchTasksCache(
    BuildContext context,
    int projectId,
    int milestoneId,
  ) async {
    emit(state.copyWith(loadingTask: true));
    final cached = await TaigaStorage().readTasks(projectId, milestoneId);
    emit(state.copyWith(
      loadingTask: false,
      tasks: cached,
      filteredTasks: cached,
    ));
  }

  Future<void> fetchTasks(
    BuildContext context,
    int projectId,
    int milestoneId,
  ) async {
    if (state.loadingTask) return;
    emit(state.copyWith(loadingTask: true));
    try {
      final tasks = await ServiceTaiga.tasks(projectId, milestoneId);
      emit(state.copyWith(tasks: tasks, filteredTasks: tasks));
    } catch (e) {
      context.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[100],
          content: Text(
            e.toString(),
            style: TextStyle(fontSize: 20, color: Colors.red[700]),
          ),
        ),
      );
    }
    emit(state.copyWith(loadingTask: false));
  }

  void onChecklistAllTask() {
    if (state.allTaskChecklist) {
      emit(state.copyWith(taskToTodo: [], allTaskChecklist: false));
    } else {
      emit(state.copyWith(
          taskToTodo: state.filteredTasks, allTaskChecklist: true));
    }
  }

  void onChecklistItemTask(
      BuildContext context, TasksResponse e, bool alreadyInTodo) {
    if (alreadyInTodo) {
      context.showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue[100],
          content: Text(
            'This task is already in Todo',
            style: TextStyle(fontSize: 20, color: Colors.blue[700]),
          ),
        ),
      );
      return;
    }
    if (state.taskToTodo.firstWhereOrNull((element) => e == element) == null) {
      emit(state.copyWith(
        taskToTodo: [...state.taskToTodo, e],
      ));
    } else {
      final taskToTodo = List<TasksResponse>.from(state.taskToTodo);
      taskToTodo.remove(e);
      emit(state.copyWith(taskToTodo: taskToTodo));
    }
  }

  void onClosePressed(BuildContext context) {
    Navigator.of(context).pop({
      'project_detail': state.projectDetail,
      'task_to_do': state.taskToTodo,
      'project_clockify': state.selectedProjectClockify,
      'map_task_id_with_changed_status': mapTaskIdWithChangedStatus,
      'issue_to_do': state.issueToTodo,
      'map_issue_id_with_changed_status': mapIssueIdWithChangedStatus,
    });
  }

  void onAddToTodo(BuildContext context) {
    Navigator.of(context).pop({
      'project_detail': state.projectDetail,
      'task_to_do': state.taskToTodo,
      'project_clockify': state.selectedProjectClockify,
      'map_task_id_with_changed_status': mapTaskIdWithChangedStatus,
      'issue_to_do': state.issueToTodo,
      'map_issue_id_with_changed_status': mapIssueIdWithChangedStatus,
    });
  }

  void onClearTodo() => emit(state.copyWith(
        taskToTodo: [],
        issueToTodo: [],
        allTaskChecklist: false,
        allIssueChecklist: false,
      ));

  void onFilterAssignChanged(MembersProjectDetailTaiga? value) {
    emit(state.setFilterAssign(filterAssign: value));
    filterTask();
  }

  void onFilterProgressChanged(TaskStatusesProjectDetailTaiga? value) {
    emit(state.setFilterProgress(filterProgress: value));
    filterTask();
  }

  void filterTask() {
    List<TasksResponse> filteredTask = List<TasksResponse>.from(state.tasks);
    filteredTask = filteredTask
        .where((element) =>
            (state.filterProgress == null
                ? true
                : state.filterProgress?.id == element.status) &&
            (state.filterAssign == null
                ? true
                : state.filterAssign?.id == element.assignedTo))
        .toList();
    emit(state.copyWith(filteredTasks: filteredTask));
    setupGroupingUserStoryWithTask();
  }

  void onUserStoryPressed(
    BuildContext context,
    UserStoriesMilestone? userStory,
  ) async {
    if (state.projectDetail == null ||
        userStory == null ||
        state.selectedMilestoneId <= 0) return;
    await launchUrlString(
      'https://taiga.gits.id/project/${state.projectDetail?.slug}/us/${userStory.ref}?milestone=${state.selectedMilestoneId}',
    );
  }

  void onTaskPressed(BuildContext context, TasksResponse task) async {
    await launchUrlString(
      'https://taiga.gits.id/project/${state.projectDetail?.slug}/task/${task.ref ?? 0}',
    );
  }

  void onProjectClockifySelected(ProjectClockify? value) async {
    emit(state.setSelectedProjectClockify(selectedProjectClockify: value));
    await SettingStorage().writeSelectedProjectClockify(value);
  }

  void onEditTaskTaigaStatus(
    BuildContext context,
    TasksResponse task,
    TaskStatusesProjectDetailTaiga? value,
    bool alreadyInTodo,
  ) async {
    emit(state.copyWith(loadingContent: true));
    if (loginTaiga != null &&
        state.projectDetail != null &&
        state.milestone != null) {
      final taskDetail = await ServiceTaiga.taskDetail(
        projectId: state.projectDetail?.id ?? 0,
        milestoneId: state.milestone?.id ?? 0,
        ref: task.ref ?? 0,
      );

      final success = await ServiceTaiga.changeTaskStatus(
        taskId: taskDetail.id ?? 0,
        statusId: value?.id ?? 0,
        version: taskDetail.version ?? 0,
      );

      if (!success) {
        context.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red[100],
            content: Text(
              '''Oops, something went wrong...
Some other user inside Taiga has changed this before and your changes can’t be applied. Save them elsewhere, reload the page and re-apply your changes again or they will be lost.''',
              style: TextStyle(fontSize: 20, color: Colors.red[700]),
            ),
          ),
        );
      } else {
        mapTaskIdWithChangedStatus[taskDetail.id ?? 0] = value;

        List<TasksResponse> tasks = List.from(state.tasks);
        final indexTask = tasks.indexWhere((element) => element.id == task.id);
        if (indexTask != -1) {
          tasks[indexTask] = tasks[indexTask].copyWith(
            status: value?.id,
            statusExtraInfo: tasks[indexTask].statusExtraInfo?.copyWith(
                  name: value?.name,
                  color: value?.color,
                  isClosed: value?.isClosed,
                ),
          );
          await TaigaStorage().writeTasks(
            state.projectDetail?.id ?? 0,
            state.milestone?.id ?? 0,
            tasks,
          );
        }
      }
    }
    emit(state.copyWith(loadingContent: false));
  }

  void onFilterIssueTypeSelected(TypesFilterIssue value) {
    final data =
        List<TypesFilterIssue>.from(state.selectedFilterIssue.types ?? []);
    if (data.firstWhereOrNull((element) => element == value) == null) {
      data.add(value);
    } else {
      data.remove(value);
    }
    emit(state.copyWith(
      selectedFilterIssue: state.selectedFilterIssue.copyWith(types: data),
    ));
  }

  void onFilterIssueSeveritySelected(SeveritiesFilterIssue value) {
    final data = List<SeveritiesFilterIssue>.from(
        state.selectedFilterIssue.severities ?? []);
    if (data.firstWhereOrNull((element) => element == value) == null) {
      data.add(value);
    } else {
      data.remove(value);
    }
    emit(state.copyWith(
      selectedFilterIssue: state.selectedFilterIssue.copyWith(severities: data),
    ));
  }

  onFilterIssuePrioritySelected(PrioritiesFilterIssue value) {
    final data = List<PrioritiesFilterIssue>.from(
        state.selectedFilterIssue.priorities ?? []);
    if (data.firstWhereOrNull((element) => element == value) == null) {
      data.add(value);
    } else {
      data.remove(value);
    }
    emit(state.copyWith(
      selectedFilterIssue: state.selectedFilterIssue.copyWith(priorities: data),
    ));
  }

  onFilterIssueStatusSelected(StatusesFilterIssue value) {
    final data = List<StatusesFilterIssue>.from(
        state.selectedFilterIssue.statuses ?? []);
    if (data.firstWhereOrNull((element) => element == value) == null) {
      data.add(value);
    } else {
      data.remove(value);
    }
    emit(state.copyWith(
      selectedFilterIssue: state.selectedFilterIssue.copyWith(statuses: data),
    ));
  }

  void onFilterIssueTagSelected(TagsFilterIssue value) {
    final data =
        List<TagsFilterIssue>.from(state.selectedFilterIssue.tags ?? []);
    if (data.firstWhereOrNull((element) => element == value) == null) {
      data.add(value);
    } else {
      data.remove(value);
    }
    emit(state.copyWith(
      selectedFilterIssue: state.selectedFilterIssue.copyWith(tags: data),
    ));
  }

  void onFilterIssueAssignToSelected(AssignedToFilterIssue value) {
    final data = List<AssignedToFilterIssue>.from(
        state.selectedFilterIssue.assignedTo ?? []);
    if (data.firstWhereOrNull((element) => element == value) == null) {
      data.add(value);
    } else {
      data.remove(value);
    }
    emit(state.copyWith(
      selectedFilterIssue: state.selectedFilterIssue.copyWith(assignedTo: data),
    ));
  }

  void onFilterIssueRoleSelected(RolesFilterIssue value) {
    final data =
        List<RolesFilterIssue>.from(state.selectedFilterIssue.roles ?? []);
    if (data.firstWhereOrNull((element) => element == value) == null) {
      data.add(value);
    } else {
      data.remove(value);
    }
    emit(state.copyWith(
      selectedFilterIssue: state.selectedFilterIssue.copyWith(roles: data),
    ));
  }

  void onFilterIssueOwnerSelected(OwnersFilterIssue value) {
    final data =
        List<OwnersFilterIssue>.from(state.selectedFilterIssue.owners ?? []);
    if (data.firstWhereOrNull((element) => element == value) == null) {
      data.add(value);
    } else {
      data.remove(value);
    }
    emit(state.copyWith(
      selectedFilterIssue: state.selectedFilterIssue.copyWith(owners: data),
    ));
  }

  void onClearFilterIssuePressed(BuildContext context) => emit(
      state.copyWith(selectedFilterIssue: FilterIssueResponse.fromMap({})));

  void onApplyFilterIssuePressed(BuildContext context) async {
    await TaigaStorage().writeSelectedFilterIssue(
      state.projectDetail?.id ?? 0,
      state.selectedFilterIssue,
    );

    emit(state.copyWith(loadingContent: true, selectedPageIssue: 1));
    await fetchIssues(
      context: context,
      page: state.selectedPageIssue,
      projectId: state.projectDetail?.id ?? 0,
    );
    emit(state.copyWith(loadingContent: false));
  }

  Future<void> fetchIssues({
    required BuildContext context,
    required int page,
    required int projectId,
  }) async {
    if (state.loadingIssue) return;
    emit(state.copyWith(loadingIssue: true));
    try {
      final issues = await ServiceTaiga.issues(
        page: page,
        projectId: projectId,
        filterIssue: state.selectedFilterIssue,
      );
      emit(
          state.copyWith(paginationIssues: issues.item1, issues: issues.item2));
    } catch (e) {
      context.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[100],
          content: Text(
            e.toString(),
            style: TextStyle(fontSize: 20, color: Colors.red[700]),
          ),
        ),
      );
    }
    emit(state.copyWith(loadingIssue: false));
  }

  void onItemIssuePressed(BuildContext context, IssueResponse issue) async {
    await launchUrlString(
      'https://taiga.gits.id/project/${state.projectDetail?.slug}/issue/${issue.ref ?? 0}',
    );
  }

  void onChecklistItemIssue(
      BuildContext context, IssueResponse issue, bool alreadyInTodo) {
    if (alreadyInTodo) {
      context.showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue[100],
          content: Text(
            'This issue is already in Todo',
            style: TextStyle(fontSize: 20, color: Colors.blue[700]),
          ),
        ),
      );
      return;
    }
    if (state.issueToTodo.firstWhereOrNull((element) => issue == element) ==
        null) {
      emit(state.copyWith(
        issueToTodo: [...state.issueToTodo, issue],
      ));
    } else {
      final issueToTodo = List<IssueResponse>.from(state.issueToTodo);
      issueToTodo.remove(issue);
      emit(state.copyWith(issueToTodo: issueToTodo));
    }
  }

  void onEditIssueTaigaStatus(
    BuildContext context,
    IssueResponse issue,
    IssueStatusesProjectDetailTaiga? value,
    bool alreadyInTodo,
  ) async {
    emit(state.copyWith(loadingContent: true));
    if (loginTaiga != null && state.projectDetail != null) {
      final issueDetail = await ServiceTaiga.issueDetail(
        projectId: state.projectDetail?.id ?? 0,
        ref: issue.ref ?? 0,
      );

      final success = await ServiceTaiga.changeIssueStatus(
        issueId: issueDetail.id ?? 0,
        statusId: value?.id ?? 0,
        version: issueDetail.version ?? 0,
      );

      if (!success) {
        context.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red[100],
            content: Text(
              '''Oops, something went wrong...
Some other user inside Taiga has changed this before and your changes can’t be applied. Save them elsewhere, reload the page and re-apply your changes again or they will be lost.''',
              style: TextStyle(fontSize: 20, color: Colors.red[700]),
            ),
          ),
        );
      } else {
        mapIssueIdWithChangedStatus[issueDetail.id ?? 0] = value;
      }
    }
    emit(state.copyWith(loadingContent: false));
  }

  void onNumberPaginationPressed(BuildContext context, int page) {
    emit(state.copyWith(selectedPageIssue: page));
    fetchIssues(
      context: context,
      page: page,
      projectId: state.projectDetail?.id ?? 0,
    );
  }

  void onChecklistAllIssue() {
    if (state.allIssueChecklist) {
      emit(state.copyWith(issueToTodo: [], allIssueChecklist: false));
    } else {
      emit(state.copyWith(issueToTodo: state.issues, allIssueChecklist: true));
    }
  }
}
