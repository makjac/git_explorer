part of 'repo_details_cubit.dart';

@freezed
sealed class RepoDetailsState with _$RepoDetailsState {
  const factory RepoDetailsState.initial() = RepoDetailsInitial;

  const factory RepoDetailsState.loading() = RepoDetailsLoading;

  @With<RepoDetailsWithData>()
  const factory RepoDetailsState.detailsFetched({
    required RepoDetails repoDetails,
    RepoReference? repoReference,
    List<RepoTreeElement>? treeElements,
  }) = RepoDetailsFetched;

  @With<RepoDetailsWithData>()
  const factory RepoDetailsState.allDataFetched({
    required RepoDetails repoDetails,
    required RepoReference repoReference,
    required List<RepoTreeElement> treeElements,
  }) = RepoDetailsAllDataFetched;

  @With<RepoDetailsWithData>()
  const factory RepoDetailsState.error({
    String? errorMessage,
    RepoDetails? repoDetails,
    RepoReference? repoReference,
    List<RepoTreeElement>? treeElements,
  }) = RepoDetailsError;
}

mixin RepoDetailsWithData {
  RepoDetails? get repoDetails;
  RepoReference? get repoReference;
  List<RepoTreeElement>? get treeElements;
}
