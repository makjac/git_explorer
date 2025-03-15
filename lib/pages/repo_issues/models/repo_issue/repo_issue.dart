import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_issue.freezed.dart';
part 'repo_issue.g.dart';

@freezed
abstract class RepoIssue with _$RepoIssue {
  const factory RepoIssue({
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'node_id') String? nodeId,
    @JsonKey(name: 'number') int? number,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'user') User? user,
    @JsonKey(name: 'labels') List<dynamic>? labels,
    @JsonKey(name: 'state') String? state,
    @JsonKey(name: 'locked') bool? locked,
    @JsonKey(name: 'assignee') dynamic assignee,
    @JsonKey(name: 'assignees') List<dynamic>? assignees,
    @JsonKey(name: 'milestone') dynamic milestone,
    @JsonKey(name: 'comments') int? comments,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'closed_at') dynamic closedAt,
    @JsonKey(name: 'author_association') String? authorAssociation,
    @JsonKey(name: 'sub_issues_summary') SubIssuesSummary? subIssuesSummary,
    @JsonKey(name: 'active_lock_reason') dynamic activeLockReason,
    @JsonKey(name: 'body') String? body,
    @JsonKey(name: 'closed_by') dynamic closedBy,
    @JsonKey(name: 'reactions') Reactions? reactions,
    @JsonKey(name: 'timeline_url') String? timelineUrl,
    @JsonKey(name: 'performed_via_github_app') dynamic performedViaGithubApp,
    @JsonKey(name: 'state_reason') dynamic stateReason,
  }) = _RepoIssue;

  factory RepoIssue.fromJson(Map<String, dynamic> json) =>
      _$RepoIssueFromJson(json);
}

@freezed
abstract class Reactions with _$Reactions {
  const factory Reactions({
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'total_count') int? totalCount,
    @JsonKey(name: '+1') int? the1,
    @JsonKey(name: '-1') int? reactions1,
    @JsonKey(name: 'laugh') int? laugh,
    @JsonKey(name: 'hooray') int? hooray,
    @JsonKey(name: 'confused') int? confused,
    @JsonKey(name: 'heart') int? heart,
    @JsonKey(name: 'rocket') int? rocket,
    @JsonKey(name: 'eyes') int? eyes,
  }) = _Reactions;

  factory Reactions.fromJson(Map<String, dynamic> json) =>
      _$ReactionsFromJson(json);
}

@freezed
abstract class SubIssuesSummary with _$SubIssuesSummary {
  const factory SubIssuesSummary({
    @JsonKey(name: 'total') int? total,
    @JsonKey(name: 'completed') int? completed,
    @JsonKey(name: 'percent_completed') int? percentCompleted,
  }) = _SubIssuesSummary;

  factory SubIssuesSummary.fromJson(Map<String, dynamic> json) =>
      _$SubIssuesSummaryFromJson(json);
}

@freezed
abstract class User with _$User {
  const factory User({
    @JsonKey(name: 'login') String? login,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'node_id') String? nodeId,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'gravatar_id') String? gravatarId,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'html_url') String? htmlUrl,
    @JsonKey(name: 'followers_url') String? followersUrl,
    @JsonKey(name: 'following_url') String? followingUrl,
    @JsonKey(name: 'gists_url') String? gistsUrl,
    @JsonKey(name: 'starred_url') String? starredUrl,
    @JsonKey(name: 'subscriptions_url') String? subscriptionsUrl,
    @JsonKey(name: 'organizations_url') String? organizationsUrl,
    @JsonKey(name: 'repos_url') String? reposUrl,
    @JsonKey(name: 'events_url') String? eventsUrl,
    @JsonKey(name: 'received_events_url') String? receivedEventsUrl,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'user_view_type') String? userViewType,
    @JsonKey(name: 'site_admin') bool? siteAdmin,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
