import 'package:git_explorer/core/utils/logger.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_details_api.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_reference_api.dart';
import 'package:git_explorer/pages/repo_details/api/fetch_repo_tree_api.dart';
import 'package:git_explorer/pages/repo_details/models/repo_details/repo_details.dart';
import 'package:git_explorer/pages/repo_details/models/repo_reference/repo_reference.dart';
import 'package:git_explorer/pages/repo_details/models/repo_tree/repo_tree.dart';

abstract class RepoDetailsRepository {
  Future<RepoDetails?> fetchRepoDetails(String fullName);
  Future<RepoReference?> fetchRepoReference(
    String fullName,
    String defaultBranch,
  );
  Future<List<RepoTreeElement>?> fetchRepoTree(String fullName, String sha);
}

class RepoDetailsRepositoryImpl implements RepoDetailsRepository {
  RepoDetailsRepositoryImpl({
    FetchRepoDetailsApi? fetchRepoDetailsApi,
    FetchRepoReferenceApi? fetchRepoReferenceApi,
    FetchRepoTreeApi? fetchRepoTreeApi,
  }) : _fetchRepoDetailsApi = fetchRepoDetailsApi ?? FetchRepoDetailsApiImpl(),
       _fetchRepoReferenceApi =
           fetchRepoReferenceApi ?? FetchRepoReferenceApiImpl(),
       _fetchRepoTreeApi = fetchRepoTreeApi ?? FetchRepoTreeApiImpl();

  final FetchRepoDetailsApi _fetchRepoDetailsApi;
  final FetchRepoReferenceApi _fetchRepoReferenceApi;
  final FetchRepoTreeApi _fetchRepoTreeApi;

  @override
  Future<RepoDetails?> fetchRepoDetails(String fullName) async {
    try {
      return await _fetchRepoDetailsApi.call(fullName: fullName);
    } catch (e) {
      Logger.showLog(
        'Error fetching repo details: $e',
        'RepoDetailsRepository',
      );
      return null;
    }
  }

  @override
  Future<RepoReference?> fetchRepoReference(
    String fullName,
    String defaultBranch,
  ) async {
    if (defaultBranch.isEmpty) {
      return null;
    }

    try {
      return await _fetchRepoReferenceApi.call(
        fullName: fullName,
        defaultBranch: defaultBranch,
      );
    } catch (e) {
      Logger.showLog(
        'Error fetching repo reference: $e',
        'RepoDetailsRepository',
      );
      return null;
    }
  }

  @override
  Future<List<RepoTreeElement>?> fetchRepoTree(
    String fullName,
    String sha,
  ) async {
    if (sha.isEmpty) {
      return null;
    }

    try {
      final response = await _fetchRepoTreeApi.call(
        fullName: fullName,
        sha: sha,
      );

      final tree = response?.tree?.toList();
      tree?.sort((a, b) {
        const order = {Type.tree: 0, Type.commit: 1, Type.blob: 2};
        return order[a.type]!.compareTo(order[b.type]!);
      });

      return tree;
    } catch (e) {
      Logger.showLog('Error fetching repo tree: $e', 'RepoDetailsRepository');
      return null;
    }
  }
}
