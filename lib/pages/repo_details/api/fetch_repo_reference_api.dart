import 'package:dio/dio.dart';
import 'package:git_explorer/core/api/api_path_builder_mixin.dart';
import 'package:git_explorer/pages/repo_details/models/repo_reference/repo_reference.dart';

abstract class FetchRepoReferenceApi {
  Future<RepoReference?> call({
    required String fullName,
    required String defaultBranch,
  });
}

class FetchRepoReferenceApiImpl
    with ApiPathBuilderMixin
    implements FetchRepoReferenceApi {
  FetchRepoReferenceApiImpl({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<RepoReference?> call({
    required String fullName,
    required String defaultBranch,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      fetchRepoReference(fullName, defaultBranch),
    );

    if (response.statusCode == 200 || response.statusCode == 304) {
      return RepoReference.fromJson(response.data ?? {});
    }

    return null;
  }
}
