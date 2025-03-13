import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/pages/home/models/repo_search_response.dart';

class RepoHeader extends StatelessWidget {
  const RepoHeader({required this.repo, super.key});

  final RepoSearchResult repo;

  @override
  Widget build(BuildContext context) {
    final isUser = repo.owner?.type == 'User';
    final avatarRadius = isUser ? 12.0 : 4.0;

    return Row(
      children: [
        _buildAvatar(context, avatarRadius, isUser),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            repo.fullName ?? '',
            style: context.textTheme.titleMedium?.copyWith(
              color: context.theme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
          imageUrl: repo.owner?.avatarUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(color: Colors.grey.shade200),
          errorWidget:
              (context, url, error) => Icon(
                Icons.person,
                size: 16,
                color: context.theme.disabledColor,
              ),
        ),
      ),
    );
  }
}
