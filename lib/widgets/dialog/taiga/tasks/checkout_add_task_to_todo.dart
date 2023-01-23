import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/images.dart';
import '../../../../cubit/taiga/taiga_cubit.dart';
import '../../../button.dart';
import '../../../ink_well_pressed.dart';

class CheckoutAddTaskToTodo extends StatelessWidget {
  const CheckoutAddTaskToTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final taskToTodo =
        context.select((TaigaCubit bloc) => bloc.state.taskToTodo);

    if (taskToTodo.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
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
                onPressed: () => context.read<TaigaCubit>().onClearTodo(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
