import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/core/utils/number_formatter.dart';

void main() {
  group('NumberFormatter', () {
    test('formats numbers less than 1000 correctly', () {
      expect(NumberFormatter.format(999), '999');
      expect(NumberFormatter.format(0), '0');
      expect(NumberFormatter.format(123), '123');
    });

    test('formats numbers 1000 and above correctly', () {
      expect(NumberFormatter.format(1000), '1k');
      expect(NumberFormatter.format(1500), '1k');
      expect(NumberFormatter.format(2000), '2k');
      expect(NumberFormatter.format(9999), '9k');
    });
  });
}
