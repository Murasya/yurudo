import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/category.dart';
import '../../viewModel/category_provider.dart';

class CategoryDialog extends ConsumerStatefulWidget {
  final Category? defaultValue;
  final void Function(Category value) onConfirm;

  const CategoryDialog({
    required this.defaultValue,
    required this.onConfirm,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends ConsumerState<CategoryDialog> {
  late int? selectCategoryNum;
  late List<Category> categoryList;
  late List<TextEditingController> nameController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryList = ref.watch(categoryProvider);
    selectCategoryNum = widget.defaultValue != null
        ? categoryList.indexOf(widget.defaultValue!)
        : null;
    nameController = List.generate(
      categoryList.length,
      (index) => TextEditingController(text: categoryList[index].name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('分類設定'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            if (selectCategoryNum != null) {
              widget.onConfirm(ref.read(categoryProvider)[selectCategoryNum!]);
            }
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
      content: Column(
        children: [
          for (var i = 0; i < categoryList.length; i++)
            Row(
              children: [
                Container(
                  height: 12,
                  width: 12,
                  color: categoryList[i].categoryId,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: TextField(
                    controller: nameController[i],
                    style: TextStyle(color: categoryList[i].categoryId),
                    onChanged: (value) {
                      ref
                          .read(categoryProvider.notifier)
                          .setCategoryName(i, value);
                    },
                  ),
                ),
                Radio<int>(
                  value: i,
                  onChanged: (value) {
                    setState(() => selectCategoryNum = value!);
                  },
                  groupValue: selectCategoryNum,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
