import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_details.freezed.dart';
part 'repo_details.g.dart';

@freezed
abstract class RepoDetails with _$RepoDetails {
  const factory RepoDetails({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'node_id') String? nodeId,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'private') bool? private,
    @JsonKey(name: 'owner') Owner? owner,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'fork') bool? fork,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'pushed_at') DateTime? pushedAt,
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
    @JsonKey(name: 'license') License? license,
    @JsonKey(name: 'allow_forking') bool? allowForking,
    @JsonKey(name: 'is_template') bool? isTemplate,
    @JsonKey(name: 'web_commit_signoff_required')
    bool? webCommitSignoffRequired,
    @JsonKey(name: 'topics') List<String>? topics,
    @JsonKey(name: 'visibility') String? visibility,
    @JsonKey(name: 'forks') int? forks,
    @JsonKey(name: 'open_issues') int? openIssues,
    @JsonKey(name: 'watchers') int? watchers,
    @JsonKey(name: 'default_branch') String? defaultBranch,
    @JsonKey(name: 'temp_clone_token') dynamic tempCloneToken,
    @JsonKey(name: 'network_count') int? networkCount,
    @JsonKey(name: 'subscribers_count') int? subscribersCount,
  }) = _RepoDetails;

  factory RepoDetails.fromJson(Map<String, dynamic> json) =>
      _$RepoDetailsFromJson(json);
}

@freezed
abstract class License with _$License {
  const factory License({
    @JsonKey(name: 'key') String? key,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'spdx_id') String? spdxId,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'node_id') String? nodeId,
  }) = _License;

  factory License.fromJson(Map<String, dynamic> json) =>
      _$LicenseFromJson(json);
}

@freezed
abstract class Owner with _$Owner {
  const factory Owner({
    @JsonKey(name: 'login') String? login,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'node_id') String? nodeId,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'gravatar_id') String? gravatarId,
    @JsonKey(name: 'type') OwnerType? type,
    @JsonKey(name: 'user_view_type') String? userViewType,
    @JsonKey(name: 'site_admin') bool? siteAdmin,
  }) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}

enum OwnerType {
  @JsonValue('User')
  user,
  @JsonValue('Organization')
  organization,
}

final ownerTypeValues = EnumValues({
  'User': OwnerType.user,
  'Organization': OwnerType.organization,
});

class EnumValues<T> {
  EnumValues(this.map);

  Map<String, T> map;
  late Map<T, String> reverseMap;

  Map<T, String> get reverse {
    return map.map((k, v) => MapEntry(v, k));
  }
}
