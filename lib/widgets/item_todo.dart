import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/model/clockify/project_clockify.dart';
import 'package:pomodoro_land/widgets/ink_well_pressed.dart';

import '../constants/images.dart';
import '../cubit/main/main_cubit.dart';
import '../model/todo.dart';
import 'dropdown_project_clockify.dart';

class ItemTodo extends StatefulWidget {
  const ItemTodo({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  State<ItemTodo> createState() => _ItemTodoState();
}

class _ItemTodoState extends State<ItemTodo> {
  bool isEdit = false;
  String task = '';
  ProjectClockify? selectedProject;

  @override
  void initState() {
    super.initState();
    task = widget.todo.task;
    selectedProject = widget.todo.project;
  }

  Widget? getProjectWidget(
    List<ProjectClockify> projects,
  ) {
    if (isEdit && projects.isNotEmpty) {
      return DropdownProjectClockify(
          items: projects,
          selectedProject: selectedProject,
          onProjectSelected: (value) {
            setState(() {
              selectedProject = value;
            });
            context.read<MainCubit>().onEditProjectTodo(widget.todo, value);
          });
    } else if (widget.todo.project != null) {
      return Text(
        widget.todo.project!.name,
        style: TextStyle(fontSize: 14, color: widget.todo.project!.color),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final projects = context.select((MainCubit bloc) => bloc.state.projects);

    return LongPressDraggable<Todo>(
      data: widget.todo,
      feedback: Material(
        child: Text(
          task,
          style: const TextStyle(fontSize: 24),
        ),
      ),
      child: ListTile(
        leading: isEdit
            ? null
            : Image.asset(
                widget.todo.checklist
                    ? Images.checkActive
                    : Images.checkInactive,
                height: widget.todo.checklist ? 50 : 36,
              ),
        title: isEdit
            ? Column(
                children: [
                  TextFormField(
                    initialValue: task,
                    style: const TextStyle(fontSize: 24),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 24),
                    ),
                    onChanged: (value) => setState(() {
                      task = value;
                    }),
                    onEditingComplete: () {
                      setState(() {
                        isEdit = false;
                      });
                      context
                          .read<MainCubit>()
                          .onEditTodoComplete(widget.todo, task);
                    },
                  ),
                  Image.asset(
                    Images.lineShort,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              )
            : Text(widget.todo.task, style: const TextStyle(fontSize: 24)),
        subtitle: getProjectWidget(projects),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWellPressed(
              onPressed: () => setState(() {
                if (isEdit) {
                  context
                      .read<MainCubit>()
                      .onEditTodoComplete(widget.todo, task);
                }
                isEdit = !isEdit;
              }),
              child: Image.asset(isEdit ? Images.close : Images.edit),
            ),
            const SizedBox(width: 16),
            InkWellPressed(
              onPressed: () =>
                  context.read<MainCubit>().onDeleteTodo(widget.todo),
              child: Image.asset(Images.delete),
            ),
          ],
        ),
        onTap: () => context
            .read<MainCubit>()
            .onCheckChanged(!widget.todo.checklist, widget.todo),
      ),
    );
  }
}
