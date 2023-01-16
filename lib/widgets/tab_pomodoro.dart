import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/main/main_cubit.dart';
import 'item_tab.dart';

class TabPomodoro extends StatelessWidget {
  const TabPomodoro({super.key});

  @override
  Widget build(BuildContext context) {
    final indexTabPomodoro =
        context.select((MainCubit bloc) => bloc.state.indexTabPomodoro);

    return Row(
      children: [
        ItemTab(
          text: 'Pomodoro',
          selected: indexTabPomodoro == 0,
          fontSize: 24,
          onPressed: () =>
              context.read<MainCubit>().setIndexPomodoro(context, 0),
        ),
        const SizedBox(width: 32),
        ItemTab(
          text: 'Short Break',
          selected: indexTabPomodoro == 1,
          fontSize: 24,
          onPressed: () =>
              context.read<MainCubit>().setIndexPomodoro(context, 1),
        ),
        const SizedBox(width: 32),
        ItemTab(
          text: 'Long Break',
          selected: indexTabPomodoro == 2,
          fontSize: 24,
          onPressed: () =>
              context.read<MainCubit>().setIndexPomodoro(context, 2),
        ),
      ],
    );
  }
}
