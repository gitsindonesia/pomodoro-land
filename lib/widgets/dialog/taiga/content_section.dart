import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/taiga/taiga_cubit.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/checkout_add_to_todo.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/content_table_taiga.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/empty_state_table_taiga.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/header_table_taiga.dart';

import '../../empty_state.dart';

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
    final filterProgress =
        context.select((TaigaCubit bloc) => bloc.state.filterProgress);
    final filterAssign =
        context.select((TaigaCubit bloc) => bloc.state.filterAssign);
    final selectedMilestoneId =
        context.select((TaigaCubit bloc) => bloc.state.selectedMilestoneId);

    if ((loadingTask || loadingMilestone) && userStoryWithTask.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.black),
        ),
      );
    }

    if (userStoryWithTask.isEmpty &&
        filterAssign == null &&
        filterProgress == null) {
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
        const HeaderTableTaiga(),
        if (userStoryWithTask
            .where((element) => element.tasks.isNotEmpty)
            .isEmpty)
          const Expanded(child: EmptyStateTableTaiga())
        else
          const Expanded(child: ContentTableTaiga()),
        const CheckoutAddToTodo(),
      ],
    );
  }
}
