// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get app_name => 'Git Explorer';

  @override
  String get dashboard_home_tab => 'Home';

  @override
  String get dashboard_settings_tab => 'Ustawienia';

  @override
  String get repo_search_bar_hint => 'Wyszukaj \'language: dart nazwa_repozytorium\'';

  @override
  String get rs_something_went_wrong => 'Coś poszło nie tak.';

  @override
  String get rs_try_again => 'Spróbuj ponownie';

  @override
  String get rs_search_for_repositories => 'Szukaj repozytoriów';

  @override
  String get rs_repositores_not_match => 'Twoje wyszukiwanie nie pasuje do żadnych repozytoriów';

  @override
  String get rs_unknown => 'Nieznany';

  @override
  String get settings => 'Ustawienia';

  @override
  String get appearance => 'Wygląd';

  @override
  String get systemDefault => 'Domyślny systemowy';

  @override
  String get light => 'Jasny';

  @override
  String get dark => 'Ciemny';

  @override
  String get languages => 'Języki';

  @override
  String get about => 'O aplikacji';

  @override
  String get termsOfUse => 'Warunki użytkowania';

  @override
  String get sendFeedback => 'Wyślij opinię';

  @override
  String get feedbackSent => 'Opinia wysłana';

  @override
  String get version => 'Wersja';

  @override
  String get repoLoadingStructure => 'Ładowanie struktury repozytorium...';

  @override
  String get repoLoadingFiles => 'Ładowanie plików repozytorium...';

  @override
  String get allPullRequests => 'Wszystkie Pull Requesty';

  @override
  String get noPullRequestsFound => 'Nie znaleziono pull requestów';

  @override
  String get unableToFetchPullRequests => 'Nie można pobrać pull requestów';

  @override
  String get noTitle => 'Brak tytułu';

  @override
  String pullRequestInfo(Object number, Object date) {
    return '#$number otworzono $date';
  }

  @override
  String issueInfo(Object number, Object date) {
    return '#$number · otworzono · $date';
  }

  @override
  String get openIssues => 'Otwarte Issues';

  @override
  String get closedIssues => 'Zamknięte Issues';

  @override
  String get allIssues => 'Wszystkie Issues';

  @override
  String get noIssuesFound => 'Nie znaleziono issues';

  @override
  String get details => 'Szczegóły';

  @override
  String get issues => 'Issues';

  @override
  String get pullRequests => 'Pull Requests';
}
