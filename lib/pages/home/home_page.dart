import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/design/app_assets.dart';
import 'package:routine_app/design/app_color.dart';
import 'package:routine_app/model/todo.dart';
import 'package:routine_app/pages/home/home_page_state.dart';
import 'package:routine_app/router.dart';
import 'package:routine_app/services/notification_service.dart';
import 'package:routine_app/viewModel/category_provider.dart';

import '../../viewModel/todo_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final dateFormat = DateFormat('M/d');
  final provider = homePageStateProvider;

  @override
  void initState() {
    initializeDateFormatting('ja');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    NotificationService().setNotifications(state.todoList);

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.displayTerm == TermType.day)
                    Text(
                      dateFormat.format(
                          state.pageDate.subtract(const Duration(days: 1))),
                      style: const TextStyle(
                        color: AppColor.fontColor,
                        fontSize: 18,
                      ),
                    ),
                  if (state.displayTerm != TermType.day)
                    Text(
                      '前の${state.displayTerm.displayName}',
                      style: const TextStyle(
                        color: AppColor.fontColor,
                        fontSize: 14,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 24),
                    child: SvgPicture.asset(
                      AppAssets.triangle,
                      width: 14,
                    ),
                  ),
                  Container(
                    width: 144,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.primaryColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state.displayTerm == TermType.day) ...[
                          Text(
                            dateFormat.format(state.pageDate),
                            style: const TextStyle(
                              color: AppColor.backgroundColor,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            '(${DateFormat.E('ja').format(state.pageDate)})',
                            style: const TextStyle(
                              color: AppColor.backgroundColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                        if (state.displayTerm == TermType.week) ...[
                          Text(
                            '${DateFormat('M/d').format(state.pageDate)}~${state.pageDate.add(const Duration(days: 7)).day}',
                            style: const TextStyle(
                              color: AppColor.backgroundColor,
                              fontSize: 24,
                            ),
                          ),
                        ],
                        if (state.displayTerm == TermType.month) ...[
                          Text(
                            DateFormat('y/M').format(state.pageDate),
                            style: const TextStyle(
                              color: AppColor.backgroundColor,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 16),
                    child: Transform.rotate(
                      angle: pi,
                      child: SvgPicture.asset(
                        AppAssets.triangle,
                        width: 14,
                      ),
                    ),
                  ),
                  if (state.displayTerm == TermType.day)
                    Text(
                      dateFormat
                          .format(state.pageDate.add(const Duration(days: 1))),
                      style: const TextStyle(
                        color: AppColor.fontColor,
                        fontSize: 18,
                      ),
                    ),
                  if (state.displayTerm != TermType.day)
                    Text(
                      '次の${state.displayTerm.displayName}',
                      style: const TextStyle(
                        color: AppColor.fontColor,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              const Divider(
                height: 0.4,
                color: AppColor.lineColor,
              ),
            ],
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            displayChangeButton(
              term: TermType.day,
              isActive: state.displayTerm == TermType.day,
            ),
            const SizedBox(width: 12),
            displayChangeButton(
              term: TermType.week,
              isActive: state.displayTerm == TermType.week,
            ),
            const SizedBox(width: 12),
            displayChangeButton(
              term: TermType.month,
              isActive: state.displayTerm == TermType.month,
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: AppColor.fontColor),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 50),
              child: Column(
                children: [
                  drawerItem(text: '利用規約', hasIcon: true),
                  drawerItem(text: 'プライバシーポリシー', hasIcon: true),
                  drawerItem(
                    text: 'フィードバック / お問い合わせ',
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouter.feedback),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.newTask);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.plus,
              ),
              const SizedBox(width: 16),
              const Text(
                '新しいゆるDOを作成',
                style: TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
      body: PageView.builder(onPageChanged: (index) {
        ref.read(provider.notifier).changeDay(index);
      }, itemBuilder: (context, index) {
        return _page(index, state.todoList);
      }),
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool isBeforeDay(DateTime a, DateTime b) {
    return !isSameDay(a, b) && a.isBefore(b);
  }

  /// 各日のページ
  Widget _page(int index, List<Todo> todoList) {
    final state = ref.watch(provider);
    DateTime pageDay =
        state.today.add(Duration(days: index * state.displayTerm.term));
    List<Todo> todayTask = todoList
        .where((todo) => todo.date.any((e) => isSameDay(e, pageDay)))
        .toList();
    List<Todo> pastTask = todoList.where((todo) {
      final notCompleteIndex = todo.isCompleted.indexOf(false);
      return isBeforeDay(todo.date[notCompleteIndex], DateTime.now());
    }).toList();

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
              'この${state.displayTerm.displayName}の ゆるDO',
              style: const TextStyle(
                color: AppColor.fontColor,
                fontSize: 14,
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: todayTask.length,
              itemBuilder: (context, index) {
                var todo = todayTask[index];
                return _taskItem(todo, pageDay);
              },
            ),
            if (index == 0 &&
                pastTask.isNotEmpty &&
                state.displayTerm == TermType.day) ...[
              const SizedBox(height: 38),
              const Text(
                '実施が遅れている ゆるDO',
                style: TextStyle(
                  color: AppColor.fontColor,
                  fontSize: 14,
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: pastTask.length,
                itemBuilder: (context, index) {
                  var todo = pastTask[index];
                  return _taskItem(todo, pageDay);
                },
              ),
            ],
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  /// それぞれのタスク
  Widget _taskItem(Todo todo, DateTime pageDay) {
    final state = ref.watch(provider);
    final index = todo.date.indexWhere((d) => isSameDay(d, pageDay));

    Widget timeWidget() {
      final now = DateTime.now();
      final unCompleteIndex = todo.isCompleted.indexOf(false);
      if (index == -1) {
        String num = (todo.date[unCompleteIndex].difference(now).inDays < 30)
            ? '~1'
            : '1';
        String suf = (todo.date[unCompleteIndex].difference(now).inDays < 7)
            ? '週間'
            : (todo.date.last.difference(now).inDays < 30)
                ? 'か月'
                : 'か月超';
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              num,
              style: const TextStyle(
                fontSize: 22,
                color: AppColor.emphasisColor,
              ),
            ),
            Text(
              suf,
              style: const TextStyle(
                fontSize: 14,
                color: AppColor.emphasisColor,
              ),
            )
          ],
        );
      }
      if (state.displayTerm == TermType.day) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${todo.time}',
              style: const TextStyle(
                color: AppColor.fontColor2,
                fontSize: 22,
              ),
            ),
            const Text(
              '分',
              style: TextStyle(
                color: AppColor.fontColor2,
                fontSize: 14,
              ),
            ),
          ],
        );
      } else {
        return Text(
          DateFormat('M/d').format(todo.date.first),
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
                if (index == -1 || !todo.isCompleted[index]) {
                  debugPrint('complete!');
                  ref.read(todoProvider.notifier).complete(
                        todo: todo,
                        completeDay: state.pageDate,
                        nextDay: state.pageDate.add(Duration(days: todo.span)),
                      );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SvgPicture.asset(
                  (index != -1 && todo.isCompleted[index])
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

  Widget drawerItem({
    required String text,
    bool hasIcon = false,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(text),
              const SizedBox(width: 4),
              if (hasIcon) const Icon(Icons.open_in_new),
            ],
          ),
        ),
        const SizedBox(height: 35),
      ],
    );
  }

  Widget displayChangeButton({
    required TermType term,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(provider.notifier).changeTerm(term);
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? AppColor.primaryColor : AppColor.secondaryColor,
        ),
        child: Center(
          child: Text(
            term.displayName,
            style: TextStyle(
              fontSize: 14,
              color:
                  isActive ? AppColor.backgroundColor : AppColor.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
