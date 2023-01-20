import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_land/constants/sounds.dart';
import 'package:pomodoro_land/model/clockify/project_clockify.dart';
import 'package:pomodoro_land/model/clockify/workspace_clockify.dart';
import 'package:pomodoro_land/model/taiga.dart';
import 'package:pomodoro_land/model/taiga/response/login_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/project_detail_taiga_response.dart';
import 'package:pomodoro_land/model/taiga/response/tasks_response.dart';
import 'package:pomodoro_land/service/service_clockify.dart';
import 'package:pomodoro_land/service/service_taiga.dart';
import 'package:pomodoro_land/storage/setting_storage.dart';
import 'package:pomodoro_land/utils/extension.dart';
import 'package:pomodoro_land/widgets/button.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/auth_taiga.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/taiga_dashboard.dart';

import '../../model/clockify/user_clockify.dart';
import '../../model/history.dart';
import '../../model/todo.dart';
import '../../storage/history_storage.dart';
import '../../storage/taiga_storage.dart';
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
          focusTodo: null,
          indexTab: 0,
          backgroundMusic: '',
          projects: [],
          loadingAddTimeClockify: false,
          selectedProject: null,
          indexTabPomodoro: 0,
          startDateTimeTask: DateTime.now(),
          loadingGlobal: false,
        ));

  final now = DateTime.now();
  final dateFormat = DateFormat('yyyy-MM-dd');
  Duration defaultPomodoro = const Duration(minutes: 25);
  Duration defaultShortBreak = const Duration(minutes: 5);
  Duration defaultLongBreak = const Duration(minutes: 15);
  final todoStorage = TodoStorage();
  final historyStorage = HistoryStorage();
  final settingStorage = SettingStorage();
  final taigaStorage = TaigaStorage();

  final buttonPlayer = AudioPlayer(playerId: 'buttonPlayer');
  final belPlayer = AudioPlayer(playerId: 'belPlayer');
  final backgroundPlayer = AudioPlayer(playerId: 'backgroundPlayer');
  final controller = TextEditingController();

  String? apiKeyClockify;
  UserClockify? user;
  WorkspaceClockify? selectedWorkspace;

  bool autoStartBreak = false;
  bool autoStartPomodoro = false;

  LoginTaigaResponse? loginTaiga;

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

    loginTaiga = await taigaStorage.readLogin();

    emit(state.copyWith(
      duration: oldDefaultPomodoro == defaultPomodoro ? null : defaultPomodoro,
      projects: projects,
    ));
    emit(state.setSelectedProject(selectedProject));

    if (apiKeyClockify != null && selectedWorkspace != null) {
      final projects = await ServiceClockify.getProjects(
        apiKeyClockify!,
        selectedWorkspace!.id,
      );
      emit(state.copyWith(projects: projects));
    }
  }

  void handleTimer(Timer timer) {
    if (!state.isStart) return;
    final duration = state.duration - const Duration(seconds: 1);
    emit(state.copyWith(duration: duration));
    if (duration.inSeconds == 0) {
      belPlayer.play(AssetSource(Sounds.bel));
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
    }
  }

  void onStartPressed() async {
    buttonPlayer.play(AssetSource(Sounds.button));

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
        taiga: todo.taiga,
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

  void writeCacheTodo() async {
    await todoStorage.write(state.todos);
  }

  void onAcceptDrag(Todo todo) {
    emit(state.copyWith(startDateTimeTask: DateTime.now()));
    emit(state.setFocusTodo(todo));
  }

  void onDoneFocusTodo(Todo todo) async {
    if (todo.project != null) {
      emit(state.copyWith(loadingAddTimeClockify: true));
      await ServiceClockify.addTimeEntry(
        apiKey: apiKeyClockify ?? '',
        workspaceId: selectedWorkspace?.id ?? '',
        projectId: todo.project?.id ?? '',
        startTime: state.startDateTimeTask,
        endTime: DateTime.now(),
        description: todo.task,
      );
    }
    onCheckChanged(true, todo);
    emit(state.setFocusTodo(null));
    emit(state.copyWith(loadingAddTimeClockify: false));
  }

  void onClearFocusTodo() {
    emit(state.setFocusTodo(null));
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

  void onProjectSelected(ProjectClockify? selectedProject) async {
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
        taiga: todo.taiga,
      ),
    );
  }

  void onEditProjectTodo(Todo todo, ProjectClockify? value) {
    updateTodo(
      todo,
      Todo(
        checklist: todo.checklist,
        task: todo.task,
        dateTime: todo.dateTime,
        project: value,
        taiga: todo.taiga,
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
        round: round,
        isStart: forceNext ? autoStart : false,
      ));
    }
  }

  void onTaigaPressed(BuildContext context) async {
    if (loginTaiga == null) {
      final response = await showDialog(
        context: context,
        builder: (context) => const AuthTaiga(),
      );
      if (response is LoginTaigaResponse) {
        loginTaiga = response;
      }
    }
    if (loginTaiga != null) {
      final result = await showDialog(
        context: context,
        builder: (context) => const TaigaDashboard(),
      );

      if (result is Map) {
        final ProjectDetailTaigaResponse projectDetail =
            result['project_detail'];
        final List<TasksResponse> tasks = result['task_to_do'];
        final todos = tasks
            .map((e) => Todo(
                  checklist: false,
                  task: '#${e.ref} ${e.subject}',
                  dateTime: DateTime.now(),
                  taiga: Taiga(projectDetail: projectDetail, taskTaiga: e),
                ))
            .toList();
        emit(state.copyWith(
          todos: [...state.todos, ...todos],
        ));
        writeCacheTodo();
      }
    }
  }

  void onStartTimePressed(BuildContext context) async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(
        hour: state.startDateTimeTask.hour,
        minute: state.startDateTimeTask.minute,
      ),
    );
    if (timeOfDay != null) {
      final startTime = DateTime(
          now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
      emit(state.copyWith(startDateTimeTask: startTime));
    }
  }

  void onDeleteAllTodo(BuildContext context, bool checklist) {
    List<Todo> todos = List<Todo>.from(state.todos);
    todos.removeWhere((element) => element.checklist == checklist);
    emit(state.copyWith(todos: todos));
    writeCacheTodo();
    addOrUpdateHistory(todos);
  }

  void onEditTaigaStatusTodo(
    BuildContext context,
    Todo todo,
    TaskStatusesProjectDetailTaiga? value,
  ) async {
    emit(state.copyWith(loadingGlobal: true));
    if (loginTaiga != null) {
      final success = await ServiceTaiga.changeTaskStatus(
        loginTaiga!.authToken ?? '',
        taskId: todo.taiga?.taskTaiga.id ?? 0,
        statusId: value?.id ?? 0,
        version: todo.taiga?.taskTaiga.version ?? 0,
      );

      if (!success) {
        // ignore: use_build_context_synchronously
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
        updateTodo(
          todo,
          todo.copyWith(
            taiga: todo.taiga?.copyWith(
              taskTaiga: todo.taiga?.taskTaiga.copyWith(
                version: (todo.taiga?.taskTaiga.version ?? 0) + 1,
                status: value?.id,
                statusExtraInfo:
                    todo.taiga?.taskTaiga.statusExtraInfo?.copyWith(
                  name: value?.name,
                  color: value?.color,
                  isClosed: value?.isClosed,
                ),
              ),
            ),
          ),
        );
      }
    }
    emit(state.copyWith(loadingGlobal: false));
  }
}
