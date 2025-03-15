enum IssueStateType { open, closed, all }

extension RepoIssueStateX on IssueStateType {
  String get value => switch (this) {
    IssueStateType.open => 'open',
    IssueStateType.closed => 'closed',
    IssueStateType.all => 'all',
  };
}
