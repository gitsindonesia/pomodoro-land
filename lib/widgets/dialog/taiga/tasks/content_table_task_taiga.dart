import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/images.dart';
import '../../../../cubit/taiga/taiga_cubit.dart';
import '../../../ink_well_pressed.dart';
import 'dropdown_task_status_taiga.dart';

class ContentTableTaskTaiga extends StatelessWidget {
  const ContentTableTaskTaiga({super.key});

  @override
  Widget build(BuildContext context) {
    final userStoryWithTask =
        context.select((TaigaCubit bloc) => bloc.state.userStoryWithTask);
    final taskToTodo =
        context.select((TaigaCubit bloc) => bloc.state.taskToTodo);
    final todos = context.select((TaigaCubit bloc) => bloc.state.todos);
    final projectDetail =
        context.select((TaigaCubit bloc) => bloc.state.projectDetail);

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
      itemBuilder: (context, index) {
        final grouping = userStoryWithTask[index];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWellPressed(
                    onPressed: () => context
                        .read<TaigaCubit>()
                        .onUserStoryPressed(context, grouping.userStory),
                    child: SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              grouping.userStory == null
                                  ? 'Storyless tasks'
                                  : '#${grouping.userStory?.ref}',
                              style: TextStyle(
                                fontSize: 14,
                                color: grouping.userStory == null
                                    ? null
                                    : Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                grouping.userStory?.ref != null
                                    ? grouping.userStory?.subject ?? ''
                                    : '',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: Column(
                      children: grouping.tasks.map((e) {
                        final alreadyInTodo = todos.firstWhereOrNull(
                                (element) =>
                                    element.taiga?.taskTaiga?.id == e.id) !=
                            null;

                        final selected = taskToTodo.firstWhereOrNull(
                                (element) => element.id == e.id) !=
                            null;

                        Color? backgroundColor;

                        if (alreadyInTodo) {
                          backgroundColor = Colors.black12;
                        } else if (selected) {
                          backgroundColor = Colors.blue[50];
                        }

                        return Container(
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWellPressed(
                                  onPressed: () => context
                                      .read<TaigaCubit>()
                                      .onTaskPressed(context, e),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '#${e.ref}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          e.subject ?? '',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 32),
                              SizedBox(
                                width: 150,
                                child: DropdownTaskStatusTaiga(
                                  items: projectDetail?.taskStatuses ?? [],
                                  initialSelectedTaigaStatusId: e.status,
                                  onTaigaStatus: (value) => context
                                      .read<TaigaCubit>()
                                      .onEditTaskTaigaStatus(
                                          context, e, value, alreadyInTodo),
                                ),
                              ),
                              const SizedBox(width: 32),
                              SizedBox(
                                width: 150,
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            e.assignedToExtraInfo?.photo ?? '',
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
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
                                        style: const TextStyle(
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
                                    .onChecklistItemTask(
                                        context, e, alreadyInTodo),
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Image.asset(
                                    selected || alreadyInTodo
                                        ? Images.checkActive
                                        : Images.checkInactive,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
          ],
        );
      },
      itemCount: userStoryWithTask.length,
    );
  }
}
