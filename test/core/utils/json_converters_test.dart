import 'package:flutter_test/flutter_test.dart';
import 'package:git_explorer/core/utils/json_converters.dart';

void main() {
  group('JsonConverters', () {
    test('fromIso8601 should return null for null input', () {
      expect(JsonConverters.fromIso8601(null), isNull);
    });

    test('fromIso8601 should return null for empty string input', () {
      expect(JsonConverters.fromIso8601(''), isNull);
    });

    test('fromIso8601 should parse valid ISO8601 string', () {
      const date = '2023-10-01T12:34:56.000Z';
      final result = JsonConverters.fromIso8601(date);
      expect(result, isNotNull);
      expect(result!.toUtc().toIso8601String(), date);
    });

    test('toIso8601 should return null for null input', () {
      expect(JsonConverters.toIso8601(null), isNull);
    });

    test('toIso8601 should convert DateTime to ISO8601 string', () {
      final dateTime = DateTime.utc(2023, 10, 1, 12, 34, 56);
      final result = JsonConverters.toIso8601(dateTime);
      expect(result, '2023-10-01T12:34:56.000Z');
    });
  });
}
