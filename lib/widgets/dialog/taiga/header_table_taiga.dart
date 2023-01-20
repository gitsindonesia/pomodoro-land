import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/images.dart';
import '../../../cubit/taiga/taiga_cubit.dart';
import '../../../model/taiga/response/project_detail_taiga_response.dart';
import '../../../utils/extension.dart';
import '../../ink_well_pressed.dart';

class HeaderTableTaiga extends StatelessWidget {
  const HeaderTableTaiga({super.key});

  @override
  Widget build(BuildContext context) {
    final projectDetail =
        context.select((TaigaCubit bloc) => bloc.state.projectDetail);

    final filterProgress =
        context.select((TaigaCubit bloc) => bloc.state.filterProgress);
    final filterAssign =
        context.select((TaigaCubit bloc) => bloc.state.filterAssign);
    final allChecklist =
        context.select((TaigaCubit bloc) => bloc.state.allChecklist);

    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const SizedBox(
                width: 300,
                child: Text(
                  'User Story',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const VerticalDivider(width: 32),
              const Expanded(
                child: Text(
                  'Task',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 32),
              SizedBox(
                width: 150,
                child: DropdownButton<TaskStatusesProjectDetailTaiga>(
                  isExpanded: true,
                  value: filterProgress,
                  underline: const SizedBox.shrink(),
                  borderRadius: BorderRadius.circular(8),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text(
                        'All',
                        maxLines: 2,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ...projectDetail?.taskStatuses
                            ?.map(
                              (e) => DropdownMenuItem<
                                  TaskStatusesProjectDetailTaiga>(
                                value: e,
                                child: Text(
                                  e.name ?? '',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: e.color?.toColor(),
                                  ),
                                ),
                              ),
                            )
                            .toList() ??
                        [],
                  ],
                  onChanged: context.read<TaigaCubit>().onFilterProgressChanged,
                ),
              ),
              const SizedBox(width: 32),
              SizedBox(
                width: 150,
                child: DropdownButton<MembersProjectDetailTaiga>(
                  isExpanded: true,
                  value: filterAssign,
                  underline: const SizedBox.shrink(),
                  borderRadius: BorderRadius.circular(8),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text(
                        'Assign to All',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ...projectDetail?.members
                            ?.map(
                              (e) =>
                                  DropdownMenuItem<MembersProjectDetailTaiga>(
                                value: e,
                                child: Text(
                                  e.fullName ?? '',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                            .toList() ??
                        [],
                  ],
                  onChanged: context.read<TaigaCubit>().onFilterAssignChanged,
                ),
              ),
              const SizedBox(width: 16),
              InkWellPressed(
                onPressed: () =>
                    context.read<TaigaCubit>().onChecklistAllTask(),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    allChecklist ? Images.checkActive : Images.checkInactive,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
