import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/main/main_cubit.dart';
import 'package:pomodoro_land/utils/extension.dart';
import 'package:pomodoro_land/widgets/button.dart';
import 'package:pomodoro_land/widgets/ink_well_pressed.dart';
import 'package:pomodoro_land/widgets/tab_pomodoro.dart';

import '../constants/images.dart';
import '../constants/sounds.dart';
import '../model/todo.dart';

class CountdownSection extends StatelessWidget {
  const CountdownSection({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((MainCubit bloc) => bloc.state.duration);
    final round = context.select((MainCubit bloc) => bloc.state.round);
    final isStart = context.select((MainCubit bloc) => bloc.state.isStart);
    final backgroundMusic =
        context.select((MainCubit bloc) => bloc.state.backgroundMusic);

    List<DropdownMenuItem<String>> getBackgroundMusic() {
      List<DropdownMenuItem<String>> items = [];
      Sounds.urlSounds.forEach((key, value) {
        items.add(
          DropdownMenuItem(
            value: value,
            child: Text(key, style: const TextStyle(fontSize: 24)),
          ),
        );
      });
      return items;
    }

    return DragTarget<Todo>(
      onAccept: context.read<MainCubit>().onAcceptDrag,
      builder: (context, candidateData, rejectedData) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TabPomodoro(),
          const SizedBox(height: 16),
          Container(
            width: 600,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.pomodoroTomato),
                fit: BoxFit.contain,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 110),
                  Text(
                    duration.toMMss(),
                    style: const TextStyle(
                      fontSize: 96,
                      letterSpacing: 8,
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWellPressed(
                    onPressed: () =>
                        context.read<MainCubit>().onResetRoundPressed(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Round $round',
                          maxLines: 1,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 8),
                        Image.asset(Images.refresh, width: 24),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Button(
                        text: isStart ? 'Pause' : 'Start',
                        onPressed: context.read<MainCubit>().onStartPressed,
                      ),
                      if (isStart) ...[
                        const SizedBox(width: 8),
                        InkWellPressed(
                          onPressed: () => context
                              .read<MainCubit>()
                              .onNextPomodoroPressed(context),
                          child: Image.asset(Images.next, width: 46),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Background Music:', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 16),
              DropdownButton<String>(
                borderRadius: BorderRadius.circular(8),
                icon: Image.asset(Images.dropdown),
                underline: Image.asset(Images.lineShort, fit: BoxFit.fitWidth),
                value: backgroundMusic,
                items: [
                  const DropdownMenuItem(
                      value: '',
                      child: Text('None', style: TextStyle(fontSize: 24))),
                  ...getBackgroundMusic(),
                ],
                onChanged: context.read<MainCubit>().onBackgroundMusicChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
