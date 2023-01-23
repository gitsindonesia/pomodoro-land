import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/setting/setting_cubit.dart';
import 'package:pomodoro_land/model/clockify/workspace_clockify.dart';
import 'package:pomodoro_land/widgets/ink_well_pressed.dart';

import '../../../constants/images.dart';

class ClockifySection extends StatelessWidget {
  const ClockifySection({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerApiKeyClockify =
        context.select((SettingCubit bloc) => bloc.controllerApiKeyClockify);
    final loadingCheckClockify =
        context.select((SettingCubit bloc) => bloc.state.loadingCheckClockify);
    final user = context.select((SettingCubit bloc) => bloc.state.user);
    final selectedWorkspace =
        context.select((SettingCubit bloc) => bloc.state.selectedWorkspace);
    final workspaces =
        context.select((SettingCubit bloc) => bloc.state.workspaces);
    final loadingProjects =
        context.select((SettingCubit bloc) => bloc.state.loadingProjects);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Integrate with Clockyfy',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controllerApiKeyClockify,
          style: const TextStyle(fontSize: 24),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter your api key clockfy',
            hintStyle: const TextStyle(fontSize: 24),
            contentPadding: const EdgeInsets.fromLTRB(0, 12, 24, 12),
            suffixIcon: loadingCheckClockify
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black),
                      ),
                    ),
                  )
                : InkWellPressed(
                    onPressed: () => context
                        .read<SettingCubit>()
                        .onCheckApiKeyClockify(
                            context, controllerApiKeyClockify.text),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.check, color: Colors.black),
                        SizedBox(width: 8),
                        Text('Check', style: TextStyle(fontSize: 24)),
                      ],
                    ),
                  ),
          ),
        ),
        Image.asset(
          Images.lineShort,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        if (user != null) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Name:', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 16),
              Text(user.name, style: const TextStyle(fontSize: 20)),
            ],
          ),
        ],
        if (workspaces.isNotEmpty) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Workspace:', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 16),
              Flexible(
                child: DropdownButton<WorkspaceClockify>(
                  borderRadius: BorderRadius.circular(8),
                  icon: Image.asset(Images.dropdown),
                  hint: const Text('Select Workspace',
                      style: TextStyle(fontSize: 24)),
                  underline:
                      Image.asset(Images.lineShort, fit: BoxFit.fitWidth),
                  value: selectedWorkspace,
                  items: workspaces
                      .map((e) => DropdownMenuItem<WorkspaceClockify>(
                            value: e,
                            child: Text(e.name,
                                style: const TextStyle(fontSize: 24)),
                          ))
                      .toList(),
                  onChanged: (workspace) => context
                      .read<SettingCubit>()
                      .onChangeWorkspace(context, workspace),
                ),
              ),
              if (loadingProjects) ...[
                const SizedBox(width: 16),
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                  ),
                )
              ],
            ],
          ),
        ],
      ],
    );
  }
}
