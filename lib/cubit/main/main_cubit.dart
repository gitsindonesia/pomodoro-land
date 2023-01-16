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
import 'package:pomodoro_land/widgets/button.dart';

import '../../model/history.dart';
import '../../model/todo.dart';
import '../../model/user.dart';
import '../../storage/history_storage.dart';
import '../../storage/todo_storage.dart';
import '../../widgets/dialog/setting/setting.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit()
      : super(MainState(
          round: 1,
          duration: const Duration(minutes: 25),
          isStart: false,
          todos: [],
          history: [],
          status: 'Focus',
          focusTodo: null,
          indexTab: 0,
          backgroundMusic: '',
          projects: [],
          loadingAddTimeClockify: false,
          selectedProject: null,
          indexTabPomodoro: 0,
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

  bool autoStartBreak = false;
  bool autoStartPomodoro = false;

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
    final oldDefaultPomodoro = defaultPomodoro;
    defaultPomodoro = await settingStorage.readPomodoroDuration();
    defaultShortBreak = await settingStorage.readShortBreakDuration();
    defaultLongBreak = await settingStorage.readLongBreakDuration();
    autoStartBreak = await settingStorage.readAutoStartBreak();
    autoStartPomodoro = await settingStorage.readAutoStartPomodoro();

    apiKeyClockify = await settingStorage.readApiKeyClockify();
    user = await settingStorage.readUserClockify();
    selectedWorkspace = await settingStorage.readSelectedWorkspaceClockify();
    final projects = await settingStorage.readProjectsClockify();
    final selectedProject = await settingStorage.readSelectedProjectClockify();

    emit(state.copyWith(
      duration: oldDefaultPomodoro == defaultPomodoro ? null : defaultPomodoro,
      projects: projects,
    ));
    emit(state.setSelectedProject(selectedProject));
  }

  void handleTimer(Timer timer) {
    if (!state.isStart) return;
    final duration = state.duration - const Duration(seconds: 1);
    emit(state.copyWith(duration: duration));
    if (duration.inSeconds == 0) {
      belPlayer.play(DeviceFileSource(Sound.bel));
      if (state.indexTabPomodoro == 0) {
        final round = state.round + 1;
        final isLongBreak = round % 4 == 0;
        emit(state.copyWith(
          round: round,
          duration: isLongBreak ? defaultLongBreak : defaultShortBreak,
          indexTabPomodoro: isLongBreak ? 2 : 1,
          isStart: autoStartBreak,
        ));
      } else {
        emit(state.copyWith(
          duration: defaultPomodoro,
          indexTabPomodoro: 0,
          isStart: autoStartPomodoro,
        ));
      }

      emit(state.copyWith(status: getStatusPomodoro()));
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
    updateTodo(
      todo,
      Todo(
        checklist: check,
        task: todo.task,
        dateTime: todo.dateTime,
        project: todo.project,
      ),
    );
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

  String getStatusPomodoro() {
    String status = '';
    if (state.indexTabPomodoro == 0) {
      status = 'Pomodoro';
    } else if (state.indexTabPomodoro == 1) {
      status = 'Short Break';
    } else {
      status = 'Long Break';
    }

    if (state.focusTodo != null) {
      return ' $status on ${state.focusTodo!.task}';
    }
    return status;
  }

  void writeCacheTodo() async {
    await todoStorage.write(state.todos);
  }

  void onAcceptDrag(Todo todo) {
    startDateTimeTask = DateTime.now();
    emit(state.setFocusTodo(todo));
    emit(state.copyWith(status: getStatusPomodoro()));
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

  void onEditTodoComplete(Todo todo, String task) {
    if (task.isEmpty) return;
    updateTodo(
      todo,
      Todo(
        checklist: todo.checklist,
        task: task,
        dateTime: todo.dateTime,
        project: todo.project,
      ),
    );
  }

  void onEditProjectTodo(Todo todo, Project? value) {
    updateTodo(
      todo,
      Todo(
        checklist: todo.checklist,
        task: todo.task,
        dateTime: todo.dateTime,
        project: value,
      ),
    );
  }

  void updateTodo(Todo oldTodo, Todo newTodo) {
    final todos = List<Todo>.from(state.todos);
    todos[todos.indexOf(oldTodo)] = newTodo;
    emit(state.copyWith(todos: todos));
    addOrUpdateHistory(todos);
    writeCacheTodo();
  }

  void onResetRoundPressed(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Refresh Count', style: TextStyle(fontSize: 42)),
          content: const Text('Do you want to refresh the pomodoro count?',
              style: TextStyle(fontSize: 24)),
          actions: [
            Button(
                text: 'Cancel', onPressed: () => Navigator.of(context).pop()),
            const SizedBox(width: 16),
            Button(
                text: 'Yes', onPressed: () => Navigator.of(context).pop(true)),
          ],
        );
      },
    );
    if (result == true) {
      emit(state.copyWith(round: 1));
    }
  }

  void onNextPomodoroPressed(BuildContext context) {
    final round = state.round + 1;
    if (state.indexTabPomodoro == 0 && round % 4 == 0) {
      setIndexPomodoro(context, 2, round: round, forceNext: true);
    } else if (state.indexTabPomodoro == 0) {
      setIndexPomodoro(context, 1, round: round, forceNext: true);
    } else {
      setIndexPomodoro(context, 0, forceNext: true);
    }
  }

  void setIndexPomodoro(
    BuildContext context,
    int index, {
    int? round,
    bool forceNext = false,
  }) async {
    bool updated = true;
    bool autoStart = false;
    Duration duration = defaultPomodoro;
    if (index == 0) {
      duration = defaultPomodoro;
      autoStart = autoStartPomodoro;
    } else if (index == 1) {
      duration = defaultShortBreak;
      autoStart = autoStartBreak;
    } else if (index == 2) {
      duration = defaultLongBreak;
      autoStart = autoStartBreak;
    }

    if (!forceNext && state.indexTabPomodoro != index && state.isStart) {
      final result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Switch', style: TextStyle(fontSize: 42)),
            content: const Text(
              'The timer is still running, are you sure you want to switch?',
              style: TextStyle(fontSize: 24),
            ),
            actions: [
              Button(
                text: 'Cancel',
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 16),
              Button(
                text: 'Yes',
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      );
      if (result == null) updated = false;
    }
    if (updated) {
      emit(state.copyWith(
        indexTabPomodoro: index,
        duration: duration,
        status: getStatusPomodoro(),
        round: round,
        isStart: autoStart,
      ));
    }
  }
}
