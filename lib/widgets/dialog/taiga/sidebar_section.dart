import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/taiga/taiga_cubit.dart';

import '../../app_expansion_tile.dart';

class SidebarSection extends StatelessWidget {
  const SidebarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = context.select((TaigaCubit bloc) => bloc.state.projects);
    final selectedProject =
        context.select((TaigaCubit bloc) => bloc.state.selectedProject);
    final loadingContent =
        context.select((TaigaCubit bloc) => bloc.state.loadingContent);
    final projectDetail =
        context.select((TaigaCubit bloc) => bloc.state.projectDetail);

    return ListView.builder(
      itemBuilder: (context, index) {
        final project = projects[index];
        return AppExpansionTile(
          title: Text(project.name ?? ''),
          selected: project == selectedProject,
          onExpansionChanged: (value) {
            if (value) {
              context.read<TaigaCubit>().onProjectPressed(context, project);
            }
          },
          children: [
            if (loadingContent)
              const Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                  ),
                ),
              ),
            if (projectDetail != null) ...[
              ...(projectDetail.milestones
                          ?.where((element) => element.closed == false) ??
                      [])
                  .map(
                    (e) => ListTile(
                      leading: const Icon(Icons.circle, size: 8),
                      horizontalTitleGap: 0,
                      title: Text(e.name ?? ''),
                      onTap: () => context
                          .read<TaigaCubit>()
                          .onMilestonePressed(context, projectDetail),
                    ),
                  )
                  .toList(),
              ListTile(
                leading: const Icon(Icons.circle, size: 8),
                horizontalTitleGap: 0,
                title: const Text('Issue'),
                onTap: () => context
                    .read<TaigaCubit>()
                    .onIssuePressed(context, projectDetail),
              ),
            ],
          ],
        );
      },
      itemCount: projects.length,
    );
  }
}
