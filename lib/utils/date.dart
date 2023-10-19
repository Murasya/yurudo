extension Date on DateTime {
  DateTime addMonth(int m) {
    return DateTime(year, month + m, day);
  }

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

  /// その日より前かどうか（その日は含まない）
  bool isBeforeDay(DateTime date) {
    return isBefore(date) && !isSameDay(date);
  }

  /// その日より後かどうか（その日は含まない）
  bool isAfterDay(DateTime date) {
    return isAfter(date) && !isSameDay(date);
  }

  /// 1か月より前かどうか
  bool isMonthBefore(DateTime date) {
    final d1 = DateTime(year, month, day);
    final d2 = DateTime(date.year, date.month - 1, date.day);
    return d1.isBeforeDay(d2);
  }

  DateTime get firstDayOfMonth => DateTime(year, month, 1);

  int get lastDayOfMonth =>
      DateTime(year, month + 1, 1).add(const Duration(days: -1)).day;

  int get weekInMonth {
    final firstWeekDay = firstDayOfMonth.weekday;
    final lastDay = lastDayOfMonth;
    int totalDays = lastDay + firstWeekDay - 1;
    return (totalDays / 7).ceil();
  }
}

extension DateNullable on DateTime? {
  bool isSameDay(DateTime? date) {
    if (this == null && date == null) return true;
    if (this == null || date == null) return false;
    return this!.year == date.year &&
        this!.month == date.month &&
        this!.day == date.day;
  }

  bool isBeforeDay(DateTime? date) {
    if (this == null || date == null) return false;
    return this!.isBefore(date) && !isSameDay(date);
  }
}
