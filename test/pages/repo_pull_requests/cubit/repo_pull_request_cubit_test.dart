import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/repo_pull_requests/cubit/repo_pull_request_cubit.dart';
import 'package:git_explorer/pages/repo_pull_requests/models/repo_pull_request.dart';
import 'package:git_explorer/pages/repo_pull_requests/repository/repo_pull_request_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRepoPullRequestRepository extends Mock
    implements RepoPullRequestRepository {}

void main() {
  late RepoPullRequestCubit cubit;
  late MockRepoPullRequestRepository mockRepository;

  setUp(() {
    mockRepository = MockRepoPullRequestRepository();
    cubit = RepoPullRequestCubit(repository: mockRepository);
  });

  group('RepoPullRequestCubit', () {
    const fullName = 'owner/repo';
    final pullRequests = [
      const RepoPullRequest(id: 1, title: 'PR 1'),
      const RepoPullRequest(id: 2, title: 'PR 2'),
    ];

    blocTest<RepoPullRequestCubit, RepoPullRequestState>(
      'emits [loading, reposFetched] when fetchPullRequests is successful',
      build: () {
        when(
          () => mockRepository.fetchPullRequests(fullName),
        ).thenAnswer((_) async => pullRequests);
        return cubit;
      },
      act: (cubit) => cubit.fetchPullRequests(fullName),
      expect:
          () => [
            const RepoPullRequestState.loading(),
            RepoPullRequestState.reposFetched(repos: pullRequests),
          ],
    );

    blocTest<RepoPullRequestCubit, RepoPullRequestState>(
      'emits [loading, error] when fetchPullRequests fails',
      build: () {
        when(
          () => mockRepository.fetchPullRequests(fullName),
        ).thenThrow(Exception('error'));
        return cubit;
      },
      act: (cubit) => cubit.fetchPullRequests(fullName),
      expect:
          () => [
            const RepoPullRequestState.loading(),
            const RepoPullRequestState.error(
              errorMessage: 'An error occurred: Exception: error',
            ),
          ],
    );
  });
}
