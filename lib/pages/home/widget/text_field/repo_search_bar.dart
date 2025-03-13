import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/core/widgets/icons/app_icon.dart';
import 'package:git_explorer/core/widgets/icons/app_icons.dart';

class RepoSearchBar extends StatefulWidget {
  const RepoSearchBar({
    required this.controller,
    this.onChanged,
    this.onClear,
    this.focusNode,
    this.hintText,
    super.key,
  });

  final TextSpanEditingController controller;
  final void Function(String)? onChanged;
  final VoidCallback? onClear;
  final FocusNode? focusNode;
  final String? hintText;

  @override
  State<RepoSearchBar> createState() => _RepoSearchBarState();
}

class _RepoSearchBarState extends State<RepoSearchBar> {
  bool _hasText = false;

  static const _iconPadding = EdgeInsets.only(left: 12, right: 2, top: 2);
  static const _prefixConstraints = BoxConstraints(maxWidth: 35, maxHeight: 25);

  @override
  void initState() {
    super.initState();
    _hasText = widget.controller.text.isNotEmpty;
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _clear() {
    widget.controller.clear();
    widget.onClear?.call();
  }

  Widget? _buildSuffixIcon() {
    if (!_hasText) return null;

    return IconButton(
      onPressed: _clear,
      icon: const AppIcon(icon: AppIcons.clear),
      padding: const EdgeInsets.only(right: 10),
      style: IconButton.styleFrom(minimumSize: const Size(25, 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Padding(
          padding: _iconPadding,
          child: AppIcon(icon: AppIcons.search),
        ),
        prefixIconConstraints: _prefixConstraints,
        suffixIcon: _buildSuffixIcon(),
        suffixIconConstraints: _prefixConstraints,
      ),
    );
  }
}

class TextSpanEditingController extends TextEditingController {
  TextSpanEditingController({String text = ''}) : super(text: text) {
    _compileKeywordsRegex();
  }

  static const List<String> _keywords = ['language:', 'user:', 'stars:'];
  late RegExp _keywordsRegex;

  void _compileKeywordsRegex() {
    if (_keywords.isEmpty) {
      _keywordsRegex = RegExp(r'^$');
      return;
    }

    final sortedKeywords = List<String>.from(_keywords)
      ..sort((a, b) => b.length.compareTo(a.length));

    final pattern = sortedKeywords.map(RegExp.escape).join('|');
    _keywordsRegex = RegExp('($pattern)(\\S*)', caseSensitive: false);
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    required bool withComposing,
    TextStyle? style,
  }) {
    return _formatTextWithHighlights(text, style, context);
  }

  TextSpan _formatTextWithHighlights(
    String text,
    TextStyle? style,
    BuildContext context,
  ) {
    if (text.isEmpty || _keywords.isEmpty) {
      return TextSpan(text: text, style: style);
    }

    final spans = <TextSpan>[];
    var currentPosition = 0;

    for (final match in _keywordsRegex.allMatches(text)) {
      final keyword = match.group(1)!;
      final value = match.group(2) ?? '';
      final start = match.start;
      final end = match.end;

      if (start > currentPosition) {
        spans.add(
          TextSpan(text: text.substring(currentPosition, start), style: style),
        );
      }

      spans.add(TextSpan(text: keyword, style: style));

      if (value.isNotEmpty) {
        spans.add(
          TextSpan(
            text: value,
            style: TextStyle(
              color: context.colorScheme.primary,
              backgroundColor: context.colorScheme.primary.withValues(
                alpha: .2,
              ),
            ),
          ),
        );
      }

      currentPosition = end;
    }

    if (currentPosition < text.length) {
      spans.add(TextSpan(text: text.substring(currentPosition), style: style));
    }

    return TextSpan(children: spans);
  }
}
