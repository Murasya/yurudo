import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/pages/home/home_page_state.dart';
import 'package:routine_app/pages/home/widget/next_schedule.dart';
import 'package:routine_app/pages/home/widget/next_schedule_state.dart';
import 'package:routine_app/utils/contextEx.dart';
import 'package:routine_app/utils/date.dart';
import 'package:routine_app/utils/int_ex.dart';
import 'package:routine_app/viewModel/todo_provider.dart';

import '../../../design/app_assets.dart';
import '../../../design/app_color.dart';
import '../../../model/todo.dart';
import '../../../router.dart';
import '../../../viewModel/category_provider.dart';

bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) return false;
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

bool isBeforeDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) return false;
  return !isSameDay(a, b) && a.isBefore(b);
}

bool isContainDay(List<DateTime> list, DateTime d) {
  return list.any((e) => isSameDay(e, d));
}

class PageWidgetWeek extends ConsumerStatefulWidget {
  const PageWidgetWeek({
    required this.index,
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  ConsumerState createState() => _PageWidgetState();
}

class _PageWidgetState extends ConsumerState<PageWidgetWeek> {
  late final DateTime pageWeekStart;

  @override
  void didChangeDependencies() {
    final state = ref.watch(homePageStateProvider);
    pageWeekStart =
        state.today.add(Duration(days: widget.index * state.displayTerm.term));
    super.didChangeDependencies();
  }

  int compExp(Todo a, Todo b) {
    return a.expectedDate!.compareTo(b.expectedDate!);
  }

  int compTime(Todo a, Todo b) {
    return a.time.compareToEx(b.time);
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> todoList = [];
    final state = ref.watch(homePageStateProvider);

    for (var todo in state.todoList) {
      // 完了したゆるDO
      for (var comp in todo.completeDate) {
        if (comp.inWeek(pageWeekStart)) {
          todoList.add(todo.copyWith(expectedDate: () => comp));
        }
      }
      final pageWeekEnd = pageWeekStart.add(const Duration(days: 6));
      // 未完了のゆるDO
      if (widget.index < 0 ||
          todo.expectedDate == null ||
          todo.expectedDate!.isAfterDay(pageWeekEnd)) continue;

      for (var i = 0; i < 7; i++) {
        DateTime dayInWeek = pageWeekStart.add(Duration(days: i));
        if (!dayInWeek.isBeforeDay(todo.expectedDate!) &&
            todo.expectedDate!.dateDiff(dayInWeek) % todo.span == 0) {
          todoList.add(todo.copyWith(expectedDate: () => dayInWeek));
        }
      }
    }
    todoList.sort(compExp);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'この週のゆるDOと実施予定日',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                var todo = todoList[index];
                return _taskItem(todo, context);
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _taskItem(Todo todo, BuildContext context) {
    final state = ref.watch(homePageStateProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.secondaryColor,
      ),
      height: 60,
      margin: const EdgeInsets.only(top: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRouter.detail, arguments: todo);
        },
        child: Row(
          children: [
            Container(
              width: 12,
              decoration: BoxDecoration(
                color: ref
                    .watch(categoryProvider.notifier)
                    .getColor(todo.categoryId),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (state.today.isBeforeDay(todo.expectedDate!)) {
                  context.showSnackBar(
                    const SnackBar(content: Text('未来のゆるDOは完了できません')),
                  );
                  return;
                }
                if (todo.expectedDate == null ||
                    isContainDay(todo.completeDate, todo.expectedDate!)) {
                  ref.read(todoProvider.notifier).unComplete(
                        todo: todo,
                        completeDay: state.today,
                      );
                } else {
                  debugPrint('complete!');
                  showDialog(
                    context: context,
                    builder: (_) => NextSchedule(
                      args: NextScheduleArgs(
                        todo: todo,
                        completeDay: state.today,
                      ),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SvgPicture.asset(
                  (todo.expectedDate == null ||
                          isContainDay(todo.completeDate, todo.expectedDate!))
                      ? AppAssets.check
                      : AppAssets.uncheck,
                  width: 24,
                ),
              ),
            ),
            Expanded(
              child: Text(
                todo.name,
                style: const TextStyle(
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              width: 70,
              height: double.infinity,
              margin: const EdgeInsets.only(left: 12),
              decoration: const BoxDecoration(
                color: AppColor.thirdColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  DateFormat('M/d').format(todo.expectedDate!),
                  style: const TextStyle(
                    color: AppColor.fontColor2,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
