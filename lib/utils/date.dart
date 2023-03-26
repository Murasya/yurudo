extension Date on DateTime {
  void addMonth(int m) {}

  bool isSameDay(DateTime day) {
    return year == day.year && month == day.month && this.day == day.day;
  }

  DateTime get firstDayOfMonth => DateTime(year, month, 1);

  int get lastDayOfMonth =>
      DateTime(year, month + 1, 1).add(const Duration(days: -1)).day;
}
