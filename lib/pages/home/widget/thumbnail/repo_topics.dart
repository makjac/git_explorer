import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';

class RepoTopics extends StatelessWidget {
  const RepoTopics({required this.topics, super.key});

  final List<String> topics;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          topics
              .take(5)
              .map((topic) => _buildTopicChip(context, topic))
              .toList(),
    );
  }

  Widget _buildTopicChip(BuildContext context, String topic) {
    const topicColor = Color(0xFF388BFD);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: topicColor.withValues(alpha: .1),
      ),
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        widthFactor: 1,
        child: Text(
          topic,
          style: context.textTheme.bodySmall?.copyWith(
            color: topicColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
