import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue_type/repo_issue_type.dart';
import 'package:git_explorer/pages/repo_issues/widgets/dropdown/issue_state_dropdown.dart';

class RepoIssuesHeader extends StatelessWidget {
  const RepoIssuesHeader({
    required this.title,
    required this.currentType,
    required this.onStateChanged,
    super.key,
  });

  final String title;
  final IssueStateType currentType;
  final void Function(IssueStateType) onStateChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: context.textTheme.titleLarge),
          IssueStateDropdown(
            initialStateType: currentType,
            onChanged: onStateChanged,
          ),
        ],
      ),
    );
  }
}
