import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RepoPullRequestsPage extends StatelessWidget {
  const RepoPullRequestsPage({
    @PathParam('fullName') required this.fullName,
    super.key,
  });

  final String fullName;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('RepoPullRequestsPage')));
  }
}
