import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/setting/setting_cubit.dart';
import 'package:pomodoro_land/widgets/button.dart';
import 'package:pomodoro_land/widgets/ink_well_pressed.dart';

import '../../../constants/images.dart';
import 'clockify_section.dart';
import 'time_section.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final cubit = SettingCubit();

  @override
  void initState() {
    super.initState();
    cubit.initState(context);
    WidgetsBinding.instance.endOfFrame.then((value) {
      if (mounted) {
        cubit.initAfterLayout(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  void onCheckApiKeyClockify(String text) {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Builder(builder: (context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Container(
            width: 800,
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Setting', style: TextStyle(fontSize: 40)),
                    const Spacer(),
                    InkWellPressed(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Image.asset(Images.close, width: 60),
                    ),
                  ],
                ),
                const Divider(height: 32),
                const TimeSection(),
                const Divider(height: 32),
                const ClockifySection(),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Button(
                    text: 'Ok',
                    onPressed: () =>
                        context.read<SettingCubit>().onSavePressed(context),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
