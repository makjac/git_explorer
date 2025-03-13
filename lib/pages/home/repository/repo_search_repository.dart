import 'package:dio/dio.dart';
import 'package:git_explorer/core/utils/logger.dart';
import 'package:git_explorer/pages/home/api/search_repo_api.dart';
import 'package:git_explorer/pages/home/models/repo_search_response.dart';

abstract class RepoSearchRepository {
  Future<List<RepoSearchResult>> searchRepositories(String query);
  Future<List<RepoSearchResult>> loadMoreRepositories();
  void reset();
  void cancelSearch();
  bool get hasReachedEnd;
  int get currentPage;
}

class RepoSearchRepositoryImpl implements RepoSearchRepository {
  RepoSearchRepositoryImpl({SearchRepoApi? searchRepoApi})
    : _api = searchRepoApi ?? SearchRepoApiImpl();

  final SearchRepoApi _api;
  CancelToken? _cancelToken;
  String _lastQuery = '';
  bool _hasReachedEnd = false;
  int _currentPage = 1;

  @override
  bool get hasReachedEnd => _hasReachedEnd;

  @override
  int get currentPage => _currentPage;

  @override
  Future<List<RepoSearchResult>> searchRepositories(String query) async {
    cancelSearch();
    _cancelToken = CancelToken();

    _currentPage = 1;
    _hasReachedEnd = false;

    final searchQuery = _formatQuery(query);
    if (searchQuery == _lastQuery) return [];
    _lastQuery = searchQuery;

    try {
      final results = await _api.call(
        query: searchQuery,
        page: _currentPage,
        cancelToken: _cancelToken,
      );

      _updatePaginationState(results?.items ?? []);
      return results?.items ?? [];
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        Logger.showLog('Search canceled', 'RepoSearchRepository');
        return [];
      }
      rethrow;
    }
  }

  @override
  Future<List<RepoSearchResult>> loadMoreRepositories() async {
    if (_hasReachedEnd) return [];

    try {
      Logger.showLog(
        'Loading more repos $_currentPage',
        'RepoSearchRepository',
      );

      final results = await _api.call(query: _lastQuery, page: _currentPage);

      _updatePaginationState(results?.items ?? []);
      return results?.items ?? [];
    } catch (e) {
      Logger.showLog('Error loading more repos: $e', 'RepoSearchRepository');
      rethrow;
    }
  }

  void _updatePaginationState(List<RepoSearchResult> items) {
    _hasReachedEnd = items.isEmpty;
    if (items.isNotEmpty) {
      _currentPage++;
    }
  }

  String _formatQuery(String query) {
    return query.trim().replaceAll(' ', '+');
  }

  @override
  void reset() {
    _currentPage = 1;
    _hasReachedEnd = false;
    _lastQuery = '';
  }

  @override
  void cancelSearch() {
    _cancelToken?.cancel('New search initiated');
  }
}
