enum AppIcons {
  branch,
  code,
  frok,
  issue,
  pullRequest,
  readme,
  search,
  star,
  settings,
  tag,
  watch,
}

extension AppIconsExtension on AppIcons {
  String get assetPath => 'assets/icons/$name.svg';
}
