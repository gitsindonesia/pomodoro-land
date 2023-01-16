import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/images.dart';
import '../cubit/main/main_cubit.dart';
import '../model/todo.dart';

class ItemTodo extends StatelessWidget {
  const ItemTodo({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Todo>(
      data: todo,
      feedback: Material(
        child: Text(
          todo.task,
          style: const TextStyle(fontSize: 24),
        ),
      ),
      child: ListTile(
        leading: Image.asset(
          todo.checklist ? Images.checkActive : Images.checkInactive,
          height: todo.checklist ? 50 : 36,
        ),
        title: Text(
          todo.task,
          style: const TextStyle(fontSize: 24),
        ),
        subtitle: todo.project == null
            ? null
            : Text(
                todo.project!.name,
                style: TextStyle(fontSize: 14, color: todo.project!.color),
              ),
        trailing: InkWell(
          onTap: () => context.read<MainCubit>().onDeleteTodo(todo),
          child: Image.asset(Images.delete),
        ),
        onTap: () =>
            context.read<MainCubit>().onCheckChanged(!todo.checklist, todo),
      ),
    );
  }
}
