import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';

class RepoIssuesErrorWidget extends StatelessWidget {
  const RepoIssuesErrorWidget({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 40, color: context.colorScheme.error),
          Text(message),
        ],
      ),
    );
  }
}
