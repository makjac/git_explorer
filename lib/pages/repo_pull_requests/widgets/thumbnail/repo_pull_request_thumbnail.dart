import 'package:flutter/material.dart';
import 'package:git_explorer/core/localization/app_localizations_extension.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/core/widgets/icons/app_icon.dart';
import 'package:git_explorer/core/widgets/icons/app_icons.dart';
import 'package:git_explorer/pages/repo_pull_requests/models/repo_pull_request.dart';
import 'package:timeago/timeago.dart' as timeago;

class RepoPullRequestThumbnail extends StatelessWidget {
  const RepoPullRequestThumbnail({required this.pullRequest, super.key});

  final RepoPullRequest pullRequest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: RepoPullRequestIcon(pullRequest: pullRequest),
          ),
          const SizedBox(width: 10),
          Expanded(child: RepoPullRequestBody(pullRequest: pullRequest)),
        ],
      ),
    );
  }
}

class RepoPullRequestIcon extends StatelessWidget {
  const RepoPullRequestIcon({required this.pullRequest, super.key});

  final RepoPullRequest pullRequest;

  @override
  Widget build(BuildContext context) {
    final rpState = (
      pullRequest.state,
      pullRequest.mergedAt != null,
      pullRequest.draft ?? false,
    );

    return switch (rpState) {
      ('open', _, false) => const AppIcon(icon: AppIcons.pullRequestDraft),
      ('open', _, true) => const AppIcon(
        icon: AppIcons.pullRequest,
        color: Color(0xFF3fb950),
      ),
      ('closed', true, _) => const AppIcon(
        icon: AppIcons.marged,
        color: Color(0xFFab7df8),
      ),
      ('closed', false, _) => const AppIcon(
        icon: AppIcons.pullRequestClosed,
        color: Color(0xFFf85149),
      ),
      _ => const AppIcon(icon: AppIcons.pullRequest),
    };
  }
}

class RepoPullRequestBody extends StatelessWidget {
  const RepoPullRequestBody({required this.pullRequest, super.key});

  final RepoPullRequest pullRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pullRequest.title ?? context.l10n.noTitle,
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(
          context.l10n.pullRequestInfo(
            pullRequest.number.toString(),
            timeago.format(pullRequest.createdAt ?? DateTime.now()),
          ),

          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }
}
