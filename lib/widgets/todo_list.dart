import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/main/main_cubit.dart';
import 'package:pomodoro_land/widgets/item_todo.dart';

import '../constants/images.dart';
import '../model/project.dart';
import 'empty_state.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (projects.isNotEmpty) ...[
          Row(
            children: [
              Image.asset(Images.project, width: 34),
              const SizedBox(width: 24),
              Expanded(
                child: DropdownButton<Project>(
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(8),
                  icon: Image.asset(Images.dropdown),
                  underline: const SizedBox.shrink(),
                  value: selectedProject,
                  items: [
                    const DropdownMenuItem<Project>(
                      value: null,
                      child: Text(
                        'Not a Project',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    ...projects.map(
                      (e) => DropdownMenuItem<Project>(
                        value: e,
                        child: Text(
                          e.name,
                          style: TextStyle(fontSize: 20, color: e.color),
                        ),
                      ),
                    ),
                  ],
                  onChanged: context.read<MainCubit>().onProjectSelected,
                ),
              ),
              const SizedBox(width: 24),
            ],
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
                    taskOnGoing.map((e) => ItemTodo(todo: e)).toList(),
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
                    taskDone.map((e) => ItemTodo(todo: e)).toList(),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
