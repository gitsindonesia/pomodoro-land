import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/issues/number_pagination.dart';

import '../../../../constants/images.dart';
import '../../../../cubit/taiga/taiga_cubit.dart';
import '../../../ink_well_pressed.dart';
import 'dropdown_issue_status_taiga.dart';

class ContentTableIssueTaiga extends StatelessWidget {
  const ContentTableIssueTaiga({super.key});

  @override
  Widget build(BuildContext context) {
    final loadingIssue =
        context.select((TaigaCubit bloc) => bloc.state.loadingIssue);
    final paginationIssues =
        context.select((TaigaCubit bloc) => bloc.state.paginationIssues);
    final issues = context.select((TaigaCubit bloc) => bloc.state.issues);
    final todos = context.select((TaigaCubit bloc) => bloc.state.todos);
    final projectDetail =
        context.select((TaigaCubit bloc) => bloc.state.projectDetail);
    final selectedPageIssue =
        context.select((TaigaCubit bloc) => bloc.state.selectedPageIssue);
    final issueToTodo =
        context.select((TaigaCubit bloc) => bloc.state.issueToTodo);

    if (loadingIssue) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.black),
        ),
      );
    }

    final totalPages =
        (paginationIssues.xPaginationCount / paginationIssues.xPaginatedBy)
            .ceil();

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final issue = issues[index];

              final alreadyInTodo = todos.firstWhereOrNull(
                      (element) => element.taiga?.issueTaiga?.id == issue.id) !=
                  null;

              final selected = issueToTodo
                      .firstWhereOrNull((element) => element.id == issue.id) !=
                  null;

              Color? backgroundColor;
              if (alreadyInTodo) {
                backgroundColor = Colors.black12;
              } else if (selected) {
                backgroundColor = Colors.blue[50];
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
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
                                        .onItemIssuePressed(context, issue),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '#${issue.ref}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            issue.subject ?? '',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 32),
                                SizedBox(
                                  width: 150,
                                  child: DropdownIssueStatusTaiga(
                                    items: projectDetail?.issueStatuses ?? [],
                                    initialSelectedTaigaStatusId: issue.status,
                                    onTaigaStatus: (value) => context
                                        .read<TaigaCubit>()
                                        .onEditIssueTaigaStatus(context, issue,
                                            value, alreadyInTodo),
                                  ),
                                ),
                                const SizedBox(width: 32),
                                SizedBox(
                                  width: 150,
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: issue
                                                  .assignedToExtraInfo?.photo ??
                                              '',
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
                                          issue.assignedToExtraInfo
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
                                      .onChecklistItemIssue(
                                          context, issue, alreadyInTodo),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                ],
              );
            },
            childCount: issues.length,
          ),
        ),
        if (totalPages > 1) ...[
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: NumberPagination(
                onPageChanged: (value) => context
                    .read<TaigaCubit>()
                    .onNumberPaginationPressed(context, value),
                currentPage: selectedPageIssue,
                totalPage: totalPages,
              ),
            ),
          ),
        ],
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}
