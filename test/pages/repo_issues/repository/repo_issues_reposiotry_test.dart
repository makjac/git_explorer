import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/repo_issues/api/fetch_repo_issues_api.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue/repo_issue.dart';
import 'package:git_explorer/pages/repo_issues/repository/repo_issues_reposiotry.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'repo_issues_reposiotry_test.mocks.dart';

@GenerateMocks([FetchRepoIssuesApi])
void main() {
  late RepoIssuesRepositoryImpl repository;
  late MockFetchRepoIssuesApi mockApi;

  setUp(() {
    mockApi = MockFetchRepoIssuesApi();
    repository = RepoIssuesRepositoryImpl(fetchRepoIssuesApi: mockApi);
  });

  group('RepoIssuesRepositoryImpl', () {
    const fullName = 'owner/repo';
    final issues = [const RepoIssue(id: 1, title: 'Issue 1')];

    test('fetchOpenIssues returns issues and updates state', () async {
      when(
        mockApi.call(
          fullName: anyNamed('fullName'),
          page: anyNamed('page'),
          perPage: anyNamed('perPage'),
          type: anyNamed('type'),
          cancelToken: anyNamed('cancelToken'),
        ),
      ).thenAnswer((_) async => issues);

      final result = await repository.fetchOpenIssues(fullName: fullName);

      expect(result.issues, issues);
      expect(result.hasMore, true);
      expect(repository.getOpenIssues(), issues);
    });

    test('fetchClosedIssues returns issues and updates state', () async {
      when(
        mockApi.call(
          fullName: anyNamed('fullName'),
          page: anyNamed('page'),
          perPage: anyNamed('perPage'),
          type: anyNamed('type'),
          cancelToken: anyNamed('cancelToken'),
        ),
      ).thenAnswer((_) async => issues);

      final result = await repository.fetchClosedIssues(fullName: fullName);

      expect(result.issues, issues);
      expect(result.hasMore, true);
      expect(repository.getClosedIssues(), issues);
    });

    test('fetchAllIssues returns issues and updates state', () async {
      when(
        mockApi.call(
          fullName: anyNamed('fullName'),
          page: anyNamed('page'),
          perPage: anyNamed('perPage'),
          type: anyNamed('type'),
          cancelToken: anyNamed('cancelToken'),
        ),
      ).thenAnswer((_) async => issues);

      final result = await repository.fetchAllIssues(fullName: fullName);

      expect(result.issues, issues);
      expect(result.hasMore, true);
      expect(repository.getAllIssues(), issues);
    });
  });
}
