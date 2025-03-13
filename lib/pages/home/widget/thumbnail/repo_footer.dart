import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/core/utils/number_formatter.dart';
import 'package:git_explorer/core/widgets/icons/app_icon.dart';
import 'package:git_explorer/core/widgets/icons/app_icons.dart';
import 'package:git_explorer/pages/home/models/repo_search_response.dart';
import 'package:timeago/timeago.dart' as timeago;

class RepoFooter extends StatelessWidget {
  const RepoFooter({required this.repo, super.key});

  final RepoSearchResult repo;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (repo.language != null) _buildLanguageInfo(context),
        if (repo.language != null &&
            (repo.stargazersCount != null || repo.pushedAt != null))
          _buildDot(context),
        if (repo.stargazersCount != null) _buildStarCount(context),
        if (repo.stargazersCount != null && repo.pushedAt != null)
          _buildDot(context),
        if (repo.pushedAt != null) _buildUpdatedInfo(context),
      ],
    );
  }

  Widget _buildLanguageInfo(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: _getLanguageColor(repo.language),
        ),
        const SizedBox(width: 6),
        Text(repo.language ?? 'Unknown', style: context.textTheme.bodySmall),
      ],
    );
  }

  Widget _buildStarCount(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppIcon(icon: AppIcons.star),
        const SizedBox(width: 4),
        Text(
          NumberFormatter.format(repo.stargazersCount ?? 0),
          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildUpdatedInfo(BuildContext context) {
    return Text(
      'Updated ${timeago.format(repo.pushedAt ?? DateTime.now())}',
      style: context.textTheme.bodySmall,
    );
  }

  Widget _buildDot(BuildContext context) {
    return Text(
      '•',
      style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Color _getLanguageColor(String? language) {
    if (language == null) return Colors.grey;

    switch (language.toLowerCase()) {
      case 'javascript':
        return const Color(0xFFF1E05A);
      case 'typescript':
        return const Color(0xFF3178C6);
      case 'python':
        return const Color(0xFF3572A5);
      case 'java':
        return const Color(0xFFB07219);
      case 'kotlin':
        return const Color(0xFFA97BFF);
      case 'swift':
        return const Color(0xFFFFAC45);
      case 'c#':
        return const Color(0xFF178600);
      case 'c++':
        return const Color(0xFFf34b7d);
      case 'ruby':
        return const Color(0xFF701516);
      case 'dart':
        return const Color(0xFF00B4AB);
      case 'go':
        return const Color(0xFF00ADD8);
      case 'rust':
        return const Color(0xFFDEA584);
      default:
        return Colors.indigo;
    }
  }
}
