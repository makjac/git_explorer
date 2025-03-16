import 'package:flutter/material.dart';
import 'package:git_explorer/core/localization/app_localizations_extension.dart';

class RepoIssuesEmpty extends StatelessWidget {
  const RepoIssuesEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.info_outline, size: 40),
        Text(context.l10n.noIssuesFound),
      ],
    );
  }
}
