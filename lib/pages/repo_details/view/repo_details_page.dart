import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/core/localization/app_localizations_extension.dart';
import 'package:git_explorer/pages/repo_details/cubit/repo_details_cubit.dart';
import 'package:git_explorer/pages/repo_details/widgets/repo_details_widgets.dart';

@RoutePage()
class RepoDetailsPage extends StatefulWidget {
  const RepoDetailsPage({
    @PathParam('fullName') required this.fullName,
    super.key,
  });

  final String fullName;

  @override
  State<RepoDetailsPage> createState() => _RepoDetailsPageState();
}

class _RepoDetailsPageState extends State<RepoDetailsPage> {
  @override
  void initState() {
    context.read<RepoDetailsCubit>().loadRepositoryData(widget.fullName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RepoDetailsCubit, RepoDetailsState>(
        builder: (context, state) {
          return switch (state) {
            RepoDetailsInitial() => const SizedBox(),
            RepoDetailsLoading() => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            RepoDetailsWithData() => _buildContent(
              context,
              state as RepoDetailsWithData,
            ),
          };
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, RepoDetailsWithData state) {
    final repoDetails = state.repoDetails;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (repoDetails != null) RepoHeader(repoDetails: repoDetails),
                const Divider(height: 24),
                if (repoDetails?.description?.isNotEmpty ?? false)
                  RepoDescription(description: repoDetails!.description!),
                if (repoDetails?.topics?.isNotEmpty ?? false)
                  RepoTopics(topics: repoDetails!.topics!),
                if (repoDetails != null) RepoStats(repoDetails: repoDetails),
                if (state is RepoDetailsFetched && state.repoReference == null)
                  StatusIndicator.loading(context.l10n.repoLoadingStructure),

                if (state is RepoDetailsError)
                  StatusIndicator.error(state.errorMessage),
              ]),
            ),
          ),

          if (state.treeElements != null && state.treeElements!.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: RepoTreeList(treeElements: state.treeElements!),
            ),

          if (state is RepoDetailsFetched &&
              state.treeElements == null &&
              state.repoReference != null)
            SliverToBoxAdapter(
              child: StatusIndicator.loading(context.l10n.repoLoadingFiles),
            ),
        ],
      ),
    );
  }
}
