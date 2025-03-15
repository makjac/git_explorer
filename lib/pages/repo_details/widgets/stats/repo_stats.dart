import 'package:flutter/material.dart';
import 'package:git_explorer/core/utils/number_formatter.dart';
import 'package:git_explorer/core/widgets/icons/app_icon.dart';
import 'package:git_explorer/core/widgets/icons/app_icons.dart';
import 'package:git_explorer/pages/repo_details/models/repo_details/repo_details.dart';

class RepoStats extends StatelessWidget {
  const RepoStats({required this.repoDetails, super.key});

  final RepoDetails repoDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        children: [
          _buildStatItem(
            icon: AppIcons.star,
            value: NumberFormatter.format(repoDetails.stargazersCount ?? 0),
          ),
          _buildStatItem(
            icon: AppIcons.frok,
            value: NumberFormatter.format(repoDetails.forks ?? 0),
          ),
          _buildStatItem(
            icon: AppIcons.watch,
            value: NumberFormatter.format(repoDetails.subscribersCount ?? 0),
          ),
          if (repoDetails.license?.key?.isNotEmpty ?? false)
            _buildStatItem(
              icon: AppIcons.license,
              value: repoDetails.license!.key ?? '',
            ),
        ],
      ),
    );
  }

  Widget _buildStatItem({required AppIcons icon, required String value}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 5,
      children: [
        AppIcon(icon: icon),
        Text(value, style: const TextStyle(fontSize: 14, height: 1.2)),
      ],
    );
  }
}
