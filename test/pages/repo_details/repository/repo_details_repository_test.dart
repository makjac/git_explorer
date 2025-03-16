import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_details_api.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_reference_api.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_tree_api.dart';
import 'package:git_explorer/pages/repo_details/models/repo_details/repo_details.dart';
import 'package:git_explorer/pages/repo_details/models/repo_reference/repo_reference.dart';
import 'package:git_explorer/pages/repo_details/models/repo_tree/repo_tree.dart';
import 'package:git_explorer/pages/repo_details/repository/repo_details_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'repo_details_repository_test.mocks.dart';

@GenerateMocks([FetchRepoDetailsApi, FetchRepoReferenceApi, FetchRepoTreeApi])
void main() {
  late RepoDetailsRepositoryImpl repository;
  late MockFetchRepoDetailsApi mockFetchRepoDetailsApi;
  late MockFetchRepoReferenceApi mockFetchRepoReferenceApi;
  late MockFetchRepoTreeApi mockFetchRepoTreeApi;

  setUp(() {
    mockFetchRepoDetailsApi = MockFetchRepoDetailsApi();
    mockFetchRepoReferenceApi = MockFetchRepoReferenceApi();
    mockFetchRepoTreeApi = MockFetchRepoTreeApi();
    repository = RepoDetailsRepositoryImpl(
      fetchRepoDetailsApi: mockFetchRepoDetailsApi,
      fetchRepoReferenceApi: mockFetchRepoReferenceApi,
      fetchRepoTreeApi: mockFetchRepoTreeApi,
    );
  });

  group('fetchRepoDetails', () {
    const fullName = 'owner/repo';

    test('should return RepoDetails when the call is successful', () async {
      const repoDetails = RepoDetails();
      when(
        mockFetchRepoDetailsApi.call(fullName: fullName),
      ).thenAnswer((_) async => repoDetails);

      final result = await repository.fetchRepoDetails(fullName);

      expect(result, repoDetails);
      verify(mockFetchRepoDetailsApi.call(fullName: fullName)).called(1);
    });

    test(
      'should return null and log error when the call throws an exception',
      () async {
        when(
          mockFetchRepoDetailsApi.call(fullName: fullName),
        ).thenThrow(Exception('Error'));

        final result = await repository.fetchRepoDetails(fullName);

        expect(result, null);
        verify(mockFetchRepoDetailsApi.call(fullName: fullName)).called(1);
      },
    );
  });

  group('fetchRepoReference', () {
    const fullName = 'owner/repo';
    const defaultBranch = 'main';

    test('should return RepoReference when the call is successful', () async {
      const repoReference = RepoReference();
      when(
        mockFetchRepoReferenceApi.call(
          fullName: fullName,
          defaultBranch: defaultBranch,
        ),
      ).thenAnswer((_) async => repoReference);

      final result = await repository.fetchRepoReference(
        fullName,
        defaultBranch,
      );

      expect(result, repoReference);
      verify(
        mockFetchRepoReferenceApi.call(
          fullName: fullName,
          defaultBranch: defaultBranch,
        ),
      ).called(1);
    });

    test('should return null when defaultBranch is empty', () async {
      final result = await repository.fetchRepoReference(fullName, '');

      expect(result, null);
      verifyNever(
        mockFetchRepoReferenceApi.call(fullName: fullName, defaultBranch: ''),
      );
    });

    test(
      'should return null and log error when the call throws an exception',
      () async {
        when(
          mockFetchRepoReferenceApi.call(
            fullName: fullName,
            defaultBranch: defaultBranch,
          ),
        ).thenThrow(Exception('Error'));

        final result = await repository.fetchRepoReference(
          fullName,
          defaultBranch,
        );

        expect(result, null);
        verify(
          mockFetchRepoReferenceApi.call(
            fullName: fullName,
            defaultBranch: defaultBranch,
          ),
        ).called(1);
      },
    );
  });

  group('fetchRepoTree', () {
    const fullName = 'owner/repo';
    const sha = 'abc123';

    test('should return sorted list of RepoTreeElement when the call is '
        'successful', () async {
      const repoTreeElement1 = RepoTreeElement(type: Type.tree);
      const repoTreeElement2 = RepoTreeElement(type: Type.blob);
      const repoTreeElement3 = RepoTreeElement(type: Type.commit);
      const repoTree = RepoTreeResponse(
        tree: [repoTreeElement2, repoTreeElement1, repoTreeElement3],
      );
      when(
        mockFetchRepoTreeApi.call(fullName: fullName, sha: sha),
      ).thenAnswer((_) async => repoTree);

      final result = await repository.fetchRepoTree(fullName, sha);

      expect(result, [repoTreeElement1, repoTreeElement3, repoTreeElement2]);
      verify(mockFetchRepoTreeApi.call(fullName: fullName, sha: sha)).called(1);
    });

    test('should return null when sha is empty', () async {
      final result = await repository.fetchRepoTree(fullName, '');

      expect(result, null);
      verifyNever(mockFetchRepoTreeApi.call(fullName: fullName, sha: ''));
    });

    test(
      'should return null and log error when the call throws an exception',
      () async {
        when(
          mockFetchRepoTreeApi.call(fullName: fullName, sha: sha),
        ).thenThrow(Exception('Error'));

        final result = await repository.fetchRepoTree(fullName, sha);

        expect(result, null);
        verify(
          mockFetchRepoTreeApi.call(fullName: fullName, sha: sha),
        ).called(1);
      },
    );
  });
}
