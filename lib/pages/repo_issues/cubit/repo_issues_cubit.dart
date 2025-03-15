import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue/repo_issue.dart';
import 'package:git_explorer/pages/repo_issues/repository/repo_issues_reposiotry.dart';

part 'repo_issues_state.dart';
part 'repo_issues_cubit.freezed.dart';

class RepoIssuesCubit extends Cubit<RepoIssuesState> {
  RepoIssuesCubit({required RepoIssuesRepository repoIssuesRepository})
    : _repository = repoIssuesRepository,
      super(const RepoIssuesState.initial());

  final RepoIssuesRepository _repository;

  Future<void> fetchOpenIssues({
    required String fullName,
    int perPage = 20,
  }) async {
    emit(
      RepoIssuesState.loadingOpen(
        openIssues: _repository.getOpenIssues(),
        closedIssues: _repository.getClosedIssues(),
        allIssues: _repository.getAllIssues(),
      ),
    );

    try {
      final result = await _repository.fetchOpenIssues(
        fullName: fullName,
        perPage: perPage,
      );

      emit(
        RepoIssuesState.openIssuesFetched(
          openIssues: result.issues,
          closedIssues: _repository.getClosedIssues(),
          allIssues: _repository.getAllIssues(),
        ),
      );
    } catch (e) {
      emit(
        RepoIssuesState.error(
          message: e.toString(),
          openIssues: _repository.getOpenIssues(),
          closedIssues: _repository.getClosedIssues(),
          allIssues: _repository.getAllIssues(),
        ),
      );
    }
  }

  Future<void> fetchClosedIssues({
    required String fullName,
    int perPage = 20,
  }) async {
    emit(
      RepoIssuesState.loadingClosed(
        openIssues: _repository.getOpenIssues(),
        closedIssues: _repository.getClosedIssues(),
        allIssues: _repository.getAllIssues(),
      ),
    );

    try {
      final result = await _repository.fetchClosedIssues(
        fullName: fullName,
        perPage: perPage,
      );

      emit(
        RepoIssuesState.closedIssuesFetched(
          openIssues: _repository.getOpenIssues(),
          closedIssues: result.issues,
          allIssues: _repository.getAllIssues(),
        ),
      );
    } catch (e) {
      emit(
        RepoIssuesState.error(
          message: e.toString(),
          openIssues: _repository.getOpenIssues(),
          closedIssues: _repository.getClosedIssues(),
          allIssues: _repository.getAllIssues(),
        ),
      );
    }
  }

  Future<void> fetchAllIssues({
    required String fullName,
    int perPage = 20,
  }) async {
    emit(
      RepoIssuesState.loadingAll(
        openIssues: _repository.getOpenIssues(),
        closedIssues: _repository.getClosedIssues(),
        allIssues: _repository.getAllIssues(),
      ),
    );

    try {
      final result = await _repository.fetchAllIssues(
        fullName: fullName,
        perPage: perPage,
      );

      emit(
        RepoIssuesState.allIssuesFetched(
          openIssues: _repository.getOpenIssues(),
          closedIssues: _repository.getClosedIssues(),
          allIssues: result.issues,
        ),
      );
    } catch (e) {
      emit(
        RepoIssuesState.error(
          message: e.toString(),
          openIssues: _repository.getOpenIssues(),
          closedIssues: _repository.getClosedIssues(),
          allIssues: _repository.getAllIssues(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _repository.cancelOngoingRequests();
    return super.close();
  }
}
