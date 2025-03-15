import 'package:dio/dio.dart';
import 'package:git_explorer/core/api/api_path_builder_mixin.dart';
import 'package:git_explorer/pages/repo_details/models/repo_tree/repo_tree.dart';

abstract class FetchRepoTreeApi {
  Future<RepoTreeResponse?> call({
    required String fullName,
    required String sha,
  });
}

class FetchRepoTreeApiImpl
    with ApiPathBuilderMixin
    implements FetchRepoTreeApi {
  FetchRepoTreeApiImpl({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<RepoTreeResponse?> call({
    required String fullName,
    required String sha,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      fetchRepoTree(fullName, sha),
    );

    if (response.statusCode == 200 || response.statusCode == 304) {
      return RepoTreeResponse.fromJson(response.data ?? {});
    }

    return null;
  }
}
