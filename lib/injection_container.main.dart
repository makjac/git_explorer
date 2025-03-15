part of 'injection_container.dart';

final locator = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  await setupDio();

  await initThemeCubit();
  await initLocalizationCubit();
  await initSearchRepos();
  await initRepoDetailsCubit();
  await initRepoIssuesCubit();
}

Future<void> setupDio() async {
  final basicDio =
      Dio()
        ..interceptors.add(LoggingInterceptor())
        ..interceptors.add(HeaderInterceptor());

  final cacheDio =
      Dio()
        ..interceptors.add(LoggingInterceptor())
        ..interceptors.add(HeaderInterceptor())
        ..interceptors.add(CacheInterceptor.setupCacheInterceptor());

  locator
    ..registerLazySingleton<Dio>(() => basicDio)
    ..registerLazySingleton<Dio>(() => cacheDio, instanceName: 'cacheDio');
}

Future<void> initThemeCubit() async {
  locator.registerLazySingleton<ThemeCubit>(ThemeCubit.new);
}

Future<void> initLocalizationCubit() async {
  locator.registerLazySingleton<LocalizationCubit>(LocalizationCubit.new);
}

Future<void> initSearchRepos() async {
  locator
    ..registerLazySingleton<SearchRepoApi>(
      () => SearchRepoApiImpl(dio: locator()),
    )
    ..registerFactory<RepoSearchRepository>(
      () => RepoSearchRepositoryImpl(searchRepoApi: locator()),
    )
    ..registerFactory<SearchRepoCubit>(
      () => SearchRepoCubit(repoSearchRepository: locator()),
    );
}

Future<void> initRepoDetailsCubit() async {
  locator
    ..registerLazySingleton<FetchRepoDetailsApi>(
      () =>
          FetchRepoDetailsApiImpl(dio: locator<Dio>(instanceName: 'cacheDio')),
    )
    ..registerLazySingleton<FetchRepoReferenceApi>(
      () => FetchRepoReferenceApiImpl(
        dio: locator<Dio>(instanceName: 'cacheDio'),
      ),
    )
    ..registerLazySingleton<FetchRepoTreeApi>(
      () => FetchRepoTreeApiImpl(dio: locator<Dio>(instanceName: 'cacheDio')),
    )
    ..registerFactory<RepoDetailsRepository>(
      () => RepoDetailsRepositoryImpl(
        fetchRepoDetailsApi: locator(),
        fetchRepoReferenceApi: locator(),
        fetchRepoTreeApi: locator(),
      ),
    )
    ..registerFactory<RepoDetailsCubit>(
      () => RepoDetailsCubit(repository: locator()),
    );
}

Future<void> initRepoIssuesCubit() async {
  locator
    ..registerLazySingleton<FetchRepoIssuesApi>(
      () => FetchRepoIssuesApiImpl(dio: locator()),
    )
    ..registerFactory<RepoIssuesRepository>(
      () => RepoIssuesRepositoryImpl(fetchRepoIssuesApi: locator()),
    )
    ..registerFactory<RepoIssuesCubit>(
      () => RepoIssuesCubit(repoIssuesRepository: locator()),
    );
}
