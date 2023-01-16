import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/main/main_cubit.dart';
import 'package:pomodoro_land/widgets/history_list.dart';
import 'package:pomodoro_land/widgets/tab_todo.dart';
import 'package:pomodoro_land/widgets/todo_list.dart';

class TodoSection extends StatelessWidget {
  const TodoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final indexTab = context.select((MainCubit bloc) => bloc.state.indexTab);

    return Column(
      children: [
        const TabTodo(),
        if (indexTab == 0)
          const Expanded(child: TodoList())
        else
          const Expanded(child: HistoryList()),
      ],
    );
  }
}
