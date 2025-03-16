import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/home/api/search_repo_api.dart';
import 'package:git_explorer/pages/home/models/repo_search_response.dart';
import 'package:git_explorer/pages/home/repository/repo_search_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'repo_search_repository_test.mocks.dart';

@GenerateMocks([SearchRepoApi])
void main() {
  late RepoSearchRepositoryImpl repository;
  late MockSearchRepoApi mockApi;

  setUp(() {
    mockApi = MockSearchRepoApi();
    repository = RepoSearchRepositoryImpl(searchRepoApi: mockApi);
  });

  group('RepoSearchRepositoryImpl', () {
    test('searchRepositories returns results on success', () async {
      const query = 'flutter';
      const response = RepoSearchResponse(
        items: [RepoSearchResult(name: 'repo1')],
      );

      when(
        mockApi.call(
          query: anyNamed('query'),
          page: anyNamed('page'),
          cancelToken: anyNamed('cancelToken'),
        ),
      ).thenAnswer((_) async => response);

      final results = await repository.searchRepositories(query);

      expect(results, isNotEmpty);
      expect(results.first.name, 'repo1');
      verify(
        mockApi.call(
          query: anyNamed('query'),
          page: anyNamed('page'),
          cancelToken: anyNamed('cancelToken'),
        ),
      ).called(1);
    });

    test('searchRepositories returns empty list on same query', () async {
      const query = 'flutter';
      const response = RepoSearchResponse(
        items: [RepoSearchResult(name: 'repo1')],
      );

      when(
        mockApi.call(
          query: anyNamed('query'),
          page: anyNamed('page'),
          cancelToken: anyNamed('cancelToken'),
        ),
      ).thenAnswer((_) async => response);

      await repository.searchRepositories(query);
      final results = await repository.searchRepositories(query);

      expect(results, isEmpty);
      verify(
        mockApi.call(
          query: anyNamed('query'),
          page: anyNamed('page'),
          cancelToken: anyNamed('cancelToken'),
        ),
      ).called(1);
    });

    test('loadMoreRepositories returns more results on success', () async {
      const query = 'flutter';
      const response = RepoSearchResponse(
        items: [RepoSearchResult(name: 'repo1')],
      );

      when(
        mockApi.call(
          query: anyNamed('query'),
          page: anyNamed('page'),
          cancelToken: anyNamed('cancelToken'),
        ),
      ).thenAnswer((_) async => response);

      await repository.searchRepositories(query);
      final moreResults = await repository.loadMoreRepositories();

      expect(moreResults, isNotEmpty);
      expect(moreResults.first.name, 'repo1');
      verify(
        mockApi.call(
          query: anyNamed('query'),
          page: anyNamed('page'),
          cancelToken: anyNamed('cancelToken'),
        ),
      ).called(2);
    });

    test(
      'loadMoreRepositories returns empty list when hasReachedEnd is true',
      () async {
        const query = 'flutter';
        const response = RepoSearchResponse(items: []);

        when(
          mockApi.call(
            query: anyNamed('query'),
            page: anyNamed('page'),
            cancelToken: anyNamed('cancelToken'),
          ),
        ).thenAnswer((_) async => response);

        await repository.searchRepositories(query);
        final moreResults = await repository.loadMoreRepositories();

        expect(moreResults, isEmpty);
        verify(
          mockApi.call(
            query: anyNamed('query'),
            page: anyNamed('page'),
            cancelToken: anyNamed('cancelToken'),
          ),
        ).called(1);
      },
    );

    test('reset resets the state', () async {
      repository.reset();

      expect(repository.currentPage, 1);
      expect(repository.hasReachedEnd, isFalse);
    });
  });
}
