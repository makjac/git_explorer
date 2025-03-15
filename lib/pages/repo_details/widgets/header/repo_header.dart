import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/pages/repo_details/models/repo_details/repo_details.dart';

class RepoHeader extends StatelessWidget {
  const RepoHeader({required this.repoDetails, super.key});

  final RepoDetails repoDetails;

  @override
  Widget build(BuildContext context) {
    final isUser = repoDetails.owner?.type == OwnerType.user;
    final avatarRadius = isUser ? 12.0 : 4.0;

    return Row(
      spacing: 8,
      children: [
        _buildAvatar(context, avatarRadius, isUser),
        Text(
          repoDetails.name ?? '',
          style: context.textTheme.titleLarge?.copyWith(
            fontSize: 20,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context, double radius, bool isUser) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: isUser ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isUser ? null : BorderRadius.circular(radius),
        border: Border.all(color: context.colorScheme.surface),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: repoDetails.owner?.avatarUrl ?? '',
          fit: BoxFit.cover,
          placeholder:
              (context, url) => Container(color: context.colorScheme.surface),
          errorWidget:
              (context, url, error) => const Icon(Icons.person, size: 16),
        ),
      ),
    );
  }
}
