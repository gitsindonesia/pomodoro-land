import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/model/clockify/project_clockify.dart';
import 'package:pomodoro_land/utils/extension.dart';
import 'package:pomodoro_land/widgets/dropdown_task_taiga_status.dart';
import 'package:pomodoro_land/widgets/ink_well_pressed.dart';

import '../constants/images.dart';
import '../cubit/main/main_cubit.dart';
import '../model/todo.dart';
import 'dropdown_issue_taiga_status.dart';
import 'dropdown_project_clockify.dart';

class ItemTodo extends StatefulWidget {
  const ItemTodo({
    Key? key,
    required this.todo,
    this.selected = false,
  }) : super(key: key);

  final Todo todo;
  final bool selected;

  @override
  State<ItemTodo> createState() => _ItemTodoState();
}

class _ItemTodoState extends State<ItemTodo> {
  bool isEdit = false;
  String task = '';
  ProjectClockify? selectedProject;
  int? selectedTaskTaigaStatusId;
  int? selectedIssueTaigaStatusId;

  @override
  void initState() {
    super.initState();
    task = widget.todo.task;
    selectedProject = widget.todo.project;
    selectedTaskTaigaStatusId = widget.todo.taiga?.taskTaiga?.status;
    selectedIssueTaigaStatusId = widget.todo.taiga?.issueTaiga?.status;
  }

  @override
  void didUpdateWidget(covariant ItemTodo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.todo != widget.todo) {
      setState(() {
        task = widget.todo.task;
        selectedProject = widget.todo.project;
        selectedTaskTaigaStatusId = widget.todo.taiga?.taskTaiga?.status;
        selectedIssueTaigaStatusId = widget.todo.taiga?.issueTaiga?.status;
      });
    }
  }

  Widget? getSubtitleWidget(
    List<ProjectClockify> projects,
  ) {
    final taiga = widget.todo.taiga;

    Widget? taigaWidget;
    if (isEdit && taiga != null && taiga.taskTaiga != null) {
      taigaWidget = DropdownTaskTaigaStatus(
          items: taiga.projectDetail.taskStatuses ?? [],
          selectedTaigaStatusId: selectedTaskTaigaStatusId,
          fontSize: 14,
          onTaigaStatus: (value) {
            setState(() {
              selectedTaskTaigaStatusId = value?.id;
            });
            context
                .read<MainCubit>()
                .onEditTaskTaigaStatusTodo(context, widget.todo, value);
          });
    } else if (isEdit && taiga != null && taiga.issueTaiga != null) {
      taigaWidget = DropdownIssueTaigaStatus(
          items: taiga.projectDetail.issueStatuses ?? [],
          selectedTaigaStatusId: selectedIssueTaigaStatusId,
          fontSize: 14,
          onTaigaStatus: (value) {
            setState(() {
              selectedTaskTaigaStatusId = value?.id;
            });
            context
                .read<MainCubit>()
                .onEditIssueTaigaStatusTodo(context, widget.todo, value);
          });
    } else if (taiga != null && taiga.taskTaiga != null) {
      taigaWidget = Row(
        children: [
          const Text('Task: '),
          const SizedBox(width: 8),
          Image.asset(Images.taiga, width: 24, height: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              taiga.taskTaiga?.statusExtraInfo?.name ?? '',
              style: TextStyle(
                fontSize: 14,
                color: taiga.taskTaiga?.statusExtraInfo?.color?.toColor(),
              ),
            ),
          ),
        ],
      );
    } else if (taiga != null && taiga.issueTaiga != null) {
      taigaWidget = Row(
        children: [
          const Text('Issue: '),
          const SizedBox(width: 8),
          Image.asset(Images.taiga, width: 24, height: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              taiga.issueTaiga?.statusExtraInfo?.name ?? '',
              style: TextStyle(
                fontSize: 14,
                color: taiga.issueTaiga?.statusExtraInfo?.color?.toColor(),
              ),
            ),
          ),
        ],
      );
    }

    Widget? projectWidget;
    if (isEdit && projects.isNotEmpty) {
      projectWidget = DropdownProjectClockify(
          items: projects,
          selectedProject: selectedProject,
          fontSize: 14,
          onProjectSelected: (value) {
            setState(() {
              selectedProject = value;
            });
            context.read<MainCubit>().onEditProjectTodo(widget.todo, value);
          });
    } else if (widget.todo.project != null) {
      projectWidget = Row(
        children: [
          Image.asset(Images.clockify, width: 24, height: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.todo.project!.name,
              style: TextStyle(fontSize: 14, color: widget.todo.project!.color),
            ),
          ),
        ],
      );
    }

    if (taigaWidget != null && projectWidget != null) {
      return Row(
        children: [
          Expanded(child: taigaWidget),
          Expanded(child: projectWidget),
        ],
      );
    } else if (taigaWidget != null) {
      return taigaWidget;
    } else if (projectWidget != null) {
      return projectWidget;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final projects = context.select((MainCubit bloc) => bloc.state.projects);

    return LongPressDraggable<Todo>(
      data: widget.todo,
      feedback: Material(
        child: Text(
          task,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        selectedTileColor: Colors.blue[50],
        selected: widget.selected,
        leading: isEdit
            ? null
            : InkWellPressed(
                onPressed: () => context
                    .read<MainCubit>()
                    .onCheckChanged(!widget.todo.checklist, widget.todo),
                child: Image.asset(
                  widget.todo.checklist
                      ? Images.checkActive
                      : Images.checkInactive,
                  height: widget.todo.checklist ? 32 : 24,
                ),
              ),
        title: isEdit
            ? Column(
                children: [
                  TextFormField(
                    initialValue: task,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 20),
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
            : Text(widget.todo.task, style: const TextStyle(fontSize: 20)),
        subtitle: getSubtitleWidget(projects),
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
              child:
                  Image.asset(isEdit ? Images.close : Images.edit, width: 32),
            ),
            const SizedBox(width: 16),
            InkWellPressed(
              onPressed: () =>
                  context.read<MainCubit>().onDeleteTodo(widget.todo),
              child: Image.asset(Images.delete, width: 32),
            ),
          ],
        ),
        onTap: () => context.read<MainCubit>().onAcceptDrag(widget.todo),
      ),
    );
  }
}
