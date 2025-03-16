import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/pages/home/cubit/search_repo_cubit.dart';
import 'package:git_explorer/pages/home/models/repo_search_response.dart';
import 'package:git_explorer/pages/home/repository/repo_search_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRepoSearchRepository extends Mock implements RepoSearchRepository {}

void main() {
  late SearchRepoCubit searchRepoCubit;
  late MockRepoSearchRepository mockRepoSearchRepository;

  setUp(() {
    mockRepoSearchRepository = MockRepoSearchRepository();
    searchRepoCubit = SearchRepoCubit(
      repoSearchRepository: mockRepoSearchRepository,
    );
  });

  tearDown(() {
    searchRepoCubit.close();
  });

  group('SearchRepoCubit', () {
    test('initial state is SearchRepoState.initial', () {
      expect(searchRepoCubit.state, const SearchRepoState.initial());
    });

    blocTest<SearchRepoCubit, SearchRepoState>(
      'emits [loading, reposFetched] when searchRepos is called with a '
      'non-empty query',
      build: () {
        when(
          () => mockRepoSearchRepository.searchRepositories(any()),
        ).thenAnswer((_) async => [const RepoSearchResult()]);
        return searchRepoCubit;
      },
      act: (cubit) => cubit.searchRepos('flutter'),
      wait: const Duration(milliseconds: 1000),
      expect:
          () => [
            const SearchRepoState.loading(),
            const SearchRepoState.reposFetched(repos: [RepoSearchResult()]),
          ],
    );

    blocTest<SearchRepoCubit, SearchRepoState>(
      'emits [initial] when searchRepos is called with an empty query',
      build: () => searchRepoCubit,
      act: (cubit) => cubit.searchRepos(''),
      expect: () => [const SearchRepoState.initial()],
    );

    blocTest<SearchRepoCubit, SearchRepoState>(
      'emits [loading, error] when searchRepos fails',
      build: () {
        when(
          () => mockRepoSearchRepository.searchRepositories(any()),
        ).thenThrow(Exception('error'));
        return searchRepoCubit;
      },
      act: (cubit) => cubit.searchRepos('flutter'),
      wait: const Duration(milliseconds: 1000),
      expect:
          () => [
            const SearchRepoState.loading(),
            const SearchRepoState.error(
              errorMessage: 'Error searching repositories',
            ),
          ],
    );

    blocTest<SearchRepoCubit, SearchRepoState>(
      'emits [initial] when clear is called',
      build: () => searchRepoCubit,
      act: (cubit) => cubit.clear(),
      expect: () => [const SearchRepoState.initial()],
    );
  });
}
