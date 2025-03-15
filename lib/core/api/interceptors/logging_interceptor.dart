import 'package:dio/dio.dart';
import 'package:git_explorer/core/utils/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.showLog('=== REQUEST ===', 'DioRequest');
    Logger.showLog('URL: ${options.uri}', 'DioRequest');
    Logger.showLog('METHOD: ${options.method}', 'DioRequest');
    if (options.data != null) {
      Logger.showLog('BODY: ${options.data}', 'DioRequest');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.statusCode == 304) {
      Logger.showLog('=== RESPONSE FROM CACHE ===', 'DioCache');
    } else {
      Logger.showLog('=== RESPONSE ===', 'DioResponse');
      Logger.showLog('STATUS CODE: ${response.statusCode}', 'DioResponse');
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode != 304) {
      Logger.showLog('=== ERROR ===', 'DioError');
      Logger.showLog('TYPE: ${err.type}', 'DioError');
      Logger.showLog('MESSAGE: ${err.message}', 'DioError');
      if (err.response != null) {
        Logger.showLog('STATUS CODE: ${err.response?.statusCode}', 'DioError');
        Logger.showLog('DATA: ${err.response?.data}', 'DioError');
      }
    }
    return super.onError(err, handler);
  }
}
