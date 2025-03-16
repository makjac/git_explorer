import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/repo_details/cubit/repo_details_cubit.dart';
import 'package:git_explorer/pages/repo_details/models/repo_details/repo_details.dart';
import 'package:git_explorer/pages/repo_details/models/repo_reference/repo_reference.dart';
import 'package:git_explorer/pages/repo_details/models/repo_tree/repo_tree.dart';
import 'package:git_explorer/pages/repo_details/repository/repo_details_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRepoDetailsRepository extends Mock implements RepoDetailsRepository {}

void main() {
  late RepoDetailsRepository repository;
  late RepoDetailsCubit cubit;

  setUp(() {
    repository = MockRepoDetailsRepository();
    cubit = RepoDetailsCubit(repository: repository);
  });

  group('RepoDetailsCubit', () {
    const fullName = 'owner/repo';

    const repoDetails = RepoDetails(
      name: 'repo',
      fullName: fullName,
      defaultBranch: 'main',
    );

    const repoReference = RepoReference(object: CommitPointer(sha: 'sha123'));

    final treeElements = [const RepoTreeElement(path: 'path', type: Type.blob)];

    blocTest<RepoDetailsCubit, RepoDetailsState>(
      'emits [loading, detailsFetched, allDataFetched] when loadRepositoryData '
      'succeeds',
      build: () {
        when(
          () => repository.fetchRepoDetails(fullName),
        ).thenAnswer((_) async => repoDetails);
        when(
          () => repository.fetchRepoReference(fullName, 'main'),
        ).thenAnswer((_) async => repoReference);
        when(
          () => repository.fetchRepoTree(fullName, 'sha123'),
        ).thenAnswer((_) async => treeElements);
        return cubit;
      },
      act: (cubit) => cubit.loadRepositoryData(fullName),
      expect:
          () => [
            const RepoDetailsState.loading(),
            const RepoDetailsState.detailsFetched(repoDetails: repoDetails),
            const RepoDetailsState.detailsFetched(
              repoDetails: repoDetails,
              repoReference: repoReference,
            ),
            RepoDetailsState.allDataFetched(
              repoDetails: repoDetails,
              repoReference: repoReference,
              treeElements: treeElements,
            ),
          ],
    );

    blocTest<RepoDetailsCubit, RepoDetailsState>(
      'emits [loading, error] when fetchRepoDetails returns null',
      build: () {
        when(
          () => repository.fetchRepoDetails(fullName),
        ).thenAnswer((_) async => null);
        return cubit;
      },
      act: (cubit) => cubit.loadRepositoryData(fullName),
      expect:
          () => [
            const RepoDetailsState.loading(),
            const RepoDetailsState.error(
              errorMessage: 'Unable to fetch repo details',
            ),
          ],
    );

    blocTest<RepoDetailsCubit, RepoDetailsState>(
      'emits [loading, detailsFetched, error] when repoDetails has no default '
      'branch',
      build: () {
        final repoDetailsNoBranch = repoDetails.copyWith(defaultBranch: '');
        when(
          () => repository.fetchRepoDetails(fullName),
        ).thenAnswer((_) async => repoDetailsNoBranch);
        return cubit;
      },
      act: (cubit) => cubit.loadRepositoryData(fullName),
      expect:
          () => [
            const RepoDetailsState.loading(),
            RepoDetailsState.detailsFetched(
              repoDetails: repoDetails.copyWith(defaultBranch: ''),
            ),
            RepoDetailsState.error(
              errorMessage: 'Repository has no default branch specified',
              repoDetails: repoDetails.copyWith(defaultBranch: ''),
            ),
          ],
    );

    blocTest<RepoDetailsCubit, RepoDetailsState>(
      'emits [loading, detailsFetched, error] when fetchRepoReference returns '
      'null',
      build: () {
        when(
          () => repository.fetchRepoDetails(fullName),
        ).thenAnswer((_) async => repoDetails);
        when(
          () => repository.fetchRepoReference(fullName, 'main'),
        ).thenAnswer((_) async => null);
        return cubit;
      },
      act: (cubit) => cubit.loadRepositoryData(fullName),
      expect:
          () => [
            const RepoDetailsState.loading(),
            const RepoDetailsState.detailsFetched(repoDetails: repoDetails),
            const RepoDetailsState.error(
              errorMessage: 'Unable to fetch repo reference',
              repoDetails: repoDetails,
            ),
          ],
    );

    blocTest<RepoDetailsCubit, RepoDetailsState>(
      'emits [loading, detailsFetched, error] when repoReference has no SHA',
      build: () {
        const repoReferenceNoSha = RepoReference(
          object: CommitPointer(sha: ''),
        );

        when(
          () => repository.fetchRepoDetails(fullName),
        ).thenAnswer((_) async => repoDetails);
        when(
          () => repository.fetchRepoReference(fullName, 'main'),
        ).thenAnswer((_) async => repoReferenceNoSha);
        return cubit;
      },
      act: (cubit) => cubit.loadRepositoryData(fullName),
      expect:
          () => [
            const RepoDetailsState.loading(),
            const RepoDetailsState.detailsFetched(repoDetails: repoDetails),
            RepoDetailsState.detailsFetched(
              repoDetails: repoDetails,
              repoReference: repoReference.copyWith(
                object: const CommitPointer(sha: ''),
              ),
            ),
            RepoDetailsState.error(
              errorMessage: 'Repository reference contains no SHA',
              repoDetails: repoDetails,
              repoReference: repoReference.copyWith(
                object: const CommitPointer(sha: ''),
              ),
            ),
          ],
    );

    blocTest<RepoDetailsCubit, RepoDetailsState>(
      'emits [loading, detailsFetched, detailsFetched, error] when '
      'fetchRepoTree returns null',
      build: () {
        when(
          () => repository.fetchRepoDetails(fullName),
        ).thenAnswer((_) async => repoDetails);
        when(
          () => repository.fetchRepoReference(fullName, 'main'),
        ).thenAnswer((_) async => repoReference);
        when(
          () => repository.fetchRepoTree(fullName, 'sha123'),
        ).thenAnswer((_) async => null);
        return cubit;
      },
      act: (cubit) => cubit.loadRepositoryData(fullName),
      expect:
          () => [
            const RepoDetailsState.loading(),
            const RepoDetailsState.detailsFetched(repoDetails: repoDetails),
            const RepoDetailsState.detailsFetched(
              repoDetails: repoDetails,
              repoReference: repoReference,
            ),
            const RepoDetailsState.error(
              errorMessage: 'Unable to fetch repo tree',
              repoDetails: repoDetails,
              repoReference: repoReference,
            ),
          ],
    );

    blocTest<RepoDetailsCubit, RepoDetailsState>(
      'emits [loading, error] when an exception is thrown',
      build: () {
        when(
          () => repository.fetchRepoDetails(fullName),
        ).thenThrow(Exception('error'));
        return cubit;
      },
      act: (cubit) => cubit.loadRepositoryData(fullName),
      expect:
          () => [
            const RepoDetailsState.loading(),
            const RepoDetailsState.error(
              errorMessage: 'An error occurred while fetching repository data',
            ),
          ],
    );
  });
}
