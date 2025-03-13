class JsonConverters {
  static DateTime? fromIso8601(String? date) {
    if (date == null || date.isEmpty) return null;
    return DateTime.parse(date);
  }

  static String? toIso8601(DateTime? dateTime) {
    if (dateTime == null) return null;
    return dateTime.toUtc().toIso8601String();
  }
}
