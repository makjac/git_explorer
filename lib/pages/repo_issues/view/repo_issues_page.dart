import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/core/localization/app_localizations_extension.dart';
import 'package:git_explorer/pages/repo_issues/cubit/repo_issues_cubit.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue_type/repo_issue_type.dart';
import 'package:git_explorer/pages/repo_issues/widgets/repo_issues_widget.dart';

@RoutePage()
class RepoIssuesPage extends StatefulWidget {
  const RepoIssuesPage({
    @PathParam('fullName') required this.fullName,
    super.key,
  });

  final String fullName;

  @override
  State<RepoIssuesPage> createState() => _RepoIssuesPageState();
}

class _RepoIssuesPageState extends State<RepoIssuesPage> {
  final ScrollController _scrollController = ScrollController();
  IssueStateType _currentIssueType = IssueStateType.open;

  bool _initialOpenLoading = true;
  bool _initialClosedLoading = true;
  bool _initialAllLoading = true;

  @override
  void initState() {
    super.initState();
    _loadIssues(_currentIssueType);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreIssues();
    }
  }

  void _loadIssues(IssueStateType type) {
    final cubit = context.read<RepoIssuesCubit>();

    switch (type) {
      case IssueStateType.open:
        cubit.fetchOpenIssues(fullName: widget.fullName);
      case IssueStateType.closed:
        cubit.fetchClosedIssues(fullName: widget.fullName);
      case IssueStateType.all:
        cubit.fetchAllIssues(fullName: widget.fullName);
    }
  }

  void _loadMoreIssues() {
    final currentState = context.read<RepoIssuesCubit>().state;
    if (currentState is RepoIssuesFetching) {
      return;
    }
    _loadIssues(_currentIssueType);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  void _updateInitialLoadingFlags(RepoIssuesState state) {
    if (state is OpenIssuesFetched) {
      _initialOpenLoading = false;
    } else if (state is ClosedIssuesFetched) {
      _initialClosedLoading = false;
    } else if (state is AllIssuesFetched) {
      _initialAllLoading = false;
    }
  }

  bool _isInitialLoading(IssueStateType type) => switch (type) {
    IssueStateType.open => _initialOpenLoading,
    IssueStateType.closed => _initialClosedLoading,
    IssueStateType.all => _initialAllLoading,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RepoIssuesCubit, RepoIssuesState>(
        listener: (context, state) {
          _updateInitialLoadingFlags(state);
        },
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: RepoIssuesHeader(
                  title: _getPageTitle(context),
                  currentType: _currentIssueType,
                  onStateChanged: (newState) {
                    setState(() {
                      _currentIssueType = newState;
                    });

                    if (_isInitialLoading(newState)) {
                      _loadIssues(newState);
                    }
                  },
                ),
              ),

              SliverToBoxAdapter(
                child: RepoIssuesContent(
                  state: state,
                  currentIssueType: _currentIssueType,

                  initialLoading: _getInitialLoadingFlag(state),
                ),
              ),

              if (_isLoadingMore(state))
                const SliverToBoxAdapter(child: RepoIssuesLoading()),
            ],
          );
        },
      ),
    );
  }

  bool _isLoadingMore(RepoIssuesState state) {
    if (state is LoadingOpenIssues &&
        _currentIssueType == IssueStateType.open) {
      return !_initialOpenLoading || state.openIssues.isNotEmpty;
    } else if (state is LoadingClosedIssues &&
        _currentIssueType == IssueStateType.closed) {
      return !_initialClosedLoading || state.closedIssues.isNotEmpty;
    } else if (state is LoadingAllIssues &&
        _currentIssueType == IssueStateType.all) {
      return !_initialAllLoading || state.allIssues.isNotEmpty;
    }
    return false;
  }

  bool _getInitialLoadingFlag(RepoIssuesState state) {
    if (state is LoadingOpenIssues &&
        _currentIssueType == IssueStateType.open) {
      return _initialOpenLoading;
    } else if (state is LoadingClosedIssues &&
        _currentIssueType == IssueStateType.closed) {
      return _initialClosedLoading;
    } else if (state is LoadingAllIssues &&
        _currentIssueType == IssueStateType.all) {
      return _initialAllLoading;
    }
    return false;
  }

  String _getPageTitle(BuildContext context) {
    return switch (_currentIssueType) {
      IssueStateType.open => context.l10n.openIssues,
      IssueStateType.closed => context.l10n.closedIssues,
      IssueStateType.all => context.l10n.allIssues,
    };
  }
}
