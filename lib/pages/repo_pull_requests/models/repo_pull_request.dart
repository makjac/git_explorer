import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_pull_request.freezed.dart';
part 'repo_pull_request.g.dart';

@freezed
abstract class RepoPullRequest with _$RepoPullRequest {
  const factory RepoPullRequest({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'number') int? number,
    @JsonKey(name: 'state') String? state,
    @JsonKey(name: 'locked') bool? locked,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'body') String? body,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'closed_at') DateTime? closedAt,
    @JsonKey(name: 'merged_at') DateTime? mergedAt,
    @JsonKey(name: 'merge_commit_sha') String? mergeCommitSha,
    @JsonKey(name: 'author_association') String? authorAssociation,
    @JsonKey(name: 'draft') bool? draft,
  }) = _RepoPullRequest;

  factory RepoPullRequest.fromJson(Map<String, dynamic> json) =>
      _$RepoPullRequestFromJson(json);
}
