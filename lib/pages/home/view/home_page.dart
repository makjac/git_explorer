import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/core/localization/app_localizations_extension.dart';
import 'package:git_explorer/core/router/app_router.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/core/widgets/icons/app_icon.dart';
import 'package:git_explorer/core/widgets/icons/app_icons.dart';
import 'package:git_explorer/pages/home/cubit/search_repo_cubit.dart';
import 'package:git_explorer/pages/home/models/repo_search_response.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<SearchRepoCubit>().loadMoreRepos();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _searchRepositories(String query) {
    context.read<SearchRepoCubit>().searchRepos(query);
  }

  void _clearSearch() {
    context.read<SearchRepoCubit>().clear();
    _focusNode.unfocus();
  }

  void _retrySearch() {
    final currentQuery = _controller.text;
    if (currentQuery.isNotEmpty) {
      _searchRepositories(currentQuery);
    } else {
      _clearSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchRepoCubit, SearchRepoState>(
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildAppBar(),
              if (state.repos.isNotEmpty) _buildReposList(state.repos),
              SliverToBoxAdapter(child: _buildStateView(state)),
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 16),
                sliver: SliverToBoxAdapter(child: SizedBox()),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      title: Text(context.l10n.app_name),
      floating: true,
      pinned: true,
      expandedHeight: 110,
      forceElevated: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: RepoSearchBar(
            controller: _controller,
            onChanged: _searchRepositories,
            onClear: _clearSearch,
            focusNode: _focusNode,
            hintText: context.l10n.repo_search_bar_hint,
          ),
        ),
      ),
    );
  }

  Widget _buildReposList(List<RepoSearchResult> repos) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: RepoThumbnail(
              repo: repos[index],
              onTap:
                  () => context.pushRoute(
                    RepoRoute(fullName: repos[index].fullName ?? ''),
                  ),
            ),
          );
        }, childCount: repos.length),
      ),
    );
  }

  Widget _buildStateView(SearchRepoState state) {
    if (state is SearchRepoLoading) {
      return _buildLoadingView(state.repos.isEmpty);
    } else if (state is SearchRepoError) {
      return _buildErrorView();
    } else if (state is SearchRepoInitial && state.repos.isEmpty) {
      return _buildInitialView();
    } else if (state is SearchRepoReposFetched && state.repos.isEmpty) {
      return _buildEmptyResultView();
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildLoadingView(bool isInitialLoading) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: isInitialLoading ? MediaQuery.of(context).size.height / 3 : 20,
          bottom: 20,
        ),
        child: const CircularProgressIndicator.adaptive(),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 3,
          bottom: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.rs_something_went_wrong,
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: _retrySearch,
              child: Text(context.l10n.rs_try_again),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 3,
          bottom: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppIcon(icon: AppIcons.repository, size: 50),
            const SizedBox(height: 16),
            Text(
              context.l10n.rs_search_for_repositories,
              style: context.textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyResultView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 3,
          bottom: 20,
        ),
        child: Text(
          context.l10n.rs_repositores_not_match,
          style: context.textTheme.titleLarge,
        ),
      ),
    );
  }
}
