import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/pages/home/home_page_state.dart';
import 'package:routine_app/utils/contextEx.dart';
import 'package:routine_app/utils/date.dart';

import '../../../design/app_color.dart';
import '../../../model/todo.dart';

bool isContainDay(List<DateTime> list, DateTime d) {
  return list.any((e) => e.isSameDay(d));
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    Key? key,
    required this.todo,
    required this.today,
    required this.pageDate,
    required this.term,
  }) : super(key: key);

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
        suf = '週間';
      } else if (date.isMonthBefore(today)) {
        num = '1';
        suf = 'か月超';
      } else if (date.isBeforeDay(today.add(const Duration(days: -13)))) {
        num = '~1';
        suf = 'か月';
      } else {
        num = '~2';
        suf = '週間';
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            num,
            style: context.textTheme.labelLarge,
          ),
          Text(
            suf,
            style: context.textTheme.bodyMedium!
                .copyWith(color: AppColor.emphasisColor),
          ),
        ],
      );
    } else if (term == TermType.day) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (todo.time == null) ? '- ' : '${todo.time}',
            style: context.textTheme.labelMedium,
          ),
          Text('分', style: context.textTheme.bodyMedium),
        ],
      );
    } else {
      return Center(
        child: Text(
          DateFormat('M/d').format(todo.expectedDate!),
          style: const TextStyle(
            color: AppColor.fontColor2,
            fontSize: 22,
          ),
        ),
      );
    }
  }
}
