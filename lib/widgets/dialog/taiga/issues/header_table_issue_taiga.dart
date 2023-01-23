import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/images.dart';
import '../../../../cubit/taiga/taiga_cubit.dart';
import '../../../ink_well_pressed.dart';

class HeaderTableIssueTaiga extends StatelessWidget {
  const HeaderTableIssueTaiga({super.key});

  @override
  Widget build(BuildContext context) {
    final allChecklist =
        context.select((TaigaCubit bloc) => bloc.state.allIssueChecklist);

    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Issue',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 32),
              const SizedBox(
                width: 150,
                child: Text(
                  'Status',
                  maxLines: 2,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 32),
              const SizedBox(
                width: 150,
                child: Text(
                  'Assign to',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 16),
              InkWellPressed(
                onPressed: () =>
                    context.read<TaigaCubit>().onChecklistAllIssue(),
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
