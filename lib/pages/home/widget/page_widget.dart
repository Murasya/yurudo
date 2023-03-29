import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/pages/home/home_page_state.dart';
import 'package:routine_app/pages/home/widget/next_schedule.dart';
import 'package:routine_app/pages/home/widget/next_schedule_state.dart';
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

class PageWidget extends ConsumerStatefulWidget {
  const PageWidget({
    required this.index,
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  ConsumerState createState() => _PageWidgetState();
}

class _PageWidgetState extends ConsumerState<PageWidget> {
  late final DateTime pageDay;

  @override
  void initState() {
    final state = ref.watch(homePageStateProvider);
    pageDay =
        state.today.add(Duration(days: widget.index * state.displayTerm.term));
    super.initState();
  }

  int compExp(Todo a, Todo b) {
    return a.expectedDate!.compareTo(b.expectedDate!);
  }

  int compTime(Todo a, Todo b) {
    return a.time.compareToEx(b.time);
  }

  @override
  Widget build(BuildContext context) {
    late final List<Todo> todoList;
    late final List<Todo> pastTodoList;
    final state = ref.watch(homePageStateProvider);
    if (state.displayTerm == TermType.day) {
      if (widget.index < 0) {
        todoList = state.todoList
            .where((todo) =>
                isContainDay(todo.completeDate, pageDay) ||
                (todo.expectedDate != null &&
                    todo.expectedDate!.dateDiff(pageDay) % todo.span == 0 &&
                    state.today.dateDiff(pageDay) < todo.span))
            .toList();
        todoList.sort(compTime);
        pastTodoList = [];
      } else if (widget.index == 0) {
        todoList = state.todoList
            .where((todo) =>
                isSameDay(todo.expectedDate, pageDay) ||
                isContainDay(todo.completeDate, pageDay))
            .toList();
        todoList.sort(compTime);
        pastTodoList = state.todoList
            .where((todo) => isBeforeDay(todo.expectedDate, pageDay))
            .toList();
      } else {
        todoList = state.todoList.where((todo) {
          if (todo.expectedDate == null) return false;
          return todo.expectedDate!.isBefore(pageDay) &&
              todo.expectedDate!.dateDiff(pageDay) % todo.span == 0;
        }).toList();
        todoList.sort(compTime);
        pastTodoList = [];
      }
    } else {
      todoList = state.todoList.where((todo) {
        if (todo.expectedDate == null) return false;
        return todo.expectedDate!.inWeek(pageDay);
      }).toList();
      todoList.sort(compExp);
      pastTodoList = [];
    }

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
              state.displayTerm == TermType.day
                  ? 'この日のゆるDOと所要時間'
                  : 'この週のゆるDOと実施予定日',
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
            if (pastTodoList.isNotEmpty &&
                state.displayTerm == TermType.day) ...[
              const SizedBox(height: 38),
              Text(
                '実施が遅れているゆるDOと遅延期間',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: pastTodoList.length,
                itemBuilder: (context, index) {
                  var todo = pastTodoList[index];
                  return _taskItem(todo, context);
                },
              ),
            ],
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _taskItem(Todo todo, BuildContext context) {
    final state = ref.watch(homePageStateProvider);

    Widget timeWidget() {
      if (isSameDay(state.today, pageDay) &&
          isBeforeDay(todo.expectedDate, pageDay)) {
        String num =
            (todo.expectedDate!.isMonthBefore(state.today)) ? '1' : '~1';
        String suf = (state.today.inWeek(todo.expectedDate!))
            ? '週間'
            : (todo.expectedDate!.isMonthBefore(state.today))
                ? 'か月超'
                : 'か月';
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              num,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              suf,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColor.emphasisColor),
            ),
          ],
        );
      }
      if (state.displayTerm == TermType.day) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (todo.time == null) ? '- ' : '${todo.time}',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text('分', style: Theme.of(context).textTheme.bodyMedium),
          ],
        );
      } else {
        return Text(
          DateFormat('M/d').format(todo.expectedDate!),
          style: const TextStyle(
            color: AppColor.fontColor2,
            fontSize: 22,
          ),
        );
      }
    }

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
                if (!isContainDay(todo.completeDate, pageDay)) {
                  debugPrint('complete!');
                  showDialog(
                    context: context,
                    builder: (_) => NextSchedule(
                      args: NextScheduleArgs(
                        todo: todo,
                        completeDay: pageDay,
                      ),
                    ),
                  );
                } else {
                  ref.read(todoProvider.notifier).unComplete(
                        todo: todo,
                        completeDay: pageDay,
                      );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SvgPicture.asset(
                  (isContainDay(todo.completeDate, pageDay))
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
                child: timeWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
