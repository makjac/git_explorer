import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:git_explorer/core/utils/logger.dart';
import 'package:git_explorer/pages/repo_details/models/repo_details/repo_details.dart';
import 'package:git_explorer/pages/repo_details/models/repo_reference/repo_reference.dart';
import 'package:git_explorer/pages/repo_details/models/repo_tree/repo_tree.dart';
import 'package:git_explorer/pages/repo_details/repository/repo_details_repository.dart';

part 'repo_details_cubit.freezed.dart';
part 'repo_details_state.dart';

class RepoDetailsCubit extends Cubit<RepoDetailsState> {
  RepoDetailsCubit({RepoDetailsRepository? repository})
    : _repository = repository ?? RepoDetailsRepositoryImpl(),
      super(const RepoDetailsState.initial());

  final RepoDetailsRepository _repository;

  Future<void> loadRepositoryData(String fullName) async {
    Logger.showLog('Loading repository data for $fullName', 'RepoDetailsCubit');
    try {
      emit(const RepoDetailsState.loading());

      final repoDetails = await _repository.fetchRepoDetails(fullName);
      if (repoDetails == null) {
        emit(
          const RepoDetailsState.error(
            errorMessage: 'Unable to fetch repo details',
          ),
        );
        return;
      }

      emit(RepoDetailsState.detailsFetched(repoDetails: repoDetails));

      if (repoDetails.defaultBranch?.isEmpty ?? true) {
        emit(
          RepoDetailsState.error(
            errorMessage: 'Repository has no default branch specified',
            repoDetails: repoDetails,
          ),
        );
        return;
      }

      final repoReference = await _repository.fetchRepoReference(
        fullName,
        repoDetails.defaultBranch!,
      );

      if (repoReference == null || repoReference.object?.sha == null) {
        emit(
          RepoDetailsState.error(
            errorMessage: 'Unable to fetch repo reference',
            repoDetails: repoDetails,
          ),
        );
        return;
      }

      emit(
        RepoDetailsState.detailsFetched(
          repoDetails: repoDetails,
          repoReference: repoReference,
        ),
      );

      final sha = repoReference.object?.sha;
      if (sha == null || sha.isEmpty) {
        emit(
          RepoDetailsState.error(
            errorMessage: 'Repository reference contains no SHA',
            repoDetails: repoDetails,
            repoReference: repoReference,
          ),
        );
        return;
      }

      final treeElements = await _repository.fetchRepoTree(fullName, sha);

      if (treeElements == null) {
        emit(
          RepoDetailsState.error(
            errorMessage: 'Unable to fetch repo tree',
            repoDetails: repoDetails,
            repoReference: repoReference,
          ),
        );
        return;
      }

      emit(
        RepoDetailsState.allDataFetched(
          repoDetails: repoDetails,
          repoReference: repoReference,
          treeElements: treeElements,
        ),
      );
    } catch (e) {
      Logger.showLog(
        'Error occurred while fetching repository data: $e',
        'RepoDetailsCubit',
      );

      RepoDetails? details;
      RepoReference? reference;
      List<RepoTreeElement>? tree;

      if (state is RepoDetailsWithData) {
        final currentState = state as RepoDetailsWithData;
        details = currentState.repoDetails;
        reference = currentState.repoReference;
        tree = currentState.treeElements;
      }

      emit(
        RepoDetailsState.error(
          errorMessage: 'An error occurred while fetching repository data',
          repoDetails: details,
          repoReference: reference,
          treeElements: tree,
        ),
      );
    }
  }
}
