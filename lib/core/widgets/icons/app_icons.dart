enum AppIcons {
  branch,
  clear,
  code,
  frok,
  issue,
  pullRequest,
  readme,
  repository,
  search,
  star,
  settings,
  tag,
  watch,
}

extension AppIconsExtension on AppIcons {
  String get assetPath => 'assets/icons/$name.svg';
}
