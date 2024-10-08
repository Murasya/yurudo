import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/core/utils/date.dart';

import '../../design/app_color.dart';

Widget calendar({
  required DateTime selectedDate,
  required void Function() onNextMonth,
  required void Function() onPreviousMonth,
  required void Function(DateTime) onChangeDate,
}) {
  const list = ['月', '火', '水', '木', '金', '土', '日'];

  Widget dayWidget(int week, int weekDay) {
    int intDay = (week * 7 + weekDay - selectedDate.firstDayOfMonth.weekday + 1);
    if (intDay <= 0 || intDay > selectedDate.lastDayOfMonth) {
      return Expanded(child: Container());
    }
    DateTime day = DateTime(selectedDate.year, selectedDate.month, intDay);
    bool isSelectDay = selectedDate.isSameDay(day);

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          onChangeDate(day);
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelectDay ? AppColor.primary : Colors.transparent,
          ),
          child: Text(
            intDay.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelectDay ? Colors.white : AppColor.fontColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: onPreviousMonth,
          ),
          Text(
            DateFormat('y年M月').format(selectedDate),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: onNextMonth,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (String day in list)
            Expanded(
              child: Text(
                day,
                style: const TextStyle(
                  color: AppColor.disableColor,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
      const SizedBox(height: 20),
      Column(
        children: [
          for (int week = 0; week < selectedDate.weekInMonth; week++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int day = 1; day <= 7; day++) dayWidget(week, day),
              ],
            ),
        ],
      ),
    ],
  );
}
