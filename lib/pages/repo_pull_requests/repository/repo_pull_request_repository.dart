import 'package:git_explorer/pages/repo_pull_requests/api/fetch_repo_pull_request_api.dart';
import 'package:git_explorer/pages/repo_pull_requests/models/repo_pull_request.dart';

abstract class RepoPullRequestRepository {
  Future<List<RepoPullRequest>?> fetchPullRequests(String fullName);
  bool get hasReachedEnd;
  int get currentPage;
  void reset();
}

class RepoPullRequestRepositoryImpl implements RepoPullRequestRepository {
  RepoPullRequestRepositoryImpl({FetchRepoPullRequestApi? searchRepoApi})
    : _api = searchRepoApi ?? FetchRepoPullRequestApiImpl();

  final FetchRepoPullRequestApi _api;
  bool _hasReachedEnd = false;
  int _currentPage = 1;

  @override
  bool get hasReachedEnd => _hasReachedEnd;

  @override
  int get currentPage => _currentPage;

  @override
  Future<List<RepoPullRequest>?> fetchPullRequests(String fullName) async {
    try {
      if (_hasReachedEnd) return [];

      final results = await _api.call(fullName: fullName, page: _currentPage);

      if (results != null) {
        if (results.isEmpty) {
          _hasReachedEnd = true;
          return [];
        }
        _currentPage++;
        return results;
      } else {
        _hasReachedEnd = true;
        return [];
      }
    } catch (_) {
      return null;
    }
  }

  @override
  void reset() {
    _hasReachedEnd = false;
    _currentPage = 1;
  }
}
