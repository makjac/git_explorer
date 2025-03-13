class NumberFormatter {
  static String format(int number) {
    if (number < 1000) {
      return number.toString();
    } else {
      return '${(number / 1000).toInt()}k';
    }
  }
}
