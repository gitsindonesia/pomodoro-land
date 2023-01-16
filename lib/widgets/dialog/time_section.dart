import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/setting/setting_cubit.dart';

import '../../constants/images.dart';

class TimeSection extends StatelessWidget {
  const TimeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerPomodoro =
        context.select((SettingCubit bloc) => bloc.controllerPomodoro);
    final controllerShortBreak =
        context.select((SettingCubit bloc) => bloc.controllerShortBreak);
    final controllerLongBreak =
        context.select((SettingCubit bloc) => bloc.controllerLongBreak);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time (minutes)',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pomodoro', style: TextStyle(fontSize: 20)),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controllerPomodoro,
                          style: const TextStyle(fontSize: 24),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 24),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            child: const Icon(Icons.arrow_drop_up),
                            onTap: () {
                              if (controllerPomodoro.text.isEmpty) return;
                              final count =
                                  int.parse(controllerPomodoro.text) + 1;
                              controllerPomodoro.text = count.toString();
                            },
                          ),
                          GestureDetector(
                            child: const Icon(Icons.arrow_drop_down),
                            onTap: () {
                              if (controllerPomodoro.text.isEmpty) return;
                              final count =
                                  int.parse(controllerPomodoro.text) - 1;
                              controllerPomodoro.text =
                                  count < 0 ? '0' : count.toString();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset(
                    Images.lineShort,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Short Break', style: TextStyle(fontSize: 20)),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controllerShortBreak,
                          style: const TextStyle(fontSize: 24),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 24),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            child: const Icon(Icons.arrow_drop_up),
                            onTap: () {
                              if (controllerShortBreak.text.isEmpty) return;
                              final count =
                                  int.parse(controllerShortBreak.text) + 1;
                              controllerShortBreak.text = count.toString();
                            },
                          ),
                          GestureDetector(
                            child: const Icon(Icons.arrow_drop_down),
                            onTap: () {
                              if (controllerShortBreak.text.isEmpty) return;
                              final count =
                                  int.parse(controllerShortBreak.text) - 1;
                              controllerShortBreak.text =
                                  count < 0 ? '0' : count.toString();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset(
                    Images.lineShort,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Long Break', style: TextStyle(fontSize: 20)),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controllerLongBreak,
                          style: const TextStyle(fontSize: 24),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 24),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            child: const Icon(Icons.arrow_drop_up),
                            onTap: () {
                              if (controllerLongBreak.text.isEmpty) return;
                              final count =
                                  int.parse(controllerLongBreak.text) + 1;
                              controllerLongBreak.text = count.toString();
                            },
                          ),
                          GestureDetector(
                            child: const Icon(Icons.arrow_drop_down),
                            onTap: () {
                              if (controllerLongBreak.text.isEmpty) return;
                              final count =
                                  int.parse(controllerLongBreak.text) - 1;
                              controllerLongBreak.text =
                                  count < 0 ? '0' : count.toString();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset(
                    Images.lineShort,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
