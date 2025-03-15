import 'package:flutter/material.dart';
import 'package:git_explorer/pages/repo_issues/cubit/repo_issues_cubit.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue/repo_issue.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue_type/repo_issue_type.dart';
import 'package:git_explorer/pages/repo_issues/widgets/status_indicator/repo_issues_empty.dart';
import 'package:git_explorer/pages/repo_issues/widgets/status_indicator/repo_issues_error_widget.dart';
import 'package:git_explorer/pages/repo_issues/widgets/status_indicator/repo_issues_loading.dart';
import 'package:git_explorer/pages/repo_issues/widgets/thumbnail/repo_issue_thumbnail.dart';

class RepoIssuesContent extends StatelessWidget {
  const RepoIssuesContent({
    required this.state,
    required this.currentIssueType,
    required this.initialLoading,
    super.key,
  });

  final RepoIssuesState state;
  final IssueStateType currentIssueType;
  final bool initialLoading;

  List<RepoIssue> _getIssues(RepoIssuesWithData data) {
    return switch (currentIssueType) {
      IssueStateType.open => data.openIssues,
      IssueStateType.closed => data.closedIssues,
      IssueStateType.all => data.allIssues,
    };
  }

  @override
  Widget build(BuildContext context) {
    if ((state is LoadingOpenIssues &&
            currentIssueType == IssueStateType.open) ||
        (state is LoadingClosedIssues &&
            currentIssueType == IssueStateType.closed) ||
        (state is LoadingAllIssues && currentIssueType == IssueStateType.all)) {
      if (initialLoading) {
        return const RepoIssuesLoading();
      }
    }

    if (state is RepoIssuesError) {
      return RepoIssuesErrorWidget(message: (state as RepoIssuesError).message);
    }

    if (state is RepoIssuesWithData) {
      final data = state as RepoIssuesWithData;
      final issues = _getIssues(data);
      if (issues.isEmpty) {
        return const RepoIssuesEmpty();
      }
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: RepoIssuesList(issues: issues),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class RepoIssuesList extends StatelessWidget {
  const RepoIssuesList({required this.issues, super.key});

  final List<RepoIssue> issues;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < issues.length; i++) ...[
          RepoIssueThumbnail(issue: issues[i]),
          if (i < issues.length - 1) const Divider(),
        ],
      ],
    );
  }
}
