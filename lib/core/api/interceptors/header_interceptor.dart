import 'package:dio/dio.dart';
import 'package:git_explorer/core/utils/logger.dart';

class HeaderInterceptor extends Interceptor {
  final Map<String, dynamic> defaultHeaders = {
    'Accept': 'application/vnd.github.v3+json',
  };

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(defaultHeaders);

    const githubToken = String.fromEnvironment('GITHUB_AUTHORIZATION');

    if (githubToken.isNotEmpty) {
      options.headers['Authorization'] = 'token $githubToken';
    }

    if (options.method == 'POST' || options.method == 'PUT') {
      options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    }

    Logger.showLog('HEADERS: ${options.headers}', 'DioRequest');

    return super.onRequest(options, handler);
  }
}
