import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routine_app/pages/home/home_page_state.dart';
import 'package:routine_app/pages/home/widget/next_schedule.dart';
import 'package:routine_app/pages/home/widget/next_schedule_state.dart';
import 'package:routine_app/pages/home/widget/time_widget.dart';
import 'package:routine_app/utils/contextEx.dart';
import 'package:routine_app/utils/date.dart';
import 'package:routine_app/utils/int_ex.dart';
import 'package:routine_app/viewModel/todo_provider.dart';

import '../../../design/app_assets.dart';
import '../../../design/app_color.dart';
import '../../../model/todo.dart';
import '../../../router.dart';
import '../../../services/app_shared.dart';
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

class PageWidgetDay extends ConsumerStatefulWidget {
  const PageWidgetDay({
    required this.index,
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  ConsumerState createState() => _PageWidgetState();
}

class _PageWidgetState extends ConsumerState<PageWidgetDay> {
  late final DateTime pageDay;

  @override
  void didChangeDependencies() {
    final state = ref.watch(homePageStateProvider);
    pageDay = state.today.add(Duration(days: widget.index));
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
    late final List<Todo> todoList;
    final List<int> pastTodoIds = AppShared.shared.getPastTodoIds(ref);
    List<Todo> pastTodoList = [];
    if (widget.index < 0) {
      todoList = ref
          .watch(todoProvider)
          .where((todo) => isContainDay(todo.completeDate, pageDay))
          .toList();
      todoList.sort(compTime);
    } else if (widget.index == 0) {
      todoList = ref
          .watch(todoProvider)
          .where((todo) =>
              (isSameDay(todo.expectedDate, pageDay) ||
                  isContainDay(todo.completeDate, pageDay)) &&
              !pastTodoIds.contains(todo.id))
          .toList();
      todoList.sort(compTime);
      pastTodoList = ref
          .watch(todoProvider)
          .where((todo) => pastTodoIds.contains(todo.id))
          .toList();
      pastTodoList.sort(compExp);
      pastTodoList = pastTodoList.reversed.toList();
    } else {
      todoList = [];
      for (var todo in ref.watch(todoProvider)) {
        if (todo.expectedDate == null) continue;
        if (todo.expectedDate!.isSameDay(pageDay)) {
          todoList.add(todo);
        }
        if (todo.expectedDate!.isBeforeDay(pageDay) &&
            todo.expectedDate!.dateDiff(pageDay) % todo.span == 0) {
          todoList.add(todo.copyWith(expectedDate: () => pageDay));
        }
      }
      todoList.sort(compTime);
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
              'この日のゆるDOと所要時間',
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
            if (pastTodoList.isNotEmpty) ...[
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
                if (state.today.isBeforeDay(pageDay)) {
                  context.showSnackBar(
                    const SnackBar(content: Text('未来のゆるDOは完了できません')),
                  );
                  return;
                }
                if (widget.index < 0) {
                  context.showSnackBar(
                      const SnackBar(content: Text('過去のタスクを実施しなかったことにはできません')));
                  return;
                }
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
                child: TimeWidget(
                  todo: todo,
                  today: state.today,
                  pageDate: pageDay,
                  term: TermType.day,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
