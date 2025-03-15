import 'package:flutter/material.dart';

class RepoIssuesEmpty extends StatelessWidget {
  const RepoIssuesEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(Icons.info_outline, size: 40), Text('No issues found')],
    );
  }
}
