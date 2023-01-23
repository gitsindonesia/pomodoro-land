import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/taiga/taiga_cubit.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/issues/content_table_issue_taiga.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/tasks/content_table_task_taiga.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/tasks/empty_state_table_task_taiga.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/tasks/header_table_task_taiga.dart';

import '../../empty_state.dart';
import 'issues/checkout_add_issue_to_todo.dart';
import 'issues/empty_state_table_issue_taiga.dart';
import 'issues/filter_issue_sidebar.dart';
import 'issues/header_table_issue_taiga.dart';
import 'tasks/checkout_add_task_to_todo.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loadingMilestone =
        context.select((TaigaCubit bloc) => bloc.state.loadingMilestone);
    final loadingTask =
        context.select((TaigaCubit bloc) => bloc.state.loadingTask);
    final loadingContent =
        context.select((TaigaCubit bloc) => bloc.state.loadingContent);
    final userStoryWithTask =
        context.select((TaigaCubit bloc) => bloc.state.userStoryWithTask);
    final issues = context.select((TaigaCubit bloc) => bloc.state.issues);
    final filterProgress =
        context.select((TaigaCubit bloc) => bloc.state.filterProgress);
    final filterAssign =
        context.select((TaigaCubit bloc) => bloc.state.filterAssign);
    final selectedMilestoneId =
        context.select((TaigaCubit bloc) => bloc.state.selectedMilestoneId);

    if (loadingTask || loadingMilestone) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.black),
        ),
      );
    }

    if (userStoryWithTask.isEmpty &&
        filterAssign == null &&
        filterProgress == null &&
        selectedMilestoneId < 0) {
      return const EmptyState(text: 'Please select your project and milestone');
    }

    if (selectedMilestoneId < 0) {
      return const EmptyState(text: 'Select your milestone');
    }

    return Column(
      children: [
        if (loadingContent)
          const LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.black),
          ),
        if (selectedMilestoneId > 0)
          Expanded(
            child: Column(
              children: [
                const HeaderTableTaskTaiga(),
                if (userStoryWithTask
                    .where((element) => element.tasks.isNotEmpty)
                    .isEmpty)
                  const Expanded(child: EmptyStateTableTaskTaiga())
                else
                  const Expanded(child: ContentTableTaskTaiga())
              ],
            ),
          )
        else if (selectedMilestoneId == 0)
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FilterIssueSidebar(),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Column(
                    children: [
                      const HeaderTableIssueTaiga(),
                      if (issues.isEmpty)
                        const Expanded(child: EmptyStateTableIssueTaiga())
                      else
                        const Expanded(child: ContentTableIssueTaiga())
                    ],
                  ),
                ),
              ],
            ),
          ),
        const CheckoutAddTaskToTodo(),
        const CheckoutAddIssueToTodo(),
      ],
    );
  }
}
