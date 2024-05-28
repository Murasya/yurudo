import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routine_app/pages/home/home_page_state.dart';
import 'package:routine_app/pages/home/widget/time_widget.dart';
import 'package:routine_app/pages/taskDetail/task_detail_page_state.dart';
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
    super.key,
  });

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
    int result = a.expectedDate!.compareTo(b.expectedDate!);
    if (result != 0) return result;
    return a.id.compareToEx(b.id);
  }

  int compTime(Todo a, Todo b) {
    return a.time.compareToEx(b.time);
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> todoList = [];
    for (var todo in ref.watch(todoProvider)) {
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
                return Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    _taskItem(todo, context)
                  ],
                );
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
    final isCompleted = todo.expectedDate == null ||
        isContainDay(todo.completeDate, todo.expectedDate!);

    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.secondaryColor,
      ),
      height: 60,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        highlightColor: AppColor.secondaryColor.withOpacity(0.5),
        onTap: () {
          late final Todo t;
          if (isContainDay(todo.completeDate, todo.expectedDate!)) {
            t = ref.read(todoProvider.notifier).getTodoFromId(todo.id);
          } else {
            t = todo;
          }
          Navigator.pushNamed(
            context,
            AppRouter.detail,
            arguments: TaskDetailPageArgs(todo: t, isCompleted: isCompleted),
          );
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
            InkWell(
              onTap: () {
                ref.read(todoProvider.notifier).onTapWeeklyCheckBox(
                      context: context,
                      today: state.today,
                      pageIndex: widget.index,
                      todo: todo,
                    );
              },
              borderRadius: BorderRadius.circular(100),
              child: Padding(
                padding: const EdgeInsets.all(12),
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
                decoration: BoxDecoration(
                  color: AppColor.thirdColor.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: TimeWidget(
                  todo: todo,
                  today: state.today,
                  pageDate: pageWeekStart,
                  term: TermType.week,
                )),
          ],
        ),
      ),
    );
  }
}
