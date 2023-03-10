import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/model/clockify/project_clockify.dart';
import 'package:pomodoro_land/model/clockify/user_clockify.dart';
import 'package:pomodoro_land/model/clockify/workspace_clockify.dart';
import 'package:pomodoro_land/storage/setting_storage.dart';
import 'package:pomodoro_land/utils/extension.dart';

import '../../service/service_clockify.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit()
      : super(SettingState(
          loadingCheckClockify: false,
          workspaces: [],
          loadingProjects: false,
          projects: [],
          autoStartBreak: false,
          autoStartPomodoro: false,
          alarm: '',
          alarmVolume: 50,
        ));

  final storage = SettingStorage();

  final controllerPomodoro = TextEditingController();
  final controllerShortBreak = TextEditingController();
  final controllerLongBreak = TextEditingController();
  final controllerApiKeyClockify = TextEditingController();

  String? apiKeyClockify;

  final alarmPlayer = AudioPlayer(playerId: 'alarmPlayer');

  void initState(BuildContext context) {}

  void initAfterLayout(BuildContext context) async {
    final alarm = await storage.readAlarm();
    final alarmVolume = await storage.readAlarmVolume();
    alarmPlayer.setVolume(alarmVolume / 100);

    final defaultPomodoro = await storage.readPomodoroDuration();
    final defaultShortBreak = await storage.readShortBreakDuration();
    final defaultLongBreak = await storage.readLongBreakDuration();
    final autoStartBreak = await storage.readAutoStartBreak();
    final autoStartPomodoro = await storage.readAutoStartPomodoro();

    controllerPomodoro.text = defaultPomodoro.inMinutes.toString();
    controllerShortBreak.text = defaultShortBreak.inMinutes.toString();
    controllerLongBreak.text = defaultLongBreak.inMinutes.toString();

    apiKeyClockify = await storage.readApiKeyClockify();
    final user = await storage.readUserClockify();
    final workspaces = await storage.readWorkspacesClockify();
    final selectedWorkspace = await storage.readSelectedWorkspaceClockify();
    final projects = await storage.readProjectsClockify();

    controllerApiKeyClockify.text = apiKeyClockify ?? '';
    emit(state.copyWith(
      alarm: alarm,
      alarmVolume: alarmVolume,
      workspaces: workspaces,
      projects: projects,
      autoStartBreak: autoStartBreak,
      autoStartPomodoro: autoStartPomodoro,
    ));
    emit(state.setUser(user: user));
    emit(state.setSelectedWorkspace(selectedWorkspace: selectedWorkspace));
  }

  @override
  Future<void> close() {
    controllerPomodoro.dispose();
    controllerShortBreak.dispose();
    controllerLongBreak.dispose();
    controllerApiKeyClockify.dispose();
    alarmPlayer.dispose();
    return super.close();
  }

  void onCheckApiKeyClockify(BuildContext context, String apiKey) async {
    if (apiKey.isEmpty) return;
    emit(state.copyWith(loadingCheckClockify: true, workspaces: []));
    emit(state.setUser(user: null));
    try {
      final user = await ServiceClockify.getUser(apiKey);
      final workspaces = await ServiceClockify.getWorkspaces(apiKey);

      apiKeyClockify = apiKey;
      emit(state.setUser(user: user));
      emit(state.copyWith(workspaces: workspaces));
    } catch (e) {
      handleErrorResponseClockify(context);
    }

    emit(state.copyWith(loadingCheckClockify: false));
  }

  void onChangeWorkspace(
      BuildContext context, WorkspaceClockify? selectedWorkspace) async {
    if (selectedWorkspace == null) return;
    emit(state.setSelectedWorkspace(selectedWorkspace: selectedWorkspace));
    if (apiKeyClockify != null) {
      emit(state.copyWith(loadingProjects: true));
      try {
        final projects = await ServiceClockify.getProjects(
            apiKeyClockify!, selectedWorkspace.id);

        emit(state.copyWith(projects: projects));
      } catch (e) {
        handleErrorResponseClockify(context);
      }
      emit(state.copyWith(loadingProjects: false));
    }
  }

  void handleErrorResponseClockify(BuildContext context) {
    Navigator.of(context).pop();
    context.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[100],
        content: Text(
          'Your clockify api might have a typo, please check again and try again',
          style: TextStyle(fontSize: 20, color: Colors.red[700]),
        ),
      ),
    );
  }

  void onSavePressed(BuildContext context) async {
    if (state.loadingCheckClockify || state.loadingProjects) return;

    if (controllerPomodoro.text.isNotEmpty) {
      await storage.writePomodoroDuration(
        Duration(minutes: int.parse(controllerPomodoro.text)),
      );
    }
    if (controllerShortBreak.text.isNotEmpty) {
      await storage.writeShortBreakDuration(
        Duration(minutes: int.parse(controllerShortBreak.text)),
      );
    }
    if (controllerLongBreak.text.isNotEmpty) {
      await storage.writeLongBreakDuration(
        Duration(minutes: int.parse(controllerLongBreak.text)),
      );
    }

    if (apiKeyClockify != null && (apiKeyClockify?.isNotEmpty ?? false)) {
      await storage.writeApiKeyClockify(apiKeyClockify!);
    }

    if (state.user != null) {
      await storage.writeUserClockify(state.user!);
    }

    if (state.workspaces.isNotEmpty) {
      await storage.writeWorkspacesClockify(state.workspaces);
    }

    if (state.selectedWorkspace != null) {
      await storage.writeSelectedWorkspaceClockify(state.selectedWorkspace!);
    }

    if (state.projects.isNotEmpty) {
      await storage.writeProjectsClockify(state.projects);
    }

    await storage.writeAutoStartBreak(state.autoStartBreak);
    await storage.writeAutoStartPomodoro(state.autoStartPomodoro);

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  void onToggleAutoStartBreakChanged(bool autoStartBreak) async {
    emit(state.copyWith(autoStartBreak: autoStartBreak));
  }

  void onToggleAutoStartPomodoroChanged(bool autoStartPomodoro) async {
    emit(state.copyWith(autoStartPomodoro: autoStartPomodoro));
  }

  void onAlarmSelected(String? value) async {
    emit(state.copyWith(alarm: value));
    if (value != null) {
      await SettingStorage().writeAlarm(value);
      if (alarmPlayer.state == PlayerState.playing) {
        await alarmPlayer.stop();
      }
      await alarmPlayer.play(AssetSource(value));
    }
  }

  void onAlarmVolumeChanged(double value) {
    emit(state.copyWith(alarmVolume: value.toInt()));
  }

  void onAlarmVolumeEndedChanged(double value) async {
    final alarmVolume = value.toInt();
    await SettingStorage().writeAlarmVolume(alarmVolume);
    alarmPlayer.setVolume(value / 100);
  }
}
