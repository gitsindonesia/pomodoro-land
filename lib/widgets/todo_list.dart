import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/main/main_cubit.dart';
import 'package:pomodoro_land/utils/extension.dart';
import 'package:pomodoro_land/widgets/dropdown_project_clockify.dart';
import 'package:pomodoro_land/widgets/item_todo.dart';

import '../constants/images.dart';
import 'button.dart';
import 'empty_state.dart';
import 'ink_well_pressed.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.select((MainCubit bloc) => bloc.controller);
    final todos = context.select((MainCubit bloc) => bloc.state.todos);
    final selectedProject =
        context.select((MainCubit bloc) => bloc.state.selectedProject);
    final projects = context.select((MainCubit bloc) => bloc.state.projects);

    final taskOnGoing = todos.where((element) => !element.checklist);
    final taskDone = todos.where((element) => element.checklist);

    final focusTodo = context.select((MainCubit bloc) => bloc.state.focusTodo);
    final loadingAddTimeClockify =
        context.select((MainCubit bloc) => bloc.state.loadingAddTimeClockify);
    final startDateTimeTask =
        context.select((MainCubit bloc) => bloc.state.startDateTimeTask);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (projects.isNotEmpty) ...[
          DropdownProjectClockify(
            items: projects,
            selectedProject: selectedProject,
            onProjectSelected: context.read<MainCubit>().onProjectSelected,
          ),
          const SizedBox(height: 8),
        ],
        Row(
          children: [
            Image.asset(Images.plus, width: 42),
            const SizedBox(width: 24),
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(fontSize: 24),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'What are you going to do?',
                  hintStyle: TextStyle(fontSize: 24),
                ),
                onEditingComplete: () {
                  context.read<MainCubit>().onAddTodoComplete(controller.text);
                  controller.clear();
                },
              ),
            ),
          ],
        ),
        Image.asset(
          Images.lineShort,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        const SizedBox(height: 16),
        Text(
          '${todos.where((element) => element.checklist).length} / ${todos.length} done',
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 16),
        if (todos.isEmpty)
          const Expanded(child: EmptyState(text: 'Nothing to do today'))
        else
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    taskOnGoing
                        .map((e) => ItemTodo(
                              todo: e,
                              selected: e.task == focusTodo?.task,
                            ))
                        .toList(),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Task done',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    taskDone
                        .map((e) => ItemTodo(
                              todo: e,
                              selected: e.task == focusTodo?.task,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        if (focusTodo != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.focusLine),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              children: [
                InkWellPressed(
                  onPressed: () =>
                      context.read<MainCubit>().onStartTimePressed(context),
                  child: Column(
                    children: [
                      const Text(
                        'Start Time',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        startDateTimeTask.toFormatTime(),
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        focusTodo.task,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      if (focusTodo.project != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          focusTodo.project?.name ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: focusTodo.project?.color,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Row(
                  children: [
                    loadingAddTimeClockify
                        ? const SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.black),
                            ),
                          )
                        : Button.white(
                            onPressed: () => context
                                .read<MainCubit>()
                                .onDoneFocusTodo(focusTodo),
                            text: 'Done',
                          ),
                    const SizedBox(width: 16),
                    InkWellPressed(
                      onPressed: () =>
                          context.read<MainCubit>().onClearFocusTodo(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
