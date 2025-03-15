part of 'repo_issues_cubit.dart';

@freezed
sealed class RepoIssuesState with _$RepoIssuesState {
  const factory RepoIssuesState.initial() = RepoIssuesInitial;

  @With<RepoIssuesWithData>()
  @With<RepoIssuesFetching>()
  const factory RepoIssuesState.loadingOpen({
    @Default([]) List<RepoIssue> openIssues,
    @Default([]) List<RepoIssue> closedIssues,
    @Default([]) List<RepoIssue> allIssues,
  }) = LoadingOpenIssues;

  @With<RepoIssuesWithData>()
  @With<RepoIssuesFetching>()
  const factory RepoIssuesState.loadingClosed({
    @Default([]) List<RepoIssue> openIssues,
    @Default([]) List<RepoIssue> closedIssues,
    @Default([]) List<RepoIssue> allIssues,
  }) = LoadingClosedIssues;

  @With<RepoIssuesWithData>()
  @With<RepoIssuesFetching>()
  const factory RepoIssuesState.loadingAll({
    @Default([]) List<RepoIssue> openIssues,
    @Default([]) List<RepoIssue> closedIssues,
    @Default([]) List<RepoIssue> allIssues,
  }) = LoadingAllIssues;

  @With<RepoIssuesWithData>()
  const factory RepoIssuesState.openIssuesFetched({
    @Default([]) List<RepoIssue> openIssues,
    @Default([]) List<RepoIssue> closedIssues,
    @Default([]) List<RepoIssue> allIssues,
  }) = OpenIssuesFetched;

  @With<RepoIssuesWithData>()
  const factory RepoIssuesState.closedIssuesFetched({
    @Default([]) List<RepoIssue> openIssues,
    @Default([]) List<RepoIssue> closedIssues,
    @Default([]) List<RepoIssue> allIssues,
  }) = ClosedIssuesFetched;

  @With<RepoIssuesWithData>()
  const factory RepoIssuesState.allIssuesFetched({
    @Default([]) List<RepoIssue> openIssues,
    @Default([]) List<RepoIssue> closedIssues,
    @Default([]) List<RepoIssue> allIssues,
  }) = AllIssuesFetched;

  @With<RepoIssuesWithData>()
  const factory RepoIssuesState.error({
    @Default('An error occurred') String message,
    @Default([]) List<RepoIssue> openIssues,
    @Default([]) List<RepoIssue> closedIssues,
    @Default([]) List<RepoIssue> allIssues,
  }) = RepoIssuesError;
}

mixin RepoIssuesWithData {
  List<RepoIssue> get openIssues;
  List<RepoIssue> get closedIssues;
  List<RepoIssue> get allIssues;
}

mixin RepoIssuesFetching {}
