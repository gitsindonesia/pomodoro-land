import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/main/main_cubit.dart';

import '../constants/images.dart';

class TabTodo extends StatelessWidget {
  const TabTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final indexTab = context.select((MainCubit bloc) => bloc.state.indexTab);

    return Row(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => context.read<MainCubit>().setIndex(0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    indexTab == 0 ? Images.button : Images.buttonInactive),
                fit: BoxFit.contain,
              ),
            ),
            child: Text('Todo',
                style: TextStyle(
                    fontSize: 32, color: indexTab == 0 ? null : Colors.grey)),
          ),
        ),
        const SizedBox(width: 32),
        InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => context.read<MainCubit>().setIndex(1),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    indexTab == 1 ? Images.button : Images.buttonInactive),
                fit: BoxFit.contain,
              ),
            ),
            child: Text('History',
                style: TextStyle(
                    fontSize: 32, color: indexTab == 1 ? null : Colors.grey)),
          ),
        ),
      ],
    );
  }
}
