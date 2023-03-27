extension Date on DateTime {
  void addMonth(int m) {}

  bool isSameDay(DateTime day) {
    return year == day.year && month == day.month && this.day == day.day;
  }

  bool inWeek(DateTime startDay) {
    final start = DateTime(startDay.year, startDay.month, startDay.day);
    final end = DateTime(start.year, start.month, start.day + 7);
    return isAfter(start) && isBefore(end);
  }

  int dateDiff(DateTime date) {
    final d1 = DateTime(year, month, day);
    final d2 = DateTime(date.year, date.month, date.day);
    return d1.difference(d2).inDays;
  }

  DateTime get firstDayOfMonth => DateTime(year, month, 1);

  int get lastDayOfMonth =>
      DateTime(year, month + 1, 1).add(const Duration(days: -1)).day;
}
