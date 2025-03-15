import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_reference.freezed.dart';
part 'repo_reference.g.dart';

@freezed
abstract class RepoReference with _$RepoReference {
  const factory RepoReference({
    @JsonKey(name: 'ref') String? ref,
    @JsonKey(name: 'node_id') String? nodeId,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'object') CommitPointer? object,
  }) = _RepoReference;

  factory RepoReference.fromJson(Map<String, dynamic> json) =>
      _$RepoReferenceFromJson(json);
}

@freezed
abstract class CommitPointer with _$CommitPointer {
  const factory CommitPointer({
    @JsonKey(name: 'sha') String? sha,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'url') String? url,
  }) = _CommitPointer;

  factory CommitPointer.fromJson(Map<String, dynamic> json) =>
      _$CommitPointerFromJson(json);
}
