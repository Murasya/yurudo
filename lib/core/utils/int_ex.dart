import 'package:flutter/material.dart';
import 'package:routine_app/core/utils/contextEx.dart';

extension IntEx on int? {
  String toSpanString(BuildContext context) {
    if (this == null) {
      throw Exception('Span should not null');
    }
    if (this! < 7) {
      return context.l10n.onceEveryDay(this as num);
    } else if (this! < 30) {
      return context.l10n.onceEveryWeek(this! ~/ 7 as num);
    } else {
      return context.l10n.onceEveryMonth(this! ~/ 30 as num);
    }
  }

  String toTimeString(BuildContext context) {
    if (this == null) {
      return '- ${context.l10n.minute}';
    }
    return '$this${context.l10n.minute}';
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
