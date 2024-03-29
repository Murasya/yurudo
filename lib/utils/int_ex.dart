extension IntEx on int? {
  String toSpanString() {
    if (this == null) {
      throw Exception('Span should not null');
    }
    if (this! < 7) {
      return '$this日に1回';
    } else if (this! < 30) {
      return '${this! ~/ 7}週に1回';
    } else {
      return '${this! ~/ 30}か月に1回';
    }
  }

  String toTimeString() {
    if (this == null) {
      return '- 分';
    }
    return '$this分';
  }

  int compareToEx(int? a) {
    if (this == null) {
      if (a == null) {
        return 0;
      } else {
        return 1;
      }
    } else {
      if (a == null) {
        return -1;
      } else {
        return this!.compareTo(a);
      }
    }
  }
}
