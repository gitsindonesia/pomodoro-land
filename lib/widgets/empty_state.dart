import 'package:flutter/material.dart';

import '../constants/images.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Images.emptyState, height: 300),
          const SizedBox(height: 16),
          Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
