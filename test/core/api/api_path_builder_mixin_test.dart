import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/core/api/api_path_builder_mixin.dart';

class ApiPathBuilder with ApiPathBuilderMixin {}

void main() {
  group('ApiPathBuilderMixin', () {
    final apiPathBuilder = ApiPathBuilder();

    test('baseUrl should be correct', () {
      expect(ApiPathBuilderMixin.baseUrl, 'https://api.github.com');
    });

    test('searchRepo should return correct URL', () {
      final url = apiPathBuilder.searchRepo('flutter', page: 2, perPage: 30);
      expect(
        url,
        'https://api.github.com/search/repositories?q=flutter&page=2&per_page=30',
      );
    });

    test('searchRepo should throw assertion error for empty query', () {
      expect(
        () => apiPathBuilder.searchRepo(''),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'Query must not be empty',
          ),
        ),
      );
    });

    test('searchRepo should throw assertion error for perPage less than 1', () {
      expect(
        () => apiPathBuilder.searchRepo('flutter', perPage: 0),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'Limit (per_page) must be greater than or equal to 1',
          ),
        ),
      );
    });

    test('fetchRepoDetails should return correct URL', () {
      final url = apiPathBuilder.fetchRepoDetails('flutter/flutter');
      expect(url, 'https://api.github.com/repos/flutter/flutter');
    });

    test(
      'fetchRepoDetails should throw assertion error for empty fullName',
      () {
        expect(
          () => apiPathBuilder.fetchRepoDetails(''),
          throwsA(
            isA<AssertionError>().having(
              (e) => e.message,
              'message',
              'Full name must not be empty',
            ),
          ),
        );
      },
    );

    test('fetchRepoDetails should throw assertion error for fullName without'
        ' slash', () {
      expect(
        () => apiPathBuilder.fetchRepoDetails('flutter'),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'Full name must contain a slash (/)',
          ),
        ),
      );
    });

    test(
      'fetchRepoDetails should throw assertion error for fullName with multiple'
      ' slashes',
      () {
        expect(
          () => apiPathBuilder.fetchRepoDetails('flutter/flutter/flutter'),
          throwsA(
            isA<AssertionError>().having(
              (e) => e.message,
              'message',
              'Full name must contain only one slash (/)',
            ),
          ),
        );
      },
    );

    test('fetchRepoReference should return correct URL', () {
      final url = apiPathBuilder.fetchRepoReference('flutter/flutter', 'main');
      expect(
        url,
        'https://api.github.com/repos/flutter/flutter/git/refs/heads/main',
      );
    });

    test(
      'fetchRepoReference should throw assertion error for empty fullName',
      () {
        expect(
          () => apiPathBuilder.fetchRepoReference('', 'main'),
          throwsA(
            isA<AssertionError>().having(
              (e) => e.message,
              'message',
              'Full name must not be empty',
            ),
          ),
        );
      },
    );

    test(
      'fetchRepoReference should throw assertion error for empty defaultBranch',
      () {
        expect(
          () => apiPathBuilder.fetchRepoReference('flutter/flutter', ''),
          throwsA(
            isA<AssertionError>().having(
              (e) => e.message,
              'message',
              'default branch must not be empty',
            ),
          ),
        );
      },
    );

    test('fetchRepoReference should throw assertion error for fullName without'
        ' slash', () {
      expect(
        () => apiPathBuilder.fetchRepoReference('flutter', 'main'),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'Full name must contain a slash (/)',
          ),
        ),
      );
    });

    test('fetchRepoReference should throw assertion error for fullName with'
        ' multiple'
        ' slashes', () {
      expect(
        () => apiPathBuilder.fetchRepoReference(
          'flutter/flutter/flutter',
          'main',
        ),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'Full name must contain only one slash (/)',
          ),
        ),
      );
    });

    test('fetchRepoTree should return correct URL', () {
      final url = apiPathBuilder.fetchRepoTree('flutter/flutter', 'sha123');
      expect(
        url,
        'https://api.github.com/repos/flutter/flutter/git/trees/sha123',
      );
    });

    test('fetchRepoTree should throw assertion error for empty fullName', () {
      expect(
        () => apiPathBuilder.fetchRepoTree('', 'sha123'),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'Full name must not be empty',
          ),
        ),
      );
    });

    test('fetchRepoTree should throw assertion error for empty sha', () {
      expect(
        () => apiPathBuilder.fetchRepoTree('flutter/flutter', ''),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'default branch must not be empty',
          ),
        ),
      );
    });

    test(
      'fetchRepoTree should throw assertion error for fullName without slash',
      () {
        expect(
          () => apiPathBuilder.fetchRepoTree('flutter', 'sha123'),
          throwsA(
            isA<AssertionError>().having(
              (e) => e.message,
              'message',
              'Full name must contain a slash (/)',
            ),
          ),
        );
      },
    );

    test('fetchRepoTree should throw assertion error for fullName with multiple'
        ' slashes', () {
      expect(
        () => apiPathBuilder.fetchRepoTree('flutter/flutter/flutter', 'sha123'),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'Full name must contain only one slash (/)',
          ),
        ),
      );
    });

    test('fetchRepoIssues should return correct URL', () {
      final url = apiPathBuilder.fetchRepoIssues(
        'flutter/flutter',
        page: 2,
        perPage: 30,
      );
      expect(
        url,
        'https://api.github.com/repos/flutter/flutter/issues?page=2&per_page=30&state=open',
      );
    });

    test('fetchRepoIssues should throw assertion error for empty fullName', () {
      expect(
        () => apiPathBuilder.fetchRepoIssues(''),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'Full name must not be empty',
          ),
        ),
      );
    });

    test('fetchRepoIssues should throw assertion error for fullName without'
        ' slash', () {
      expect(
        () => apiPathBuilder.fetchRepoIssues('flutter'),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'Full name must contain a slash (/)',
          ),
        ),
      );
    });

    test('fetchRepoIssues should throw assertion error for fullName with'
        ' multiple slashes', () {
      expect(
        () => apiPathBuilder.fetchRepoIssues('flutter/flutter/flutter'),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'Full name must contain only one slash (/)',
          ),
        ),
      );
    });

    test(
      'fetchRepoIssues should throw assertion error for perPage less than 1',
      () {
        expect(
          () => apiPathBuilder.fetchRepoIssues('flutter/flutter', perPage: 0),
          throwsA(
            isA<AssertionError>().having(
              (e) => e.message,
              'message',
              'Limit (per_page) must be greater than or equal to 1',
            ),
          ),
        );
      },
    );

    test(
      'fetchRepoIssues should throw assertion error for page less than 1',
      () {
        expect(
          () => apiPathBuilder.fetchRepoIssues('flutter/flutter', page: 0),
          throwsA(
            isA<AssertionError>().having(
              (e) => e.message,
              'message',
              'Page must be greater than or equal to 1',
            ),
          ),
        );
      },
    );

    test('fetchRepoPullRequest should return correct URL', () {
      final url = apiPathBuilder.fetchRepoPullRequest(
        'flutter/flutter',
        page: 2,
        perPage: 30,
      );
      expect(
        url,
        'https://api.github.com/repos/flutter/flutter/pulls?page=2&per_page=30&state=all',
      );
    });

    group('fetchRepoPullRequest', () {
      final apiPathBuilder = ApiPathBuilder();

      test(
        'fetchRepoPullRequest should throw assertion error for empty fullName',
        () {
          expect(
            () => apiPathBuilder.fetchRepoPullRequest(''),
            throwsA(
              isA<AssertionError>().having(
                (e) => e.message,
                'message',
                'Full name must not be empty',
              ),
            ),
          );
        },
      );
    });

    test('should throw assertion error for fullName without slash', () {
      expect(
        () => apiPathBuilder.fetchRepoPullRequest('flutter'),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'Full name must contain a slash (/)',
          ),
        ),
      );
    });

    test('fetchRepoPullRequest should throw assertion error for fullName with'
        ' multiple slashes', () {
      expect(
        () => apiPathBuilder.fetchRepoPullRequest('flutter/flutter/flutter'),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            'Full name must contain only one slash (/)',
          ),
        ),
      );
    });

    test(
      'fetchRepoPullRequest should throw assertion error for perPage less than'
      ' 1',
      () {
        expect(
          () => apiPathBuilder.fetchRepoPullRequest(
            'flutter/flutter',
            perPage: 0,
          ),
          throwsA(
            isA<AssertionError>().having(
              (e) => e.message,
              'message',
              'Limit (per_page) must be greater than or equal to 1',
            ),
          ),
        );
      },
    );

    test(
      'fetchRepoPullRequest should throw assertion error for page less than 1',
      () {
        expect(
          () => apiPathBuilder.fetchRepoPullRequest('flutter/flutter', page: 0),
          throwsA(
            isA<AssertionError>().having(
              (e) => e.message,
              'message',
              'Page must be greater than or equal to 1',
            ),
          ),
        );
      },
    );
  });
}
