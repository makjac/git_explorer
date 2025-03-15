import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/core/widgets/icons/app_icon.dart';
import 'package:git_explorer/core/widgets/icons/app_icons.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue/repo_issue.dart';
import 'package:timeago/timeago.dart' as timeago;

class RepoIssueThumbnail extends StatelessWidget {
  const RepoIssueThumbnail({required this.issue, super.key});

  final RepoIssue issue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.only(top: 4), child: _issueIcon),
          const SizedBox(width: 10),
          Expanded(child: _issueBody(context)),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: _commentsIcon(context),
          ),
        ],
      ),
    );
  }

  Widget get _issueIcon {
    final color = switch (issue.state) {
      'open' => const Color(0xFF3fb950),
      'closed' => const Color(0xFFa371f7),
      _ => null,
    };
    final icon = switch (issue.state) {
      'open' => AppIcons.issue,
      'closed' => AppIcons.issueClosed,
      _ => AppIcons.issueNotPlanned,
    };
    return AppIcon(icon: icon, color: color);
  }

  Widget _issueBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _issueTitle,
        const SizedBox(height: 4),
        _issueReference(context),
      ],
    );
  }

  Widget get _issueTitle => Text(issue.title ?? '');

  Widget _issueReference(BuildContext context) {
    return Text(
      '#${issue.number} · opened '
      '${timeago.format(issue.updatedAt ?? DateTime.now())}',
      style: context.textTheme.bodySmall,
    );
  }

  Widget _commentsIcon(BuildContext context) {
    if ((issue.comments ?? 0) == 0) return const SizedBox.shrink();
    return Row(
      children: [
        const AppIcon(icon: AppIcons.comment),
        const SizedBox(width: 4),
        Text(issue.comments.toString(), style: context.textTheme.bodyMedium),
      ],
    );
  }
}
