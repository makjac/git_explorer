import 'package:dio/dio.dart';
import 'package:git_explorer/core/api/api_path_builder_mixin.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue/repo_issue.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue_type/repo_issue_type.dart';

abstract class FetchRepoIssuesApi {
  Future<List<RepoIssue>?> call({
    required String fullName,
    required int page,
    int perPage,
    IssueStateType type,
    CancelToken? cancelToken,
  });
}

class FetchRepoIssuesApiImpl
    with ApiPathBuilderMixin
    implements FetchRepoIssuesApi {
  FetchRepoIssuesApiImpl({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<List<RepoIssue>?> call({
    required String fullName,
    required int page,
    int perPage = 20,
    IssueStateType type = IssueStateType.open,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      fetchRepoIssues(fullName, page: page, perPage: perPage, type: type),
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      return (response.data ?? [])
          .map((e) => RepoIssue.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return null;
  }
}
