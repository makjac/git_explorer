import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class CacheInterceptor {
  static DioCacheInterceptor setupCacheInterceptor() {
    final options = CacheOptions(
      store: MemCacheStore(),
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(minutes: 30),
    );

    return DioCacheInterceptor(options: options);
  }
}
