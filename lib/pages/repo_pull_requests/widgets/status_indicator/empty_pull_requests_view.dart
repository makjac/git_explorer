import 'package:flutter/material.dart';
import 'package:git_explorer/core/localization/app_localizations_extension.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';

class EmptyPullRequestsView extends StatelessWidget {
  const EmptyPullRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info_outline, size: 64),
          const SizedBox(height: 16),
          Text(
            context.l10n.noPullRequestsFound,
            style: context.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
