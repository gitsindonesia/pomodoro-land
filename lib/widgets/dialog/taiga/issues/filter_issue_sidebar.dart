import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/constants/images.dart';
import 'package:pomodoro_land/utils/extension.dart';
import 'package:pomodoro_land/widgets/button.dart';
import 'package:pomodoro_land/widgets/ink_well_pressed.dart';

import '../../../../cubit/taiga/taiga_cubit.dart';

class FilterIssueSidebar extends StatelessWidget {
  const FilterIssueSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final loadingFilterIssue =
        context.select((TaigaCubit bloc) => bloc.state.loadingFilterIssue);
    final filterIssue =
        context.select((TaigaCubit bloc) => bloc.state.filterIssue);
    final selectedFilterIssue =
        context.select((TaigaCubit bloc) => bloc.state.selectedFilterIssue);

    if (loadingFilterIssue) {
      return const SizedBox(
        width: 200,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.black),
          ),
        ),
      );
    }

    return SizedBox(
      width: 200,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text('Filter', style: TextStyle(fontSize: 24)),
                  ),
                  InkWellPressed(
                    onPressed: () => context
                        .read<TaigaCubit>()
                        .onClearFilterIssuePressed(context),
                    child: Image.asset(
                      Images.delete,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpansionTile(
                    title: const Text('Type'),
                    controlAffinity: ListTileControlAffinity.leading,
                    trailing: Text('${selectedFilterIssue.types?.length ?? 0}'),
                    children: [
                      ...(filterIssue?.types?.map((e) {
                            final selected = selectedFilterIssue.types
                                    ?.firstWhereOrNull(
                                        (element) => element == e) !=
                                null;
                            return ListTile(
                              dense: true,
                              selected: selected,
                              selectedTileColor: Colors.blue[50],
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      e.name ?? '',
                                      style:
                                          TextStyle(color: e.color?.toColor()),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[200],
                                    ),
                                    child: Center(
                                      child: Text(
                                        e.count?.toString() ?? '',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => context
                                  .read<TaigaCubit>()
                                  .onFilterIssueTypeSelected(e),
                            );
                          }) ??
                          []),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('Severity'),
                    controlAffinity: ListTileControlAffinity.leading,
                    trailing:
                        Text('${selectedFilterIssue.severities?.length ?? 0}'),
                    children: [
                      ...(filterIssue?.severities?.map((e) {
                            final selected = selectedFilterIssue.severities
                                    ?.firstWhereOrNull(
                                        (element) => element == e) !=
                                null;
                            return ListTile(
                              dense: true,
                              selected: selected,
                              selectedTileColor: Colors.blue[50],
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      e.name ?? '',
                                      style:
                                          TextStyle(color: e.color?.toColor()),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[200],
                                    ),
                                    child: Center(
                                      child: Text(
                                        e.count?.toString() ?? '',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => context
                                  .read<TaigaCubit>()
                                  .onFilterIssueSeveritySelected(e),
                            );
                          }) ??
                          []),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('Priority'),
                    controlAffinity: ListTileControlAffinity.leading,
                    trailing:
                        Text('${selectedFilterIssue.priorities?.length ?? 0}'),
                    children: [
                      ...(filterIssue?.priorities?.map((e) {
                            final selected = selectedFilterIssue.priorities
                                    ?.firstWhereOrNull(
                                        (element) => element == e) !=
                                null;
                            return ListTile(
                              dense: true,
                              selected: selected,
                              selectedTileColor: Colors.blue[50],
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      e.name ?? '',
                                      style:
                                          TextStyle(color: e.color?.toColor()),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[200],
                                    ),
                                    child: Center(
                                      child: Text(
                                        e.count?.toString() ?? '',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => context
                                  .read<TaigaCubit>()
                                  .onFilterIssuePrioritySelected(e),
                            );
                          }) ??
                          []),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('Status'),
                    controlAffinity: ListTileControlAffinity.leading,
                    trailing:
                        Text('${selectedFilterIssue.statuses?.length ?? 0}'),
                    children: [
                      ...(filterIssue?.statuses?.map((e) {
                            final selected = selectedFilterIssue.statuses
                                    ?.firstWhereOrNull(
                                        (element) => element == e) !=
                                null;
                            return ListTile(
                              dense: true,
                              selected: selected,
                              selectedTileColor: Colors.blue[50],
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      e.name ?? '',
                                      style:
                                          TextStyle(color: e.color?.toColor()),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[200],
                                    ),
                                    child: Center(
                                      child: Text(
                                        e.count?.toString() ?? '',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => context
                                  .read<TaigaCubit>()
                                  .onFilterIssueStatusSelected(e),
                            );
                          }) ??
                          []),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('Tag'),
                    controlAffinity: ListTileControlAffinity.leading,
                    trailing: Text('${selectedFilterIssue.tags?.length ?? 0}'),
                    children: [
                      ...(filterIssue?.tags?.map((e) {
                            final selected = selectedFilterIssue.tags
                                    ?.firstWhereOrNull(
                                        (element) => element == e) !=
                                null;
                            return ListTile(
                              dense: true,
                              selected: selected,
                              selectedTileColor: Colors.blue[50],
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      e.name ?? '',
                                      style:
                                          TextStyle(color: e.color?.toColor()),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[200],
                                    ),
                                    child: Center(
                                      child: Text(
                                        e.count?.toString() ?? '',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => context
                                  .read<TaigaCubit>()
                                  .onFilterIssueTagSelected(e),
                            );
                          }) ??
                          []),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('Assign To'),
                    controlAffinity: ListTileControlAffinity.leading,
                    trailing:
                        Text('${selectedFilterIssue.assignedTo?.length ?? 0}'),
                    children: [
                      ...(filterIssue?.assignedTo?.map((e) {
                            final selected = selectedFilterIssue.assignedTo
                                    ?.firstWhereOrNull(
                                        (element) => element == e) !=
                                null;
                            return ListTile(
                              dense: true,
                              selected: selected,
                              selectedTileColor: Colors.blue[50],
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(e.fullName?.isNotEmpty ?? false
                                        ? e.fullName!
                                        : 'Unassigned'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[200],
                                    ),
                                    child: Center(
                                      child: Text(
                                        e.count?.toString() ?? '',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => context
                                  .read<TaigaCubit>()
                                  .onFilterIssueAssignToSelected(e),
                            );
                          }) ??
                          []),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('Role'),
                    controlAffinity: ListTileControlAffinity.leading,
                    trailing: Text('${selectedFilterIssue.roles?.length ?? 0}'),
                    children: [
                      ...(filterIssue?.roles?.map((e) {
                            final selected = selectedFilterIssue.roles
                                    ?.firstWhereOrNull(
                                        (element) => element == e) !=
                                null;
                            return ListTile(
                              dense: true,
                              selected: selected,
                              selectedTileColor: Colors.blue[50],
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      e.name ?? '',
                                      style:
                                          TextStyle(color: e.color?.toColor()),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[200],
                                    ),
                                    child: Center(
                                      child: Text(
                                        e.count?.toString() ?? '',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => context
                                  .read<TaigaCubit>()
                                  .onFilterIssueRoleSelected(e),
                            );
                          }) ??
                          []),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('Created By'),
                    controlAffinity: ListTileControlAffinity.leading,
                    trailing:
                        Text('${selectedFilterIssue.owners?.length ?? 0}'),
                    children: [
                      ...(filterIssue?.owners?.map((e) {
                            final selected = selectedFilterIssue.owners
                                    ?.firstWhereOrNull(
                                        (element) => element == e) !=
                                null;
                            return ListTile(
                              dense: true,
                              selected: selected,
                              selectedTileColor: Colors.blue[50],
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(e.fullName ?? ''),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[200],
                                    ),
                                    child: Center(
                                      child: Text(
                                        e.count?.toString() ?? '',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => context
                                  .read<TaigaCubit>()
                                  .onFilterIssueOwnerSelected(e),
                            );
                          }) ??
                          []),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Button(
            text: 'Apply',
            onPressed: () =>
                context.read<TaigaCubit>().onApplyFilterIssuePressed(context),
          ),
        ],
      ),
    );
  }
}
