import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routine_app/core/design/app_assets.dart';
import 'package:routine_app/core/design/app_color.dart';
import 'package:routine_app/core/utils/contextEx.dart';
import 'package:routine_app/core/utils/int_ex.dart';
import 'package:routine_app/feature/home/widget/time_widget.dart';

import '../../../core/navigation/router.dart';
import '../../../repository/category/category_provider.dart';
import '../../../repository/todo/todo.dart';
import '../../../repository/todo/todo_provider.dart';
import '../../taskDetail/task_detail_page_state.dart';
import '../home_page_state.dart';

class PageWidgetDay extends ConsumerStatefulWidget {
  const PageWidgetDay({
    required this.index,
    super.key,
  });

  final int index;

  @override
  ConsumerState createState() => _PageWidgetState();
}

class _PageWidgetState extends ConsumerState<PageWidgetDay> {
  late final DateTime pageDay;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final state = ref.watch(homePageStateProvider);
      pageDay = state.today.add(Duration(days: widget.index));
    }
    _isInit = false;
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
      todoList = ref.read(todoProvider.notifier).getTodosFromDate(pageDay);
    } else if (widget.index == 0) {
      todoList = ref.read(todoProvider.notifier).getTodayTodos(pageDay);
      pastTodoList = ref.read(todoProvider.notifier).getPastTodos(pageDay);
    } else {
      todoList = ref.read(todoProvider.notifier).getFutureTodos(pageDay);
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
              context.l10n.todayYurudo,
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
                context.l10n.pastYurudo,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: pastTodoList.length,
                itemBuilder: (context, index) {
                  var todo = pastTodoList[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: _taskItem(todo, context),
                  );
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
            InkWell(
              onTap: () {
                ref.read(todoProvider.notifier).onTapDailyCheckBox(
                      context: context,
                      today: state.today,
                      pageIndex: widget.index,
                      todo: todo,
                    );
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: const EdgeInsets.all(12),
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
              decoration: BoxDecoration(
                color: AppColor.thirdColor.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
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
