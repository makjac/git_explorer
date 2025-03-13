import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:git_explorer/core/utils/logger.dart';
import 'package:git_explorer/pages/home/models/repo_search_response.dart';
import 'package:git_explorer/pages/home/repository/repo_search_repository.dart';

part 'search_repo_state.dart';
part 'search_repo_cubit.freezed.dart';

class SearchRepoCubit extends Cubit<SearchRepoState> {
  SearchRepoCubit({RepoSearchRepository? repoSearchRepository})
    : _repository = repoSearchRepository ?? RepoSearchRepositoryImpl(),
      super(const SearchRepoState.initial());

  final RepoSearchRepository _repository;
  Timer? _debounceTimer;

  void searchRepos(String query) {
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      _resetState();
      return;
    }

    emit(const SearchRepoState.loading());

    _debounceTimer = Timer(const Duration(milliseconds: 1000), () async {
      await _executeSearch(query);
    });
  }

  Future<void> loadMoreRepos() async {
    if (_repository.hasReachedEnd || state is SearchRepoLoading) return;

    try {
      emit(SearchRepoState.loading(repos: state.repos));

      final newRepos = await _repository.loadMoreRepositories();

      emit(SearchRepoState.reposFetched(repos: [...state.repos, ...newRepos]));
    } catch (e) {
      Logger.showLog('Error loading more repos: $e', 'SearchRepoCubit');

      emit(
        SearchRepoState.error(
          repos: state.repos,
          errorMessage: 'Error loading more repositories',
        ),
      );
    }
  }

  Future<void> _executeSearch(String query) async {
    if (query.trim().isEmpty) {
      _resetState();
      return;
    }

    try {
      final results = await _repository.searchRepositories(query);
      emit(SearchRepoState.reposFetched(repos: results));
    } catch (e) {
      Logger.showLog('Error searching repos: $e', 'SearchRepoCubit');

      emit(
        const SearchRepoState.error(
          errorMessage: 'Error searching repositories',
        ),
      );
    }
  }

  void _resetState() {
    _repository.reset();
    emit(const SearchRepoState.initial());
  }

  void clear() {
    _debounceTimer?.cancel();
    _repository.cancelSearch();
    _resetState();
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    _repository.cancelSearch();
    return super.close();
  }
}
