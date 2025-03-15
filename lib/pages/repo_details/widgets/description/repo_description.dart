import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';

class RepoDescription extends StatelessWidget {
  const RepoDescription({required this.description, super.key});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Text(
        description,
        style: context.textTheme.bodyLarge?.copyWith(fontSize: 15),
      ),
    );
  }
}
