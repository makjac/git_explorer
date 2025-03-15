import 'package:dio/dio.dart';
import 'package:git_explorer/pages/repo_issues/api/fetch_repo_issues_api.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue/repo_issue.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue_type/repo_issue_type.dart';

abstract class RepoIssuesRepository {
  Future<PaginatedIssuesResult> fetchOpenIssues({
    required String fullName,
    int perPage,
  });

  Future<PaginatedIssuesResult> fetchClosedIssues({
    required String fullName,
    int perPage,
  });

  Future<PaginatedIssuesResult> fetchAllIssues({
    required String fullName,
    int perPage,
  });

  List<RepoIssue> getOpenIssues();

  List<RepoIssue> getClosedIssues();

  List<RepoIssue> getAllIssues();

  void cancelOngoingRequests();
}

class PaginatedIssuesResult {
  PaginatedIssuesResult({required this.issues, required this.hasMore});

  final List<RepoIssue> issues;
  final bool hasMore;
}

class RepoIssuesRepositoryImpl implements RepoIssuesRepository {
  RepoIssuesRepositoryImpl({required FetchRepoIssuesApi fetchRepoIssuesApi})
    : _fetchRepoIssuesApi = fetchRepoIssuesApi;

  final FetchRepoIssuesApi _fetchRepoIssuesApi;
  CancelToken? _cancelToken;

  final List<RepoIssue> _openIssues = [];
  final List<RepoIssue> _closedIssues = [];
  final List<RepoIssue> _allIssues = [];

  int _openIssuesPage = 1;
  int _closedIssuesPage = 1;
  int _allIssuesPage = 1;

  bool _hasMoreOpenIssues = true;
  bool _hasMoreClosedIssues = true;
  bool _hasMoreAllIssues = true;

  @override
  Future<PaginatedIssuesResult> fetchOpenIssues({
    required String fullName,
    int perPage = 20,
  }) async {
    if (!_hasMoreOpenIssues) {
      return PaginatedIssuesResult(issues: _openIssues, hasMore: false);
    }

    cancelOngoingRequests();
    _cancelToken = CancelToken();

    try {
      final issues = await _fetchRepoIssuesApi.call(
        fullName: fullName,
        page: _openIssuesPage,
        perPage: perPage,
        type: IssueStateType.open,
        cancelToken: _cancelToken,
      );

      if (issues == null || issues.isEmpty) {
        _hasMoreOpenIssues = false;
      } else {
        _openIssues.addAll(issues);
        _openIssuesPage++;
      }

      return PaginatedIssuesResult(
        issues: _openIssues,
        hasMore: _hasMoreOpenIssues,
      );
    } catch (e) {
      if (e is DioException &&
          (e.requestOptions.cancelToken?.isCancelled ?? false)) {
        return PaginatedIssuesResult(
          issues: _openIssues,
          hasMore: _hasMoreOpenIssues,
        );
      }
      rethrow;
    }
  }

  @override
  Future<PaginatedIssuesResult> fetchClosedIssues({
    required String fullName,
    int perPage = 20,
  }) async {
    if (!_hasMoreClosedIssues) {
      return PaginatedIssuesResult(issues: _closedIssues, hasMore: false);
    }

    cancelOngoingRequests();
    _cancelToken = CancelToken();

    try {
      final issues = await _fetchRepoIssuesApi.call(
        fullName: fullName,
        page: _closedIssuesPage,
        perPage: perPage,
        type: IssueStateType.closed,
        cancelToken: _cancelToken,
      );

      if (issues == null || issues.isEmpty) {
        _hasMoreClosedIssues = false;
      } else {
        _closedIssues.addAll(issues);
        _closedIssuesPage++;
      }

      return PaginatedIssuesResult(
        issues: _closedIssues,
        hasMore: _hasMoreClosedIssues,
      );
    } catch (e) {
      if (e is DioException &&
          (e.requestOptions.cancelToken?.isCancelled ?? false)) {
        return PaginatedIssuesResult(
          issues: _closedIssues,
          hasMore: _hasMoreClosedIssues,
        );
      }
      rethrow;
    }
  }

  @override
  Future<PaginatedIssuesResult> fetchAllIssues({
    required String fullName,
    int perPage = 20,
  }) async {
    if (!_hasMoreAllIssues) {
      return PaginatedIssuesResult(issues: _allIssues, hasMore: false);
    }

    cancelOngoingRequests();
    _cancelToken = CancelToken();

    try {
      final issues = await _fetchRepoIssuesApi.call(
        fullName: fullName,
        page: _allIssuesPage,
        perPage: perPage,
        type: IssueStateType.all,
        cancelToken: _cancelToken,
      );

      if (issues == null || issues.isEmpty) {
        _hasMoreAllIssues = false;
      } else {
        _allIssues.addAll(issues);
        _allIssuesPage++;
      }

      return PaginatedIssuesResult(
        issues: _allIssues,
        hasMore: _hasMoreAllIssues,
      );
    } catch (e) {
      if (e is DioException &&
          (e.requestOptions.cancelToken?.isCancelled ?? false)) {
        return PaginatedIssuesResult(
          issues: _allIssues,
          hasMore: _hasMoreAllIssues,
        );
      }
      rethrow;
    }
  }

  @override
  List<RepoIssue> getOpenIssues() => List.unmodifiable(_openIssues);

  @override
  List<RepoIssue> getClosedIssues() => List.unmodifiable(_closedIssues);

  @override
  List<RepoIssue> getAllIssues() => List.unmodifiable(_allIssues);

  @override
  void cancelOngoingRequests() {
    _cancelToken?.cancel('New request started');
    _cancelToken = null;
  }
}
