// ignore_for_file: use_build_context_synchronously

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/model/taiga/response/login_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_detail_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/tasks_response.dart';
import 'package:pomodoro_land/service/service_taiga.dart';
import 'package:pomodoro_land/storage/taiga_storage.dart';
import 'package:pomodoro_land/utils/extension.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'taiga_state.dart';

class TaigaCubit extends Cubit<TaigaState> {
  TaigaCubit()
      : super(TaigaState(
          loadingGlobal: false,
          loadingMilestone: false,
          loadingTask: false,
          projects: [],
          tasks: [],
          selectedMilestoneId: -1,
          taskToTodo: [],
          allChecklist: false,
          filteredTasks: [],
        ));

  final storage = TaigaStorage();
  LoginTaigaResponse? loginTaiga;

  void initState(BuildContext context) {}

  void initAfterLayout(BuildContext context) async {
    loginTaiga = await storage.readLogin();
    if (loginTaiga != null) {
      await fetchProjects(
        context,
        loginTaiga?.authToken ?? '',
        loginTaiga?.id ?? 0,
      );
    }
  }

  Future<void> fetchProjects(
    BuildContext context,
    String token,
    int userId,
  ) async {
    emit(state.copyWith(loadingGlobal: true));
    final cached = await storage.readProjects(userId);
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
    if (state.selectedProject == project) return;
    emit(state.copyWith(selectedProject: project, selectedMilestoneId: -1));
    await fetchProjectDetail(context, loginTaiga?.authToken ?? '', project);
  }

  Future<void> fetchProjectDetail(
    BuildContext context,
    String token,
    ProjectTaigaResponse project,
  ) async {
    emit(state.copyWith(loadingMilestone: true));
    final cached = await storage.readProjectDetail(project.slug ?? '');
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
    if (state.selectedMilestoneId == milestone.id) return;
    emit(state.copyWith(selectedMilestoneId: milestone.id));
    await fetchTasks(
      context,
      loginTaiga?.authToken ?? '',
      projectDetail.id ?? 0,
      milestone.id ?? 0,
    );
  }

  Future<void> fetchTasks(
    BuildContext context,
    String token,
    int projectId,
    int milestoneId,
  ) async {
    emit(state.copyWith(loadingTask: true));
    final cached = await storage.readTasks(projectId, milestoneId);
    emit(state.copyWith(loadingTask: cached.isEmpty, tasks: cached));
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

  void onChecklistTask(TasksResponse e) {
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

  void onAddToTodo(BuildContext context) {
    Navigator.of(context).pop(state.taskToTodo);
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
  }

  void onUserStoryPressed(
    BuildContext context,
    UserStoryExtraInfoTasks? userStory,
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
}
