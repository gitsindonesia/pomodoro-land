import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/main/main_cubit.dart';
import 'package:pomodoro_land/widgets/item_tab.dart';

class TabTodo extends StatelessWidget {
  const TabTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final indexTab = context.select((MainCubit bloc) => bloc.state.indexTab);

    return Row(
      children: [
        ItemTab(
          text: 'Todo',
          fontSize: 32,
          selected: indexTab == 0,
          onPressed: () => context.read<MainCubit>().setIndex(0),
        ),
        const SizedBox(width: 32),
        ItemTab(
          text: 'History',
          fontSize: 32,
          selected: indexTab == 1,
          onPressed: () => context.read<MainCubit>().setIndex(1),
        ),
      ],
    );
  }
}
