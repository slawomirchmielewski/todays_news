class DateConverter {
  /// Convert date to usable string
  static String convertDateToString(DateTime dateTime) {
    String year = dateTime.year.toString().padLeft(4, "0");
    String month = dateTime.month.toString().padLeft(2, "0");
    String day = dateTime.day.toString().padLeft(2, "0");

    return "$year-$month-$day";
  }
}
