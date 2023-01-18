// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/model/taiga/response/login_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_detail_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_taiga_response.dart';
import 'package:pomodoro_land/service/service_taiga.dart';
import 'package:pomodoro_land/storage/taiga_storage.dart';
import 'package:pomodoro_land/utils/extension.dart';

part 'taiga_state.dart';

class TaigaCubit extends Cubit<TaigaState> {
  TaigaCubit()
      : super(TaigaState(
          loadingGlobal: false,
          loadingContent: false,
          projects: [],
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
    emit(state.copyWith(selectedProject: project));
    await fetchProjectDetail(context, loginTaiga?.authToken ?? '', project);
  }

  Future<void> fetchProjectDetail(
    BuildContext context,
    String token,
    ProjectTaigaResponse project,
  ) async {
    emit(state.copyWith(loadingContent: true));
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
    emit(state.copyWith(loadingContent: false));
  }

  void onIssuePressed(
      BuildContext context, ProjectDetailTaigaResponse projectDetail) {}

  void onMilestonePressed(
      BuildContext context, ProjectDetailTaigaResponse projectDetail) {}
}
