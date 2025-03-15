import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:git_explorer/core/router/app_router.dart';
import 'package:git_explorer/core/widgets/icons/app_icon.dart';
import 'package:git_explorer/core/widgets/icons/app_icons.dart';

@RoutePage()
class RepoDashboardPage extends StatelessWidget {
  const RepoDashboardPage({
    @PathParam('fullName') required this.fullName,
    super.key,
  });

  final String fullName;
  static const _tabHeight = 36.0;

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        RepoDetailsRoute(fullName: fullName),
        RepoIssuesRoute(fullName: fullName),
        RepoPullRequestsRoute(fullName: fullName),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(fullName),
              toolbarHeight: 60,
              bottom: TabBar(
                onTap: tabsRouter.setActiveIndex,
                padding: EdgeInsets.zero,
                labelPadding: const EdgeInsets.symmetric(vertical: 8),
                tabs: const [
                  Tab(
                    text: 'Details',
                    icon: AppIcon(icon: AppIcons.repository),
                    height: _tabHeight,
                  ),
                  Tab(
                    text: 'Issues',
                    icon: AppIcon(icon: AppIcons.issue),
                    height: _tabHeight,
                  ),
                  Tab(
                    text: 'Pull Requests',
                    icon: AppIcon(icon: AppIcons.pullRequest),
                    height: _tabHeight,
                  ),
                ],
              ),
            ),
            body: child,
          ),
        );
      },
    );
  }
}
