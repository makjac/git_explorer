import 'package:dio/dio.dart';
import 'package:git_explorer/core/api/api_path_builder_mixin.dart';
import 'package:git_explorer/pages/repo_pull_requests/models/repo_pull_request.dart';

abstract class FetchRepoPullRequestApi {
  Future<List<RepoPullRequest>?> call({
    required String fullName,
    required int page,
    int perPage,
  });
}

class FetchRepoPullRequestApiImpl
    with ApiPathBuilderMixin
    implements FetchRepoPullRequestApi {
  FetchRepoPullRequestApiImpl({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<List<RepoPullRequest>?> call({
    required String fullName,
    required int page,
    int perPage = 20,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      fetchRepoPullRequest(fullName, page: page, perPage: perPage),
    );

    if (response.statusCode == 200) {
      return (response.data ?? [])
          .map((e) => RepoPullRequest.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return null;
  }
}
