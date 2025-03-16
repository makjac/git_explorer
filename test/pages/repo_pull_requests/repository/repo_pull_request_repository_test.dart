import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/repo_pull_requests/api/fetch_repo_pull_request_api.dart';
import 'package:git_explorer/pages/repo_pull_requests/models/repo_pull_request.dart';
import 'package:git_explorer/pages/repo_pull_requests/repository/repo_pull_request_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'repo_pull_request_repository_test.mocks.dart';

@GenerateMocks([FetchRepoPullRequestApi])
void main() {
  late RepoPullRequestRepositoryImpl repository;
  late MockFetchRepoPullRequestApi mockApi;

  setUp(() {
    mockApi = MockFetchRepoPullRequestApi();
    repository = RepoPullRequestRepositoryImpl(searchRepoApi: mockApi);
  });

  group('RepoPullRequestRepositoryImpl', () {
    test('initial values are correct', () {
      expect(repository.hasReachedEnd, false);
      expect(repository.currentPage, 1);
    });

    test('fetchPullRequests returns data and increments page', () async {
      final pullRequests = [
        const RepoPullRequest(id: 1),
        const RepoPullRequest(id: 2),
      ];
      when(
        mockApi.call(fullName: 'test/repo', page: 1),
      ).thenAnswer((_) async => pullRequests);

      final result = await repository.fetchPullRequests('test/repo');

      expect(result, pullRequests);
      expect(repository.currentPage, 2);
      expect(repository.hasReachedEnd, false);
    });

    test(
      'fetchPullRequests sets hasReachedEnd when no data is returned',
      () async {
        when(
          mockApi.call(fullName: 'test/repo', page: 1),
        ).thenAnswer((_) async => []);

        final result = await repository.fetchPullRequests('test/repo');

        expect(result, <RepoPullRequest>[]);
        expect(repository.hasReachedEnd, true);
      },
    );

    test('fetchPullRequests returns null on error', () async {
      when(
        mockApi.call(fullName: 'test/repo', page: 1),
      ).thenThrow(Exception('API error'));

      final result = await repository.fetchPullRequests('test/repo');

      expect(result, null);
    });

    test('reset sets values to initial state', () {
      repository.reset();

      expect(repository.hasReachedEnd, false);
      expect(repository.currentPage, 1);
    });
  });
}
