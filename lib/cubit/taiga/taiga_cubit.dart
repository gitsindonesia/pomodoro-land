// ignore_for_file: use_build_context_synchronously

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          loadingContent: false,
          projects: [],
          tasks: [],
          selectedMilestoneId: -1,
          taskToTodo: [],
          allChecklist: false,
          filteredTasks: [],
          userStoryWithTask: [],
          todos: [],
          projectsClockify: [],
        ));

  LoginTaigaResponse? loginTaiga;

  Map<int, TaskStatusesProjectDetailTaiga?> mapTaskIdWithChangedStatus = {};

  void initState(BuildContext context) {}

  void initAfterLayout(BuildContext context) async {
    setupTodos();
    setupProjectClockfify();
    loginTaiga = await TaigaStorage().readLogin();
    if (loginTaiga != null) {
      await fetchProjects(
        context,
        loginTaiga?.authToken ?? '',
        loginTaiga?.id ?? 0,
      );
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
    String token,
    int userId,
  ) async {
    emit(state.copyWith(loadingGlobal: true));
    final cached = await TaigaStorage().readProjects(userId);
    emit(state.copyWith(loadingGlobal: cached.isEmpty, projects: cached));
    try {
      final projects = await ServiceTaiga.projects(token, userId);
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
    emit(state.copyWith(selectedProject: project, selectedMilestoneId: -1));
    await fetchProjectDetail(context, loginTaiga?.authToken ?? '', project);
  }

  Future<void> fetchProjectDetail(
    BuildContext context,
    String token,
    ProjectTaigaResponse project,
  ) async {
    if (state.loadingProjectDetail) return;
    emit(state.copyWith(loadingMilestone: true));
    final cached = await TaigaStorage().readProjectDetail(project.slug ?? '');
    emit(state.copyWith(
        loadingMilestone: cached == null, projectDetail: cached));
    try {
      final projectDetail =
          await ServiceTaiga.projectDetail(token, project.slug ?? '');
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
  ) {
    emit(state.copyWith(selectedMilestoneId: 0));
    // TODO: handle fetch issue
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
    ));
    await Future.wait([
      fetchMilestoneCache(context, milestone.id ?? 0),
      fetchTasksCache(context, projectDetail.id ?? 0, milestone.id ?? 0),
    ]);
    setupGroupingUserStoryWithTask();
    filterTask();

    await Future.wait([
      fetchMilestone(
        context,
        loginTaiga?.authToken ?? '',
        milestone.id ?? 0,
      ),
      fetchTasks(
        context,
        loginTaiga?.authToken ?? '',
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
    String token,
    int milestoneId,
  ) async {
    if (state.loadingMilestone) return;
    emit(state.copyWith(loadingMilestone: true));
    try {
      final milestone = await ServiceTaiga.milestone(token, milestoneId);
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
    String token,
    int projectId,
    int milestoneId,
  ) async {
    if (state.loadingTask) return;
    emit(state.copyWith(loadingTask: true));
    try {
      final tasks = await ServiceTaiga.tasks(token, projectId, milestoneId);
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
    if (state.allChecklist) {
      emit(state.copyWith(taskToTodo: [], allChecklist: false));
    } else {
      emit(state.copyWith(taskToTodo: state.filteredTasks, allChecklist: true));
    }
  }

  void onChecklistTask(
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
    });
  }

  void onAddToTodo(BuildContext context) {
    Navigator.of(context).pop({
      'project_detail': state.projectDetail,
      'task_to_do': state.taskToTodo,
      'project_clockify': state.selectedProjectClockify,
      'map_task_id_with_changed_status': mapTaskIdWithChangedStatus,
    });
  }

  void onClearTaskTodo() =>
      emit(state.copyWith(taskToTodo: [], allChecklist: false));

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
    if (state.projectDetail == null &&
        userStory == null &&
        state.selectedMilestoneId <= 0) return;
    await launchUrlString(
      'https://taiga.gits.id/project/${state.projectDetail?.slug}/us/${userStory?.ref}?milestone=${state.selectedMilestoneId}',
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

  void onEditTaigaStatus(
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
        loginTaiga!.authToken ?? '',
        projectId: state.projectDetail?.id ?? 0,
        milestoneId: state.milestone?.id ?? 0,
        ref: task.ref ?? 0,
      );

      final success = await ServiceTaiga.changeTaskStatus(
        loginTaiga!.authToken ?? '',
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
}
