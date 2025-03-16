part of 'repo_pull_request_cubit.dart';

@freezed
sealed class RepoPullRequestState with _$RepoPullRequestState {
  const factory RepoPullRequestState.initial() = RepoPullRequestInitial;

  const factory RepoPullRequestState.loading({
    @Default([]) List<RepoPullRequest> repos,
  }) = RepoPullRequestLoading;

  const factory RepoPullRequestState.reposFetched({
    @Default([]) List<RepoPullRequest> repos,
  }) = RepoPullRequestFetched;

  const factory RepoPullRequestState.error({
    @Default([]) List<RepoPullRequest> repos,
    String? errorMessage,
  }) = RepoPullRequestError;
}
