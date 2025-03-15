import 'package:dio/dio.dart';
import 'package:git_explorer/core/api/api_path_builder_mixin.dart';
import 'package:git_explorer/pages/home/models/repo_search_response.dart';

abstract class SearchRepoApi {
  Future<RepoSearchResponse?> call({
    required String query,
    required int page,
    int perPage,
    CancelToken? cancelToken,
  });
}

class SearchRepoApiImpl with ApiPathBuilderMixin implements SearchRepoApi {
  SearchRepoApiImpl({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<RepoSearchResponse?> call({
    required String query,
    required int page,
    int perPage = 20,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      searchRepo(query, page: page, perPage: perPage),
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      return RepoSearchResponse.fromJson(response.data ?? {});
    }

    return null;
  }
}
