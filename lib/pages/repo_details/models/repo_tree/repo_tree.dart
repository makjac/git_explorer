import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_tree.freezed.dart';
part 'repo_tree.g.dart';

@freezed
abstract class RepoTreeResponse with _$RepoTreeResponse {
  const factory RepoTreeResponse({
    @JsonKey(name: 'sha') String? sha,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'tree') List<RepoTreeElement>? tree,
    @JsonKey(name: 'truncated') bool? truncated,
  }) = _RepoTreeResponse;

  factory RepoTreeResponse.fromJson(Map<String, dynamic> json) =>
      _$RepoTreeResponseFromJson(json);
}

@freezed
abstract class RepoTreeElement with _$RepoTreeElement {
  const factory RepoTreeElement({
    @JsonKey(name: 'path') String? path,
    @JsonKey(name: 'mode') String? mode,
    @JsonKey(name: 'type') Type? type,
    @JsonKey(name: 'sha') String? sha,
    @JsonKey(name: 'size') int? size,
    @JsonKey(name: 'url') String? url,
  }) = _RepoTreeElement;

  factory RepoTreeElement.fromJson(Map<String, dynamic> json) =>
      _$RepoTreeElementFromJson(json);
}

enum Type {
  @JsonValue('blob')
  blob,
  @JsonValue('tree')
  tree,
  @JsonValue('commit')
  commit,
}

final typeValues = EnumValues({
  'blob': Type.blob,
  'tree': Type.tree,
  'commit': Type.commit,
});

class EnumValues<T> {
  EnumValues(this.map);

  Map<String, T> map;
  late Map<T, String> reverseMap;

  Map<T, String> get reverse {
    return map.map((k, v) => MapEntry(v, k));
  }
}
