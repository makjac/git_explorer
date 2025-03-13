part of 'injection_container.dart';

final locator = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  locator
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    ..registerLazySingleton<ThemeCubit>(ThemeCubit.new);

  await initSearchRepos();
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
