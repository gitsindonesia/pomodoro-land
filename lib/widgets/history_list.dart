import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/main/main_cubit.dart';
import 'package:pomodoro_land/utils/extension.dart';

import '../constants/images.dart';
import 'empty_state.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final histories = context.select((MainCubit bloc) => bloc.state.history);

    if (histories.isEmpty) {
      return const EmptyState(text: 'None of your work has been completed yet');
    }

    return ListView.separated(
      padding: const EdgeInsets.only(right: 16, bottom: 32),
      itemBuilder: (context, index) {
        final history = histories[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${history.date.toFormatDate()} - ${history.todos.length} Done',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ...history.todos.map(
              (e) => ListTile(
                leading: Image.asset(
                  e.checklist ? Images.checkActive : Images.checkInactive,
                  height: e.checklist ? 32 : 24,
                ),
                title: Text(
                  e.task,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: e.project == null
                    ? null
                    : Text(
                        e.project!.name,
                        style: TextStyle(fontSize: 14, color: e.project!.color),
                      ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: histories.length,
    );
  }
}
