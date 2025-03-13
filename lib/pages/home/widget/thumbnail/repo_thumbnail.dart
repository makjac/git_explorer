import 'package:flutter/material.dart';
import 'package:git_explorer/pages/home/models/repo_search_response.dart';
import 'package:git_explorer/pages/home/widget/thumbnail/repo_description.dart';
import 'package:git_explorer/pages/home/widget/thumbnail/repo_footer.dart';
import 'package:git_explorer/pages/home/widget/thumbnail/repo_header.dart';
import 'package:git_explorer/pages/home/widget/thumbnail/repo_topics.dart';

class RepoThumbnail extends StatelessWidget {
  const RepoThumbnail({required this.repo, this.onTap, super.key});

  final RepoSearchResult repo;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RepoHeader(repo: repo),
            const SizedBox(height: 4),
            RepoDescription(description: repo.description),
            const SizedBox(height: 8),
            if (repo.topics != null && repo.topics!.isNotEmpty) ...[
              RepoTopics(topics: repo.topics!),
              const SizedBox(height: 8),
            ],
            RepoFooter(repo: repo),
          ],
        ),
      ),
    );
  }
}
