part of 'search_repo_cubit.dart';

@freezed
sealed class SearchRepoState with _$SearchRepoState {
  const factory SearchRepoState.initial({
    @Default([]) List<RepoSearchResult> repos,
  }) = SearchRepoInitial;

  const factory SearchRepoState.loading({
    @Default([]) List<RepoSearchResult> repos,
  }) = SearchRepoLoading;

  const factory SearchRepoState.reposFetched({
    @Default([]) List<RepoSearchResult> repos,
  }) = SearchRepoReposFetched;

  const factory SearchRepoState.error({
    @Default([]) List<RepoSearchResult> repos,
    String? errorMessage,
  }) = SearchRepoError;
}
