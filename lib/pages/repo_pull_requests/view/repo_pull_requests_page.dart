import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/pages/repo_pull_requests/cubit/repo_pull_request_cubit.dart';
import 'package:git_explorer/pages/repo_pull_requests/widgets/repo_pull_request_widget.dart';

@RoutePage()
class RepoPullRequestsPage extends StatefulWidget {
  const RepoPullRequestsPage({
    @PathParam('fullName') required this.fullName,
    super.key,
  });

  final String fullName;

  @override
  State<RepoPullRequestsPage> createState() => _RepoPullRequestsPageState();
}

class _RepoPullRequestsPageState extends State<RepoPullRequestsPage> {
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<RepoPullRequestCubit>().fetchPullRequests(widget.fullName);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (_isBottom) {
      context.read<RepoPullRequestCubit>().loadMore(widget.fullName);
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<RepoPullRequestCubit, RepoPullRequestState>(
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverToBoxAdapter(child: RepoPullRequestsHeader()),
              switch (state) {
                RepoPullRequestInitial() => const SliverFillRemaining(
                  child: LoadingPullRequestIndicator(),
                ),
                RepoPullRequestLoading(repos: final repos) =>
                  repos.isEmpty
                      ? const SliverFillRemaining(
                        child: LoadingPullRequestIndicator(),
                      )
                      : SliverList(
                        delegate: SliverChildListDelegate([
                          RepoPullRequestsList(pullRequests: repos),
                          const LoadingPullRequestIndicator(),
                        ]),
                      ),
                RepoPullRequestFetched(repos: final repos) =>
                  repos.isEmpty
                      ? const SliverFillRemaining(
                        child: EmptyPullRequestsView(),
                      )
                      : SliverToBoxAdapter(
                        child: RepoPullRequestsList(pullRequests: repos),
                      ),
                RepoPullRequestError(
                  repos: final repos,
                  errorMessage: final errorMessage,
                ) =>
                  repos.isEmpty
                      ? SliverFillRemaining(
                        child: RepoPullRequestsErrorAlert(
                          errorMessage: errorMessage,
                        ),
                      )
                      : SliverList(
                        delegate: SliverChildListDelegate([
                          RepoPullRequestsErrorAlert(
                            errorMessage: errorMessage,
                          ),
                          RepoPullRequestsList(pullRequests: repos),
                        ]),
                      ),
              },
            ],
          );
        },
      ),
    );
  }
}
