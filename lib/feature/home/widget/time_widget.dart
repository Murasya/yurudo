import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/core/design/app_style.dart';
import 'package:routine_app/core/utils/contextEx.dart';
import 'package:routine_app/core/utils/date.dart';

import '../../../repository/todo/todo.dart';
import '../home_page_state.dart';

bool isContainDay(List<DateTime> list, DateTime d) {
  return list.any((e) => e.isSameDay(d));
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
    required this.todo,
    required this.today,
    required this.pageDate,
    required this.term,
  });

  final Todo todo;
  final DateTime today;
  final DateTime pageDate;
  final TermType term;

  @override
  Widget build(BuildContext context) {
    if (today.isSameDay(pageDate) &&
        (todo.expectedDate.isBeforeDay(pageDate) ||
            todo.preExpectedDate.isBeforeDay(pageDate)) &&
        term == TermType.day) {
      String num;
      String suf;
      DateTime date;
      if (isContainDay(todo.completeDate, pageDate)) {
        date = todo.preExpectedDate!;
      } else {
        date = todo.expectedDate!;
      }
      if (today.inWeek(date)) {
        num = '~1';
        suf = context.l10n.weekly(1);
      } else if (date.isMonthBefore(today)) {
        num = '1';
        suf = context.l10n.monthlyOver;
      } else if (date.isBeforeDay(today.add(const Duration(days: -13)))) {
        num = '~1';
        suf = context.l10n.monthly(1);
      } else {
        num = '~2';
        suf = context.l10n.weekly(2);
      }
      return Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: num,
                style: context.textTheme.bodyLarge.emphasis,
              ),
              TextSpan(
                text: suf,
                style: context.textTheme.bodySmall.emphasis,
              ),
            ],
          ),
        ),
      );
    } else if (term == TermType.day) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            (todo.time == null) ? '- ' : '${todo.time}',
            style: context.textTheme.bodyLarge,
          ),
          Text(context.l10n.minute, style: context.textTheme.bodySmall),
        ],
      );
    } else {
      return Center(
        child: Text(
          DateFormat('M/d').format(todo.expectedDate!),
          style: context.textTheme.bodyLarge,
        ),
      );
    }
  }
}
