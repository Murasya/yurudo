import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/design/app_color.dart';
import 'package:routine_app/model/todo.dart';
import 'package:routine_app/pages/home/home_page_state.dart';
import 'package:routine_app/router.dart';
import 'package:routine_app/viewModel/todo_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final DateTime _today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homePageStateProvider);

    return Scaffold(
      appBar: AppBar(),
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
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRouter.newTask);
        },
        child: const Icon(Icons.add),
      ),
      body: PageView.builder(itemBuilder: (context, index) {
        return _page(index, state.todoList);
      }),
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Widget _page(int index, List<Todo> todoList) {
    DateTime pageDay = _today.add(Duration(days: index));

    List<Todo> todayTask =
        todoList.where((todo) => isSameDay(todo.date, pageDay)).toList();
    List<Todo> pastTask = todoList
        .where((todo) =>
            !isSameDay(todo.date, _today) &&
            todo.date.isBefore(_today) &&
            !todo.isCompleted)
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          Text((index == 0)
              ? '〜今日のタスク〜'
              : '〜${pageDay.month}/${pageDay.day}のタスク〜'),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: todayTask.length,
              itemBuilder: (context, index) {
                var todo = todayTask[index];
                return _taskItem(todo);
              },
            ),
          ),
          if (index == 0) ...[
            const Text('〜実施日すぎたタスク〜'),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: pastTask.length,
                itemBuilder: (context, index) {
                  var todo = pastTask[index];
                  return _taskItem(todo);
                },
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _taskItem(Todo todo) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF000000),
        ),
        color: todo.categoryId.isNotEmpty
            ? todo.categoryId.first
            : AppColor.categoryDefault,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRouter.detail, arguments: todo);
        },
        child: Row(
          children: [
            Checkbox(
              value: todo.isCompleted,
              onChanged: (isCheck) {
                if (isCheck != null && isCheck) {
                  ref.read(todoProvider.notifier).complete(todo);
                }
              },
            ),
            Expanded(child: Text(todo.name)),
            Text('id: ${todo.id}, ${todo.time} min'),
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
}
