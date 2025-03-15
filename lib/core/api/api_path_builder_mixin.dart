import 'package:git_explorer/core/utils/logger.dart';

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

    const baseQueryUrl = '$baseUrl/search/repositories';
    final queryParamsString = _buildQueryParams(queryParams);

    final fullUrl = '$baseQueryUrl?q=$query$queryParamsString';

    Logger.showLog(fullUrl, 'ApiPathBuilderMixin');

    return fullUrl;
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

  String _buildQueryParams(Map<String, String> params) {
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
