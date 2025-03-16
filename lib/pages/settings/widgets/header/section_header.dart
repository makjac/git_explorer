import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            title,
            style: context.textTheme.titleLarge?.copyWith(letterSpacing: .5),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
