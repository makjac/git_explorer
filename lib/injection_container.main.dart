part of 'injection_container.dart';

final locator = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  await initThemeCubit();
  await initLocalizationCubit();
  await initSearchRepos();
}

Future<void> initThemeCubit() async {
  locator.registerLazySingleton<ThemeCubit>(ThemeCubit.new);
}

Future<void> initLocalizationCubit() async {
  locator.registerLazySingleton<LocalizationCubit>(LocalizationCubit.new);
}

Future<void> initSearchRepos() async {
  locator
    ..registerLazySingleton<SearchRepoApi>(SearchRepoApiImpl.new)
    ..registerFactory<RepoSearchRepository>(
      () => RepoSearchRepositoryImpl(searchRepoApi: locator()),
    )
    ..registerFactory<SearchRepoCubit>(
      () => SearchRepoCubit(repoSearchRepository: locator()),
    );
}
