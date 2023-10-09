import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routine_app/pages/home/home_page_state.dart';
import 'package:routine_app/pages/home/widget/next_schedule/next_schedule.dart';
import 'package:routine_app/pages/home/widget/next_schedule/next_schedule_state.dart';
import 'package:routine_app/pages/home/widget/time_widget.dart';
import 'package:routine_app/pages/taskDetail/task_detail_page_state.dart';
import 'package:routine_app/utils/contextEx.dart';
import 'package:routine_app/utils/date.dart';
import 'package:routine_app/utils/int_ex.dart';
import 'package:routine_app/viewModel/todo_provider.dart';

import '../../../design/app_assets.dart';
import '../../../design/app_color.dart';
import '../../../model/todo.dart';
import '../../../router.dart';
import '../../../viewModel/category_provider.dart';

bool isContainDay(List<DateTime> list, DateTime d) {
  return list.any((e) => e.isSameDay(d));
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
    DateTime? aComp = isContainDay(a.completeDate, pageDay)
        ? a.preExpectedDate
        : a.expectedDate;
    DateTime? bComp = isContainDay(b.completeDate, pageDay)
        ? b.preExpectedDate
        : b.expectedDate;
    return aComp!.compareTo(bComp!);
  }

  int compTime(Todo a, Todo b) {
    return a.time.compareToEx(b.time);
  }

  @override
  Widget build(BuildContext context) {
    late final List<Todo> todoList;
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
              (todo.expectedDate.isSameDay(pageDay) ||
                  isContainDay(todo.completeDate, pageDay)) &&
              !todo.preExpectedDate.isBeforeDay(pageDay))
          .toList();
      todoList.sort(compTime);
      pastTodoList = ref
          .watch(todoProvider)
          .where((todo) =>
              todo.expectedDate.isBeforeDay(pageDay) ||
              todo.preExpectedDate.isBeforeDay(pageDay) &&
                  isContainDay(todo.completeDate, pageDay))
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
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: _taskItem(todo, context),
                );
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
    final isCompleted = isContainDay(todo.completeDate, pageDay);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.secondaryColor,
      ),
      height: 60,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRouter.detail,
            arguments: TaskDetailPageArgs(todo: todo, isCompleted: isCompleted),
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
                  (isCompleted) ? AppAssets.check : AppAssets.uncheck,
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
