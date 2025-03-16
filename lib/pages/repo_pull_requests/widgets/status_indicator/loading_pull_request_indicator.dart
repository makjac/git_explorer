import 'package:flutter/material.dart';

class LoadingPullRequestIndicator extends StatelessWidget {
  const LoadingPullRequestIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
