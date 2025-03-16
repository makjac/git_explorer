// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Git Explorer';

  @override
  String get dashboard_home_tab => 'Home';

  @override
  String get dashboard_settings_tab => 'Settings';

  @override
  String get repo_search_bar_hint => 'Search \'language: dart repo_name\'';

  @override
  String get rs_something_went_wrong => 'Something went wrong.';

  @override
  String get rs_try_again => 'Try Again';

  @override
  String get rs_search_for_repositories => 'Search for repositories';

  @override
  String get rs_repositores_not_match => 'Your search did not match any repositories';

  @override
  String get rs_unknown => 'Unknown';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get systemDefault => 'System default';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get languages => 'Languages';

  @override
  String get about => 'About';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get sendFeedback => 'Send feedback';

  @override
  String get feedbackSent => 'Feedback sent';

  @override
  String get version => 'Version';

  @override
  String get repoLoadingStructure => 'Loading repository structure...';

  @override
  String get repoLoadingFiles => 'Loading repository files...';

  @override
  String get allPullRequests => 'All Pull Requests';

  @override
  String get noPullRequestsFound => 'No pull requests found';

  @override
  String get unableToFetchPullRequests => 'Unable to fetch pull requests';

  @override
  String get noTitle => 'No title';

  @override
  String pullRequestInfo(Object number, Object date) {
    return '#$number opened on $date';
  }

  @override
  String issueInfo(Object number, Object date) {
    return '#$number · opened · $date';
  }

  @override
  String get openIssues => 'Open Issues';

  @override
  String get closedIssues => 'Closed Issues';

  @override
  String get allIssues => 'All Issues';

  @override
  String get noIssuesFound => 'No issues found';

  @override
  String get details => 'Details';

  @override
  String get issues => 'Issues';

  @override
  String get pullRequests => 'Pull Requests';
}
