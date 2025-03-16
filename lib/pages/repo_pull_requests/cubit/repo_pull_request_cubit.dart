import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:git_explorer/pages/repo_pull_requests/models/repo_pull_request.dart';
import 'package:git_explorer/pages/repo_pull_requests/repository/repo_pull_request_repository.dart';

part 'repo_pull_request_state.dart';
part 'repo_pull_request_cubit.freezed.dart';

class RepoPullRequestCubit extends Cubit<RepoPullRequestState> {
  RepoPullRequestCubit({RepoPullRequestRepository? repository})
    : _repository = repository ?? RepoPullRequestRepositoryImpl(),
      super(const RepoPullRequestState.initial());

  final RepoPullRequestRepository _repository;

  List<RepoPullRequest> _allPullRequests = [];
  bool _isLoading = false;

  Future<void> fetchPullRequests(String fullName) async {
    _resetState(fullName);

    if (_isLoading) return;
    _isLoading = true;

    emit(RepoPullRequestState.loading(repos: _allPullRequests));

    try {
      final newPullRequests = await _repository.fetchPullRequests(fullName);
      _isLoading = false;

      if (newPullRequests == null) {
        emit(
          RepoPullRequestState.error(
            repos: _allPullRequests,
            errorMessage: 'Unable to fetch pull requests',
          ),
        );
        return;
      }

      _allPullRequests = newPullRequests;

      emit(RepoPullRequestState.reposFetched(repos: _allPullRequests));
    } catch (e) {
      _isLoading = false;
      emit(
        RepoPullRequestState.error(
          repos: _allPullRequests,
          errorMessage: 'An error occurred: $e',
        ),
      );
    }
  }

  Future<void> loadMore(String fullName) async {
    if (_repository.hasReachedEnd || _isLoading) {
      return;
    }

    _isLoading = true;
    emit(RepoPullRequestState.loading(repos: _allPullRequests));

    try {
      final newPullRequests = await _repository.fetchPullRequests(fullName);
      _isLoading = false;

      if (newPullRequests == null) {
        emit(
          RepoPullRequestState.error(
            repos: _allPullRequests,
            errorMessage: 'Unable to load more pull requests',
          ),
        );
        return;
      }

      if (newPullRequests.isEmpty) {
        emit(RepoPullRequestState.reposFetched(repos: _allPullRequests));
        return;
      }

      _allPullRequests = [..._allPullRequests, ...newPullRequests];
      emit(RepoPullRequestState.reposFetched(repos: _allPullRequests));
    } catch (e) {
      _isLoading = false;
      emit(
        RepoPullRequestState.error(
          repos: _allPullRequests,
          errorMessage: 'Error loading more pull requests: $e',
        ),
      );
    }
  }

  void _resetState(String newRepo) {
    _allPullRequests = [];
    _isLoading = false;

    _repository.reset();
  }

  bool get hasMoreData => !_repository.hasReachedEnd;
}
