import 'package:flutter/material.dart';
import 'package:git_explorer/pages/repo_pull_requests/models/repo_pull_request.dart';
import 'package:git_explorer/pages/repo_pull_requests/widgets/thumbnail/repo_pull_request_thumbnail.dart';

class RepoPullRequestsList extends StatelessWidget {
  const RepoPullRequestsList({required this.pullRequests, super.key});

  final List<RepoPullRequest> pullRequests;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int index = 0; index < pullRequests.length; index++) ...[
            RepoPullRequestThumbnail(pullRequest: pullRequests[index]),
            if (index < pullRequests.length - 1) const Divider(),
          ],
        ],
      ),
    );
  }
}
