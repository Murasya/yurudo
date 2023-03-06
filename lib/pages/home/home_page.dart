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

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dateFormat.format(
                        state.pageDate.subtract(const Duration(days: 1))),
                    style: const TextStyle(
                      color: AppColor.fontColor,
                      fontSize: 18,
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
                  Text(
                    dateFormat
                        .format(state.pageDate.add(const Duration(days: 1))),
                    style: const TextStyle(
                      color: AppColor.fontColor,
                      fontSize: 18,
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
              text: '日',
              isActive: true,
            ),
            const SizedBox(width: 12),
            displayChangeButton(
              text: '週',
              isActive: false,
            ),
            const SizedBox(width: 12),
            displayChangeButton(
              text: '月',
              isActive: false,
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
                  drawerItem(text: 'フィードバック / お問い合わせ'),
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

  Widget _page(int index, List<Todo> todoList) {
    final state = ref.watch(provider);
    DateTime pageDay = state.today.add(Duration(days: index));
    List<Todo> todayTask = todoList
        .where((todo) => todo.date.any((e) => isSameDay(e, pageDay)))
        .toList();
    List<Todo> pastTask = todoList.where((todo) {
      final notCompleteIndex = todo.isCompleted.indexOf(false);
      return todoList.indexOf(todo) < notCompleteIndex;
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
            const Text(
              'この日の ゆるDO',
              style: TextStyle(
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
                return _taskItem(todo);
              },
            ),
            if (index == 0 && pastTask.isNotEmpty) ...[
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
                  return _taskItem(todo);
                },
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _taskItem(Todo todo) {
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // if (!todo.isCompleted) {
                //   ref.read(todoProvider.notifier).complete(todo);
                // }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SvgPicture.asset(
                  (todo.isCompleted[0]) ? AppAssets.check : AppAssets.uncheck,
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
                child: Row(
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
                ),
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
    required String text,
    bool isActive = false,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColor.primaryColor : AppColor.secondaryColor,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isActive ? AppColor.backgroundColor : AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}
