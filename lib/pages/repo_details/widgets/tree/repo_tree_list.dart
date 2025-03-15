import 'package:flutter/material.dart';
import 'package:git_explorer/core/widgets/icons/app_icon.dart';
import 'package:git_explorer/core/widgets/icons/app_icons.dart';
import 'package:git_explorer/pages/repo_details/models/repo_tree/repo_tree.dart';

class RepoTreeList extends StatelessWidget {
  const RepoTreeList({required this.treeElements, super.key});

  final List<RepoTreeElement> treeElements;

  static const _minTileHeight = 41.0;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemCount: treeElements.length,
            itemBuilder: (context, index) {
              final element = treeElements[index];
              return switch (element.type) {
                Type.blob => ListTile(
                  title: Text(element.path ?? ''),
                  leading: const AppIcon(icon: AppIcons.blob),
                  dense: true,
                  minTileHeight: _minTileHeight,
                  onTap: () {},
                ),
                Type.tree => ListTile(
                  title: Text(element.path ?? ''),
                  leading: const AppIcon(icon: AppIcons.tree),
                  dense: true,
                  minTileHeight: _minTileHeight,
                  onTap: () {},
                ),
                Type.commit => ListTile(
                  title: Text(element.path ?? ''),
                  leading: const AppIcon(icon: AppIcons.commit),
                  dense: true,
                  minTileHeight: _minTileHeight,
                  onTap: () {},
                ),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ),
      ]),
    );
  }
}
