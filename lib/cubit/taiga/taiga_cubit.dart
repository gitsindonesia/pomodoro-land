// ignore_for_file: use_build_context_synchronously

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
    final cached = await storage.readTasks(projectId, milestoneId);
    emit(state.copyWith(loadingTask: cached.isEmpty, tasks: cached));
    try {
      final tasks = await ServiceTaiga.tasks(token, projectId, milestoneId);
      emit(state.copyWith(tasks: tasks));
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
}
