import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';

class RepoDescription extends StatelessWidget {
  const RepoDescription({this.description, super.key});

  final String? description;

  @override
  Widget build(BuildContext context) {
    if (description == null || description!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      description!,
      style: context.textTheme.bodyMedium?.copyWith(
        color: context.textTheme.bodyMedium?.color?.withValues(alpha: .8),
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    );
  }
}
