import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';

class RepoTopics extends StatelessWidget {
  const RepoTopics({required this.topics, super.key});

  final List<String> topics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children:
            topics
                .take(10)
                .map((topic) => _buildTopicChip(context, topic))
                .toList(),
      ),
    );
  }

  Widget _buildTopicChip(BuildContext context, String topic) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: context.colorScheme.primary.withValues(alpha: .1),
      ),
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        widthFactor: 1,
        child: Text(
          topic,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
