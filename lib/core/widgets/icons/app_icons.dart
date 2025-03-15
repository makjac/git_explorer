enum AppIcons {
  blob,
  branch,
  clear,
  code,
  commit,
  frok,
  issue,
  license,
  pullRequest,
  readme,
  repository,
  search,
  star,
  settings,
  tag,
  tree,
  watch,
}

extension AppIconsExtension on AppIcons {
  String get assetPath => 'assets/icons/$name.svg';
}
