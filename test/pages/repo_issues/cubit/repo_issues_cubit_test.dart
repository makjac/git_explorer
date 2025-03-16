import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/repo_issues/cubit/repo_issues_cubit.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue/repo_issue.dart';
import 'package:git_explorer/pages/repo_issues/repository/repo_issues_reposiotry.dart';
import 'package:mocktail/mocktail.dart';

class MockRepoIssuesRepository extends Mock implements RepoIssuesRepository {}

void main() {
  late RepoIssuesRepository repository;
  late RepoIssuesCubit cubit;

  setUp(() {
    repository = MockRepoIssuesRepository();
    cubit = RepoIssuesCubit(repoIssuesRepository: repository);
  });

  group('RepoIssuesCubit', () {
    const fullName = 'owner/repo';
    const perPage = 20;
    final issues = [const RepoIssue(id: 1, title: 'Issue 1')];

    blocTest<RepoIssuesCubit, RepoIssuesState>(
      'emits [loadingOpen, openIssuesFetched] when fetchOpenIssues succeeds',
      build: () {
        when(() => repository.getOpenIssues()).thenReturn([]);
        when(() => repository.getClosedIssues()).thenReturn([]);
        when(() => repository.getAllIssues()).thenReturn([]);
        when(
          () =>
              repository.fetchOpenIssues(fullName: fullName, perPage: perPage),
        ).thenAnswer(
          (_) async => PaginatedIssuesResult(issues: issues, hasMore: true),
        );
        return cubit;
      },
      act: (cubit) => cubit.fetchOpenIssues(fullName: fullName),
      expect: () => [isA<LoadingOpenIssues>(), isA<OpenIssuesFetched>()],
    );

    blocTest<RepoIssuesCubit, RepoIssuesState>(
      'emits [loadingClosed, closedIssuesFetched] when fetchClosedIssues '
      'succeeds',
      build: () {
        when(() => repository.getOpenIssues()).thenReturn([]);
        when(() => repository.getClosedIssues()).thenReturn([]);
        when(() => repository.getAllIssues()).thenReturn([]);
        when(
          () => repository.fetchClosedIssues(
            fullName: fullName,
            perPage: perPage,
          ),
        ).thenAnswer(
          (_) async => PaginatedIssuesResult(issues: issues, hasMore: true),
        );
        return cubit;
      },
      act: (cubit) => cubit.fetchClosedIssues(fullName: fullName),
      expect: () => [isA<LoadingClosedIssues>(), isA<ClosedIssuesFetched>()],
    );

    blocTest<RepoIssuesCubit, RepoIssuesState>(
      'emits [loadingAll, allIssuesFetched] when fetchAllIssues succeeds',
      build: () {
        when(() => repository.getOpenIssues()).thenReturn([]);
        when(() => repository.getClosedIssues()).thenReturn([]);
        when(() => repository.getAllIssues()).thenReturn([]);
        when(
          () => repository.fetchAllIssues(fullName: fullName, perPage: perPage),
        ).thenAnswer(
          (_) async => PaginatedIssuesResult(issues: issues, hasMore: true),
        );
        return cubit;
      },
      act: (cubit) => cubit.fetchAllIssues(fullName: fullName),
      expect: () => [isA<LoadingAllIssues>(), isA<AllIssuesFetched>()],
    );

    blocTest<RepoIssuesCubit, RepoIssuesState>(
      'emits [loadingOpen, error] when fetchOpenIssues fails',
      build: () {
        when(() => repository.getOpenIssues()).thenReturn([]);
        when(() => repository.getClosedIssues()).thenReturn([]);
        when(() => repository.getAllIssues()).thenReturn([]);
        when(
          () =>
              repository.fetchOpenIssues(fullName: fullName, perPage: perPage),
        ).thenThrow(Exception('Failed to fetch open issues'));
        return cubit;
      },
      act: (cubit) => cubit.fetchOpenIssues(fullName: fullName),
      expect: () => [isA<LoadingOpenIssues>(), isA<RepoIssuesError>()],
    );

    blocTest<RepoIssuesCubit, RepoIssuesState>(
      'emits [loadingClosed, error] when fetchClosedIssues fails',
      build: () {
        when(() => repository.getOpenIssues()).thenReturn([]);
        when(() => repository.getClosedIssues()).thenReturn([]);
        when(() => repository.getAllIssues()).thenReturn([]);
        when(
          () => repository.fetchClosedIssues(
            fullName: fullName,
            perPage: perPage,
          ),
        ).thenThrow(Exception('Failed to fetch closed issues'));
        return cubit;
      },
      act: (cubit) => cubit.fetchClosedIssues(fullName: fullName),
      expect: () => [isA<LoadingClosedIssues>(), isA<RepoIssuesError>()],
    );

    blocTest<RepoIssuesCubit, RepoIssuesState>(
      'emits [loadingAll, error] when fetchAllIssues fails',
      build: () {
        when(() => repository.getOpenIssues()).thenReturn([]);
        when(() => repository.getClosedIssues()).thenReturn([]);
        when(() => repository.getAllIssues()).thenReturn([]);
        when(
          () => repository.fetchAllIssues(fullName: fullName, perPage: perPage),
        ).thenThrow(Exception('Failed to fetch all issues'));
        return cubit;
      },
      act: (cubit) => cubit.fetchAllIssues(fullName: fullName),
      expect: () => [isA<LoadingAllIssues>(), isA<RepoIssuesError>()],
    );
  });
}
