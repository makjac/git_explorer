import 'package:git_explorer/pages/repo_issues/models/repo_issue_type/repo_issue_type.dart';

mixin ApiPathBuilderMixin {
  // Base URL
  static const String baseUrl = 'https://api.github.com';

  // Endpoints
  String searchRepo(String query, {int page = 1, int perPage = 20}) {
    assert(query.trim().isNotEmpty, 'Query must not be empty');
    assert(perPage >= 1, 'Limit (per_page) must be greater than or equal to 1');
    assert(page >= 1, 'Page must be greater than or equal to 1');

    final queryParams = {
      'page': page.toString(),
      'per_page': perPage.toString(),
    };

    final queryParamsString = _buildSearchQueryParams(queryParams);

    return '$baseUrl/search/repositories?q=$query$queryParamsString';
  }

  String fetchRepoDetails(String fullName) {
    assert(fullName.trim().isNotEmpty, 'Full name must not be empty');
    assert(fullName.contains('/'), 'Full name must contain a slash (/)');
    assert(
      fullName.split('/').length == 2,
      'Full name must contain only one slash (/)',
    );

    return '$baseUrl/repos/$fullName';
  }

  String fetchRepoReference(String fullName, String defaultBranch) {
    assert(fullName.trim().isNotEmpty, 'Full name must not be empty');
    assert(defaultBranch.trim().isNotEmpty, 'default branch must not be empty');
    assert(fullName.contains('/'), 'Full name must contain a slash (/)');
    assert(
      fullName.split('/').length == 2,
      'Full name must contain only one slash (/)',
    );

    return '$baseUrl/repos/$fullName/git/refs/heads/$defaultBranch';
  }

  String fetchRepoTree(String fullName, String sha) {
    assert(fullName.trim().isNotEmpty, 'Full name must not be empty');
    assert(sha.trim().isNotEmpty, 'default branch must not be empty');
    assert(fullName.contains('/'), 'Full name must contain a slash (/)');
    assert(
      fullName.split('/').length == 2,
      'Full name must contain only one slash (/)',
    );

    return '$baseUrl/repos/$fullName/git/trees/$sha';
  }

  String fetchRepoIssues(
    String fullName, {
    int page = 1,
    int perPage = 20,
    IssueStateType type = IssueStateType.open,
  }) {
    assert(fullName.trim().isNotEmpty, 'Full name must not be empty');
    assert(fullName.contains('/'), 'Full name must contain a slash (/)');
    assert(
      fullName.split('/').length == 2,
      'Full name must contain only one slash (/)',
    );
    assert(perPage >= 1, 'Limit (per_page) must be greater than or equal to 1');
    assert(page >= 1, 'Page must be greater than or equal to 1');

    final queryParams = {
      'page': page.toString(),
      'per_page': perPage.toString(),
      'state': type.value,
    };

    final queryParamsString = _buildQueryParams(queryParams);

    return '$baseUrl/repos/$fullName/issues$queryParamsString';
  }

  String fetchRepoPullRequest(
    String fullName, {
    int page = 1,
    int perPage = 20,
  }) {
    assert(fullName.trim().isNotEmpty, 'Full name must not be empty');
    assert(fullName.contains('/'), 'Full name must contain a slash (/)');
    assert(
      fullName.split('/').length == 2,
      'Full name must contain only one slash (/)',
    );
    assert(perPage >= 1, 'Limit (per_page) must be greater than or equal to 1');
    assert(page >= 1, 'Page must be greater than or equal to 1');

    final queryParams = {
      'page': page.toString(),
      'per_page': perPage.toString(),
      'state': 'all',
    };

    final queryParamsString = _buildQueryParams(queryParams);

    return '$baseUrl/repos/$fullName/pulls$queryParamsString';
  }

  String _buildQueryParams(Map<String, String> params) {
    if (params.isEmpty) return '';

    final entries = params.entries.toList();

    final queryString =
        entries.asMap().entries.map((mapEntry) {
          final index = mapEntry.key;
          final param = mapEntry.value;
          final prefix = index == 0 ? '?' : '&';

          return '$prefix${Uri.encodeComponent(param.key)}='
              '${Uri.encodeComponent(param.value)}';
        }).join();

    return queryString;
  }

  String _buildSearchQueryParams(Map<String, String> params) {
    if (params.isEmpty) return '';

    final queryString =
        params.entries
            .map(
              (e) =>
                  '&${Uri.encodeComponent(e.key)}='
                  '${Uri.encodeComponent(e.value)}',
            )
            .join();

    return queryString;
  }
}
