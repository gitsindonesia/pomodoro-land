import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/main/main_cubit.dart';
import 'package:pomodoro_land/utils/extension.dart';
import 'package:pomodoro_land/widgets/button.dart';
import 'package:pomodoro_land/widgets/tab_pomodoro.dart';

import '../constants/images.dart';
import '../constants/sounds.dart';
import '../model/todo.dart';

class CountdownSection extends StatelessWidget {
  const CountdownSection({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((MainCubit bloc) => bloc.state.status);
    final focusTodo = context.select((MainCubit bloc) => bloc.state.focusTodo);
    final duration = context.select((MainCubit bloc) => bloc.state.duration);
    final round = context.select((MainCubit bloc) => bloc.state.round);
    final isStart = context.select((MainCubit bloc) => bloc.state.isStart);
    final backgroundMusic =
        context.select((MainCubit bloc) => bloc.state.backgroundMusic);
    final loadingAddTimeClockify =
        context.select((MainCubit bloc) => bloc.state.loadingAddTimeClockify);

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
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () =>
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
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () => context
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
          if (focusTodo != null) ...[
            const SizedBox(height: 32),
            SizedBox(
              width: 600,
              child: Column(
                children: [
                  Text(
                    status,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  if (focusTodo.project != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      focusTodo.project?.name ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: focusTodo.project?.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (!loadingAddTimeClockify) const SizedBox(width: 60),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () => context.read<MainCubit>().onClearFocusTodo(),
                  child: const Text('Clear', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 60),
                loadingAddTimeClockify
                    ? const SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                        ),
                      )
                    : InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () => context
                            .read<MainCubit>()
                            .onDoneFocusTodo(focusTodo),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 32,
                          ),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Images.button),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: const Text('Task Done',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
