import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/design/app_text_field.dart';
import 'package:routine_app/model/category.dart';
import 'package:routine_app/model/todo.dart';
import 'package:routine_app/pages/widget/date_dialog.dart';
import 'package:routine_app/pages/widget/span_dialog.dart';
import 'package:routine_app/pages/widget/time_dialog.dart';
import 'package:routine_app/router.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:routine_app/viewModel/category_provider.dart';
import 'package:routine_app/viewModel/todo_provider.dart';

import 'widget/category_dialog.dart';

// final categoryStringProvider =
// Provider.autoDispose<TextEditingController>((ref) {
//   List<bool> selectCategory = ref.watch(selectCategoryProvider);
//   List<Category> categoryList = ref.watch(categoryProvider);
//   String str = '';
//   for (int i = 0; i < categoryList.length; i++) {
//     if (selectCategory[i]) str += categoryList[i].name;
//   }
//   return TextEditingController(text: str);
// });
//
// final selectCategoryIdsProvider =
// Provider.autoDispose<List<Color>>((ref) {
//   List<bool> selectCategory = ref.watch(selectCategoryProvider);
//   List<Category> categoryList = ref.watch(categoryProvider);
//   List<Color> selectIds = [];
//   for (int i = 0; i < categoryList.length; i++) {
//     if (selectCategory[i]) selectIds.add(categoryList[i].categoryId);
//   }
//   return selectIds;
// });
//
// final selectCategoryProvider =
// StateNotifierProvider<SelectCategoryNotifier, List<bool>>((ref) {
//   return SelectCategoryNotifier();
// });
//
// class SelectCategoryNotifier extends StateNotifier<List<bool>> {
//   SelectCategoryNotifier() : super(List.generate(5, (index) => false));
//
//   void toggleStatus(int index) {
//     state = [
//       for (int i = 0; i < state.length; i++)
//         if (i == index) !state[i] else
//           state[i]
//     ];
//   }
// }

class NewTaskPage extends ConsumerStatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends ConsumerState<NewTaskPage> {
  String _taskTitle = "";
  int _span = 1;
  bool _remind = false;
  int _time = 0;
  Category selectCategory = Category.defaultValue;
  late TextEditingController _spanController;
  late TextEditingController _timeController;
  late TextEditingController _categoryController;
  late TextEditingController _dateController;
  DateTime startDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _spanController = TextEditingController();
    _timeController = TextEditingController();
    _categoryController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _spanController.dispose();
    _timeController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
    // ref.invalidate(selectCategoryProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規タスク'),
        actions: [
          TextButton(
            onPressed: () {
              Todo newTodo = Todo(
                name: _taskTitle,
                span: _span,
                remind: _remind,
                categoryId: [selectCategory.categoryId],
                time: _time,
                date: startDate,
                beginDate: startDate,
              );
              ref.read(todoProvider.notifier).add(newTodo);
              Navigator.pushNamed(context, AppRouter.interstitialAd);
            },
            child: const Text(
              '作成終了',
              style: TextStyle(color: Color(0xFFFFFFFF)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AppTextField(
              onChanged: (value) {
                setState(() {
                  _taskTitle = value;
                });
              },
              placeholder: 'タイトルを追加',
            ),
            AppTextField(
              controller: _spanController,
              onTap: () {
                SpanDialog(
                  onConfirm: (picker, value) {
                    var ans = picker.getSelectedValues();
                    _spanController.text = '${ans[0]}${ans[1]}に一回';
                    switch (ans[1]) {
                      case 1:
                        _span = ans[0] * 7;
                        break;
                      default:
                        _span = ans[0];
                        break;
                    }
                  },
                ).showDialog(context);
              },
              placeholder: 'スパンを設定',
            ),
            CheckboxListTile(
              value: _remind,
              title: const Text('リマインドする'),
              onChanged: (value) {
                setState(() {
                  _remind = value!;
                });
              },
            ),
            AppTextField(
              controller: _categoryController,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CategoryDialog(
                    defaultValue: selectCategory,
                    onConfirm: (value) {
                      selectCategory = value;
                      _categoryController.text = value.name;
                    }
                  ),
                );
              },
              placeholder: '分類を設定',
            ),
            AppTextField(
              controller: _timeController,
              onTap: () {
                TimeDialog(
                  onConfirm: (picker, value) {
                    var ans = picker.getSelectedValues();
                    switch (ans[1]) {
                      case 1:
                        _time = ans[0] * 60;
                        break;
                      default:
                        _time = ans[0];
                        break;
                    }
                    _timeController.text = '${ans[0]}${ans[1]}';
                  },
                ).showDialog(context);
              },
              placeholder: '要する時間設定',
            ),
            AppTextField(
              controller: _dateController,
              onTap: () {
                DateDialog(
                  onConfirm: (picker, value) {
                    startDate =
                    (picker.adapter as DateTimePickerAdapter).value!;
                    _dateController.text =
                    '${startDate.year}年${startDate.month}月${startDate.day}日';
                  },
                ).showDialog(context);
              },
              placeholder: '開催日を設定',
            ),
          ],
        ),
      ),
    );
  }
}
