import 'package:flutter/material.dart';
import 'package:git_explorer/core/localization/app_localizations_extension.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';

class RepoPullRequestsHeader extends StatelessWidget {
  const RepoPullRequestsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 0, 16),
      child: Text(
        context.l10n.allPullRequests,
        style: context.textTheme.titleMedium,
      ),
    );
  }
}
