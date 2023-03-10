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
    final loadingProjectDetail =
        context.select((TaigaCubit bloc) => bloc.state.loadingProjectDetail);
    final projectDetail =
        context.select((TaigaCubit bloc) => bloc.state.projectDetail);
    final selectedMilestoneId =
        context.select((TaigaCubit bloc) => bloc.state.selectedMilestoneId);

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
            if (loadingProjectDetail)
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
            if (!loadingProjectDetail && projectDetail != null) ...[
              ...(projectDetail.milestones?.reversed
                          .where((element) => element.closed == false) ??
                      [])
                  .map(
                    (e) => ListTile(
                      leading: const Icon(Icons.circle, size: 8),
                      horizontalTitleGap: 0,
                      selected: selectedMilestoneId == e.id,
                      title: Text(e.name ?? ''),
                      onTap: () => context
                          .read<TaigaCubit>()
                          .onMilestonePressed(context, projectDetail, e),
                    ),
                  )
                  .toList(),
              ListTile(
                leading: const Icon(Icons.circle, size: 8),
                selected: selectedMilestoneId == 0,
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
