import 'dart:developer' show log;

class Logger {
  static void showLog(String text, [String? name]) =>
      log(text, name: name ?? '');
}
