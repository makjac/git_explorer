import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Git Explorer'**
  String get app_name;

  /// Home tab name [DashboardPage]
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get dashboard_home_tab;

  /// Settings tab name [DashboardPage]
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get dashboard_settings_tab;

  /// Search bar hint text [HomePage]
  ///
  /// In en, this message translates to:
  /// **'Search \'language: dart repo_name\''**
  String get repo_search_bar_hint;

  /// Search error message [HomePage]
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get rs_something_went_wrong;

  /// Try again button message [HomePage]
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get rs_try_again;

  /// Search for repositories message [HomePage]
  ///
  /// In en, this message translates to:
  /// **'Search for repositories'**
  String get rs_search_for_repositories;

  /// No repositories found message [HomePage]
  ///
  /// In en, this message translates to:
  /// **'Your search did not match any repositories'**
  String get rs_repositores_not_match;

  /// Unknown programing language [RepoThumbnail]
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get rs_unknown;

  /// Title for the settings page
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Header for appearance settings section
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Option to use system default theme
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// Option for light theme
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Option for dark theme
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Header for language settings section
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// Header for about section
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Button for terms of use
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// Button to send feedback
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get sendFeedback;

  /// Message shown when feedback is sent
  ///
  /// In en, this message translates to:
  /// **'Feedback sent'**
  String get feedbackSent;

  /// Label for app version information
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Displayed when the repository structure is loading.
  ///
  /// In en, this message translates to:
  /// **'Loading repository structure...'**
  String get repoLoadingStructure;

  /// Displayed when repository files are loading.
  ///
  /// In en, this message translates to:
  /// **'Loading repository files...'**
  String get repoLoadingFiles;

  /// Title for the pull requests screen header.
  ///
  /// In en, this message translates to:
  /// **'All Pull Requests'**
  String get allPullRequests;

  /// Message displayed when no pull requests are available.
  ///
  /// In en, this message translates to:
  /// **'No pull requests found'**
  String get noPullRequestsFound;

  /// Default error message when pull requests cannot be fetched.
  ///
  /// In en, this message translates to:
  /// **'Unable to fetch pull requests'**
  String get unableToFetchPullRequests;

  /// Fallback text when pull request title is not provided.
  ///
  /// In en, this message translates to:
  /// **'No title'**
  String get noTitle;

  /// Information about a pull request including its number and the date it was opened. Placeholders: number, date.
  ///
  /// In en, this message translates to:
  /// **'#{number} opened on {date}'**
  String pullRequestInfo(Object number, Object date);

  /// Information about an issue including its number and the date it was opened. Placeholders: number, date.
  ///
  /// In en, this message translates to:
  /// **'#{number} · opened · {date}'**
  String issueInfo(Object number, Object date);

  /// Title for the open issues screen header.
  ///
  /// In en, this message translates to:
  /// **'Open Issues'**
  String get openIssues;

  /// Title for the closed issues screen header.
  ///
  /// In en, this message translates to:
  /// **'Closed Issues'**
  String get closedIssues;

  /// Title for the all issues screen header.
  ///
  /// In en, this message translates to:
  /// **'All Issues'**
  String get allIssues;

  /// Message displayed when no issues are available.
  ///
  /// In en, this message translates to:
  /// **'No issues found'**
  String get noIssuesFound;

  /// Tab name for the details section of the repository.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// Tab name for the issues section of the repository.
  ///
  /// In en, this message translates to:
  /// **'Issues'**
  String get issues;

  /// Tab name for the pull requests section of the repository.
  ///
  /// In en, this message translates to:
  /// **'Pull Requests'**
  String get pullRequests;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pl': return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
