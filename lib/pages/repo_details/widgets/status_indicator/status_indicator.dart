import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';

class StatusIndicator extends StatelessWidget {
  const StatusIndicator._({required this.message, this.isError = false});

  factory StatusIndicator.loading(String message) {
    return StatusIndicator._(message: message);
  }

  factory StatusIndicator.error(String? errorMessage) {
    return StatusIndicator._(
      message: errorMessage ?? 'An error occurred',
      isError: true,
    );
  }

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.error.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.colorScheme.error.withValues(alpha: .3),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: context.colorScheme.error),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Column(
          children: [
            const CircularProgressIndicator.adaptive(),
            const SizedBox(height: 16),
            Text(message),
          ],
        ),
      ),
    );
  }
}
