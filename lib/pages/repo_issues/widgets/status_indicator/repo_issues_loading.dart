import 'package:flutter/material.dart';

class RepoIssuesLoading extends StatelessWidget {
  const RepoIssuesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
