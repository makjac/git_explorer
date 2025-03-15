import 'package:dio/dio.dart';
import 'package:git_explorer/core/api/api_path_builder_mixin.dart';
import 'package:git_explorer/pages/repo_details/models/repo_details/repo_details.dart';

abstract class FetchRepoDetailsApi {
  Future<RepoDetails?> call({required String fullName});
}

class FetchRepoDetailsApiImpl
    with ApiPathBuilderMixin
    implements FetchRepoDetailsApi {
  FetchRepoDetailsApiImpl({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<RepoDetails?> call({required String fullName}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      fetchRepoDetails(fullName),
    );

    if (response.statusCode == 200 || response.statusCode == 304) {
      return RepoDetails.fromJson(response.data ?? {});
    }

    return null;
  }
}
