import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:git_explorer/core/utils/json_converters.dart';

part 'repo_search_response.freezed.dart';
part 'repo_search_response.g.dart';

@freezed
abstract class RepoSearchResponse with _$RepoSearchResponse {
  const factory RepoSearchResponse({
    @JsonKey(name: 'total_count') int? totalCount,
    @JsonKey(name: 'incomplete_results') bool? incompleteResults,
    @JsonKey(name: 'items') List<RepoSearchResult>? items,
  }) = _RepoSearchResponse;

  factory RepoSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$RepoSearchResponseFromJson(json);
}

@freezed
abstract class RepoSearchResult with _$RepoSearchResult {
  const factory RepoSearchResult({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'node_id') String? nodeId,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'private') bool? private,
    @JsonKey(name: 'owner') Owner? owner,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'fork') bool? fork,
    @JsonKey(name: 'size') int? size,
    @JsonKey(name: 'stargazers_count') int? stargazersCount,
    @JsonKey(name: 'watchers_count') int? watchersCount,
    @JsonKey(name: 'language') String? language,
    @JsonKey(name: 'has_issues') bool? hasIssues,
    @JsonKey(name: 'has_projects') bool? hasProjects,
    @JsonKey(name: 'has_downloads') bool? hasDownloads,
    @JsonKey(name: 'has_wiki') bool? hasWiki,
    @JsonKey(name: 'has_pages') bool? hasPages,
    @JsonKey(name: 'has_discussions') bool? hasDiscussions,
    @JsonKey(name: 'forks_count') int? forksCount,
    @JsonKey(name: 'mirror_url') dynamic mirrorUrl,
    @JsonKey(name: 'archived') bool? archived,
    @JsonKey(name: 'disabled') bool? disabled,
    @JsonKey(name: 'open_issues_count') int? openIssuesCount,
    @JsonKey(name: 'license') dynamic license,
    @JsonKey(name: 'topics') List<String>? topics,
    @JsonKey(name: 'visibility') String? visibility,
    @JsonKey(name: 'forks') int? forks,
    @JsonKey(name: 'open_issues') int? openIssues,
    @JsonKey(name: 'watchers') int? watchers,
    @JsonKey(name: 'default_branch') String? defaultBranch,
    @JsonKey(name: 'score') int? score,
    @JsonKey(
      name: 'created_at',
      fromJson: JsonConverters.fromIso8601,
      toJson: JsonConverters.toIso8601,
    )
    DateTime? createdAt,
    @JsonKey(
      name: 'updated_at',
      fromJson: JsonConverters.fromIso8601,
      toJson: JsonConverters.toIso8601,
    )
    DateTime? updatedAt,
    @JsonKey(
      name: 'pushed_at',
      fromJson: JsonConverters.fromIso8601,
      toJson: JsonConverters.toIso8601,
    )
    DateTime? pushedAt,
  }) = _RepoSearchResult;

  factory RepoSearchResult.fromJson(Map<String, dynamic> json) =>
      _$RepoSearchResultFromJson(json);
}

@freezed
abstract class Owner with _$Owner {
  const factory Owner({
    @JsonKey(name: 'login') String? login,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'node_id') String? nodeId,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'gravatar_id') String? gravatarId,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'user_view_type') String? userViewType,
    @JsonKey(name: 'site_admin') bool? siteAdmin,
  }) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}
