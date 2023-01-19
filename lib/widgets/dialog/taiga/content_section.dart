import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/taiga/taiga_cubit.dart';
import 'package:pomodoro_land/model/taiga/response/project_detail_taiga_response.dart';
import 'package:pomodoro_land/utils/extension.dart';

import '../../../constants/images.dart';
import '../../button.dart';
import '../../empty_state.dart';
import '../../ink_well_pressed.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loadingTasks =
        context.select((TaigaCubit bloc) => bloc.state.loadingTask);
    final filteredTasks =
        context.select((TaigaCubit bloc) => bloc.state.filteredTasks);
    final projectDetail =
        context.select((TaigaCubit bloc) => bloc.state.projectDetail);
    final taskToTodo =
        context.select((TaigaCubit bloc) => bloc.state.taskToTodo);
    final allChecklist =
        context.select((TaigaCubit bloc) => bloc.state.allChecklist);
    final filterProgress =
        context.select((TaigaCubit bloc) => bloc.state.filterProgress);
    final filterAssign =
        context.select((TaigaCubit bloc) => bloc.state.filterAssign);

    if (loadingTasks) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.black),
        ),
      );
    }

    if (filteredTasks.isEmpty &&
        filterAssign == null &&
        filterProgress == null) {
      return const EmptyState(
        text: 'Task is empty, please select project and milestone first',
      );
    }

    final taskByUserStory = groupBy(
      filteredTasks,
      (task) {
        return task.userStoryExtraInfo;
      },
    );

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
        if (filteredTasks.isEmpty)
          Expanded(
            child: EmptyState(
              text:
                  'Task is empty for ${filterProgress?.name ?? ''}${filterProgress != null ? ' and ' : ''}${filterAssign?.fullName ?? ''}',
            ),
          )
        else
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  ...taskByUserStory.keys.map(
                    (e) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWellPressed(
                                onPressed: () => context
                                    .read<TaigaCubit>()
                                    .onUserStoryPressed(context, e),
                                child: SizedBox(
                                  width: 300,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '#${e?.ref}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            e?.subject ?? '',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const VerticalDivider(width: 32),
                              Expanded(
                                child: Column(
                                  children: (taskByUserStory[e] ?? [])
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: InkWellPressed(
                                                    onPressed: () => context
                                                        .read<TaigaCubit>()
                                                        .onTaskPressed(
                                                            context, e),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '#${e.ref}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.blue,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            e.subject ?? '',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 32),
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    e.statusExtraInfo?.name ??
                                                        '',
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: e.statusExtraInfo
                                                          ?.color
                                                          ?.toColor(),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 32),
                                                SizedBox(
                                                  width: 150,
                                                  child: Row(
                                                    children: [
                                                      ClipOval(
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              e.assignedToExtraInfo
                                                                      ?.photo ??
                                                                  '',
                                                          width: 24,
                                                          height: 24,
                                                          fit: BoxFit.cover,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                            Images.taiga,
                                                            width: 24,
                                                            height: 24,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: Text(
                                                          e.assignedToExtraInfo
                                                                  ?.fullNameDisplay ??
                                                              'Not assigned',
                                                          maxLines: 1,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                InkWellPressed(
                                                  onPressed: () => context
                                                      .read<TaigaCubit>()
                                                      .onChecklistTask(e),
                                                  child: SizedBox(
                                                    width: 24,
                                                    height: 24,
                                                    child: Image.asset(
                                                      taskToTodo.firstWhereOrNull(
                                                                  (element) =>
                                                                      element ==
                                                                      e) !=
                                                              null
                                                          ? Images.checkActive
                                                          : Images
                                                              .checkInactive,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        if (taskToTodo.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.focusLine),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    taskToTodo.map((e) => '#${e.ref}').join(', '),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 32),
                Row(
                  children: [
                    Button.white(
                      onPressed: () =>
                          context.read<TaigaCubit>().onAddToTodo(context),
                      text: 'Add to Todo',
                    ),
                    const SizedBox(width: 16),
                    InkWellPressed(
                      onPressed: () =>
                          context.read<TaigaCubit>().onClearTaskTodo(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
