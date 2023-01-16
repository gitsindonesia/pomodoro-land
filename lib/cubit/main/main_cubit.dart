import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_land/constants/sound.dart';
import 'package:pomodoro_land/model/project.dart';
import 'package:pomodoro_land/model/workspace.dart';
import 'package:pomodoro_land/service/service.dart';
import 'package:pomodoro_land/storage/setting_storage.dart';
import 'package:pomodoro_land/widgets/dialog/setting.dart';

import '../../model/history.dart';
import '../../model/todo.dart';
import '../../model/user.dart';
import '../../storage/history_storage.dart';
import '../../storage/todo_storage.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit()
      : super(MainState(
          round: 1,
          duration: const Duration(minutes: 25),
          isStart: false,
          isBreak: false,
          todos: [],
          history: [],
          status: 'Focus',
          focusTodo: null,
          indexTab: 0,
          backgroundMusic: '',
          projects: [],
          loadingAddTimeClockify: false,
          selectedProject: null,
        ));

  final now = DateTime.now();
  final dateFormat = DateFormat('yyyy-MM-dd');
  Duration defaultPomodoro = const Duration(minutes: 25);
  Duration defaultShortBreak = const Duration(minutes: 5);
  Duration defaultLongBreak = const Duration(minutes: 15);
  final todoStorage = TodoStorage();
  final historyStorage = HistoryStorage();
  final settingStorage = SettingStorage();

  final buttonPlayer = AudioPlayer(playerId: 'buttonPlayer');
  final belPlayer = AudioPlayer(playerId: 'belPlayer');
  final backgroundPlayer = AudioPlayer(playerId: 'backgroundPlayer');
  final controller = TextEditingController();

  DateTime startDateTimeTask = DateTime.now();

  String? apiKeyClockify;
  User? user;
  Workspace? selectedWorkspace;

  void initState(BuildContext context) {
    backgroundPlayer.setReleaseMode(ReleaseMode.loop);
    Timer.periodic(const Duration(seconds: 1), handleTimer);
  }

  void initAfterLayout(BuildContext context) async {
    List<Todo> newTodos = await todoStorage.read();
    newTodos = newTodos
        .where((element) =>
            _calculateDifference(element.dateTime) == 0 || !element.checklist)
        .toList();
    final newHistory = await historyStorage.read();
    emit(state.copyWith(todos: newTodos, history: newHistory));

    await setupSetting();
  }

  Future<void> setupSetting() async {
    defaultPomodoro = await settingStorage.readPomodoroDuration();
    defaultShortBreak = await settingStorage.readShortBreakDuration();
    defaultLongBreak = await settingStorage.readLongBreakDuration();

    apiKeyClockify = await settingStorage.readApiKeyClockify();
    user = await settingStorage.readUserClockify();
    selectedWorkspace = await settingStorage.readSelectedWorkspaceClockify();
    final projects = await settingStorage.readProjectsClockify();
    final selectedProject = await settingStorage.readSelectedProjectClockify();

    emit(state.copyWith(duration: defaultPomodoro, projects: projects));
    emit(state.setSelectedProject(selectedProject));
  }

  void handleTimer(Timer timer) {
    if (!state.isStart) return;
    final duration = state.duration - const Duration(seconds: 1);
    emit(state.copyWith(duration: duration));
    if (duration.inSeconds == 0) {
      belPlayer.play(DeviceFileSource(Sound.bel));
      if (state.isBreak) {
        emit(state.copyWith(
          isBreak: false,
          duration: defaultPomodoro,
          round: state.round + 1,
        ));
      } else {
        emit(state.copyWith(
          isBreak: true,
          duration: state.round % 4 == 0 ? defaultLongBreak : defaultShortBreak,
        ));
      }

      emit(state.copyWith(
        status: state.focusTodo == null ? getStatusPomodoro() : null,
      ));
    }
  }

  void onStartPressed() async {
    buttonPlayer.play(DeviceFileSource(Sound.button));

    if (state.backgroundMusic.isNotEmpty) {
      if (!state.isStart && backgroundPlayer.state == PlayerState.stopped) {
        await backgroundPlayer.play(UrlSource(state.backgroundMusic));
      } else if (backgroundPlayer.state == PlayerState.playing) {
        await backgroundPlayer.stop();
      }
    }

    emit(state.copyWith(isStart: !state.isStart));
  }

  void onAddTodoComplete(String value) {
    emit(state.copyWith(
      todos: [
        ...state.todos,
        Todo(
          checklist: false,
          task: value,
          dateTime: DateTime.now(),
          project: state.selectedProject,
        ),
      ],
    ));
    writeCacheTodo();
  }

  void onDeleteTodo(Todo value) {
    final todos = List<Todo>.from(state.todos);
    todos.remove(value);
    emit(state.copyWith(todos: todos));
    addOrUpdateHistory(todos);
    writeCacheTodo();
  }

  void onCheckChanged(bool check, Todo todo) {
    final todos = List<Todo>.from(state.todos);
    todos[todos.indexOf(todo)] = Todo(
      checklist: check,
      task: todo.task,
      dateTime: DateTime.now(),
      project: todo.project,
    );
    emit(state.copyWith(todos: todos));
    addOrUpdateHistory(todos);
    writeCacheTodo();
  }

  void addOrUpdateHistory(List<Todo> todos) {
    final history = List<History>.from(state.history);
    final index = state.history.indexWhere(
        (element) => dateFormat.format(now) == dateFormat.format(element.date));
    final newTodos = todos.where((element) => element.checklist).toList();
    if (index == -1 && newTodos.isNotEmpty) {
      history.add(History(date: now, todos: newTodos));
    } else if (index >= 0 && newTodos.isEmpty) {
      history.removeAt(index);
    } else if (index >= 0 && newTodos.isNotEmpty) {
      history[index] = History(date: now, todos: newTodos);
    }
    historyStorage.write(now, history);
    emit(state.copyWith(history: history));
  }

  String getStatusPomodoro() => state.isBreak ? 'Break' : 'Focus';

  void writeCacheTodo() async {
    await todoStorage.write(state.todos);
  }

  void onAcceptDrag(Todo todo) {
    startDateTimeTask = DateTime.now();
    emit(state.setFocusTodo(todo));
    emit(state.copyWith(status: '${getStatusPomodoro()} on ${todo.task}'));
  }

  void onDoneFocusTodo(Todo todo) async {
    if (todo.project != null) {
      emit(state.copyWith(loadingAddTimeClockify: true));
      await Service.addTimeEntry(
        apiKey: apiKeyClockify ?? '',
        workspaceId: selectedWorkspace?.id ?? '',
        projectId: todo.project?.id ?? '',
        startTime: startDateTimeTask,
        endTime: DateTime.now(),
        description: todo.task,
      );
    }
    onCheckChanged(true, todo);
    emit(state.setFocusTodo(null));
    emit(state.copyWith(
      status: getStatusPomodoro(),
      loadingAddTimeClockify: false,
    ));
  }

  void onClearFocusTodo() {
    emit(state.setFocusTodo(null));
    emit(state.copyWith(status: getStatusPomodoro()));
  }

  void setIndex(int index) => emit(state.copyWith(indexTab: index));

  int _calculateDifference(DateTime date) {
    final now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  void onSettingPressed(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const Setting(),
    );
    await setupSetting();
  }

  void onBackgroundMusicChanged(String? value) async {
    if (value != null) {
      emit(state.copyWith(backgroundMusic: value));
      if (state.isStart && value.isNotEmpty) {
        if (backgroundPlayer.state == PlayerState.playing) {
          await backgroundPlayer.stop();
        }
        await Future.delayed(const Duration(seconds: 1));
        await backgroundPlayer.play(UrlSource(value));
      } else if (state.isStart &&
          value.isEmpty &&
          backgroundPlayer.state == PlayerState.playing) {
        await backgroundPlayer.stop();
      }
    }
  }

  void onProjectSelected(Project? selectedProject) async {
    emit(state.setSelectedProject(selectedProject));
    await settingStorage.writeSelectedProjectClockify(selectedProject);
  }
}
