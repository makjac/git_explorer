import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:git_explorer/core/utils/logger.dart';
import 'package:git_explorer/pages/home/widget/home_widget.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextSpanEditingController _controller = TextSpanEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Git Explorer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            RepoSearchBar(
              controller: _controller,
              focusNode: _focusNode,
              hintText: 'Search "language:dart repo_name"',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Logger.showLog(_controller.text, 'SearchPage');
              },
              child: const Text('data'),
            ),
          ],
        ),
      ),
    );
  }
}
