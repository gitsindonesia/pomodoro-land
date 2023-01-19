import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/taiga/taiga_cubit.dart';
import 'package:pomodoro_land/utils/extension.dart';

import '../../../constants/images.dart';
import '../../empty_state.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loadingTasks =
        context.select((TaigaCubit bloc) => bloc.state.loadingTask);
    final tasks = context.select((TaigaCubit bloc) => bloc.state.tasks);

    if (loadingTasks) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.black),
        ),
      );
    }

    if (tasks.isEmpty) {
      return const EmptyState(
        text: 'Task is empty, please select project and milestone first',
      );
    }

    final taskByUserStory = groupBy(
      tasks,
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
            children: const [
              SizedBox(
                width: 300,
                child: Text(
                  'User Story',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              VerticalDivider(width: 32),
              Expanded(
                child: Text(
                  'Task',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(width: 32),
              SizedBox(
                width: 100,
                child: Text(
                  'Progress',
                  maxLines: 1,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(width: 32),
              SizedBox(
                width: 150,
                child: Text(
                  'Assign',
                  maxLines: 1,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
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
                            SizedBox(
                              width: 300,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                horizontalTitleGap: 8,
                                leading: Text(
                                  '#${e?.id}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                                title: Text(
                                  e?.subject ?? '',
                                  style: const TextStyle(fontSize: 14),
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
                                              Text(
                                                '#${e.id}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  e.subject ?? '',
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              ),
                                              const SizedBox(width: 32),
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                  e.statusExtraInfo?.name ?? '',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: e
                                                        .statusExtraInfo?.color
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
                                                      child: CachedNetworkImage(
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
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
      ],
    );
  }
}
