import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/pages/home/home_page_state.dart';
import 'package:routine_app/utils/contextEx.dart';
import 'package:routine_app/utils/date.dart';

import '../../../design/app_color.dart';
import '../../../model/todo.dart';

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
    if (today.isSameDay(pageDate) && todo.expectedDate!.isBeforeDay(pageDate)) {
      String num = (todo.expectedDate!.isMonthBefore(today)) ? '1' : '~1';
      String suf = (today.inWeek(todo.expectedDate!))
          ? '週間'
          : (todo.expectedDate!.isMonthBefore(today))
              ? 'か月超'
              : 'か月';
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
