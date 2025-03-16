import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/core/localization/app_localizations_extension.dart';
import 'package:git_explorer/core/router/app_router.dart';
import 'package:git_explorer/core/widgets/icons/app_icon.dart';
import 'package:git_explorer/core/widgets/icons/app_icons.dart';
import 'package:git_explorer/injection_container.dart';
import 'package:git_explorer/pages/repo_details/cubit/repo_details_cubit.dart';
import 'package:git_explorer/pages/repo_issues/cubit/repo_issues_cubit.dart';
import 'package:git_explorer/pages/repo_pull_requests/cubit/repo_pull_request_cubit.dart';

@RoutePage()
class RepoDashboardPage extends StatelessWidget {
  const RepoDashboardPage({
    @PathParam('fullName') required this.fullName,
    super.key,
  });

  final String fullName;
  static const double _tabHeight = 36;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<RepoDetailsCubit>()),
        BlocProvider(create: (context) => locator<RepoIssuesCubit>()),
        BlocProvider(create: (context) => locator<RepoPullRequestCubit>()),
      ],
      child: AutoTabsRouter(
        routes: _buildRoutes(),
        builder: (context, child) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(appBar: _buildAppBar(context), body: child),
          );
        },
      ),
    );
  }

  List<PageRouteInfo> _buildRoutes() {
    return [
      RepoDetailsRoute(fullName: fullName),
      RepoIssuesRoute(fullName: fullName),
      RepoPullRequestsRoute(fullName: fullName),
    ];
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);
    return AppBar(
      title: Text(fullName),
      toolbarHeight: 60,
      bottom: TabBar(
        onTap: tabsRouter.setActiveIndex,
        padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.symmetric(vertical: 8),
        tabs: _buildTabs(context),
      ),
    );
  }

  List<Tab> _buildTabs(BuildContext context) {
    return [
      Tab(
        text: context.l10n.details,
        icon: const AppIcon(icon: AppIcons.repository),
        height: _tabHeight,
      ),
      Tab(
        text: context.l10n.issues,
        icon: const AppIcon(icon: AppIcons.issue),
        height: _tabHeight,
      ),
      Tab(
        text: context.l10n.pullRequests,
        icon: const AppIcon(icon: AppIcons.pullRequest),
        height: _tabHeight,
      ),
    ];
  }
}
