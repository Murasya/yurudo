import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/design/app_color.dart';
import 'package:routine_app/pages/widget/categoryDialog/category_dialog_state.dart';
import 'package:routine_app/pages/widget/dialog_common.dart';
import 'package:routine_app/utils/contextEx.dart';

import '../../../model/category.dart';
import '../../../viewModel/category_provider.dart';

class CategoryDialog extends ConsumerStatefulWidget {
  final Category? defaultValue;
  final void Function(Category? value) onConfirm;

  const CategoryDialog({
    required this.defaultValue,
    required this.onConfirm,
    super.key,
  });

  @override
  ConsumerState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends ConsumerState<CategoryDialog> {
  late List<Category> categoryList;
  late List<TextEditingController> nameController;
  late final provider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryList = ref.watch(categoryProvider);
    final selectCategoryNum = widget.defaultValue != null
        ? categoryList.indexOf(widget.defaultValue!)
        : null;
    provider = categoryDialogStateProvider(selectCategoryNum);
    nameController = List.generate(
      categoryList.length,
      (index) => TextEditingController(text: categoryList[index].name),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);

    return DialogCommon(
      title: '分類を選択してください',
      onPressed: () {
        if (state.selectButtonNum != null) {
          widget.onConfirm(ref.read(categoryProvider)[state.selectButtonNum]);
        } else {
          widget.onConfirm(null);
        }
      },
      content: Column(children: [
        for (var i = 0; i < categoryList.length; i++)
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: categoryList[i].color,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          // width: MediaQuery.of(context).size.width - 200,
                          child: TextField(
                            controller: nameController[i],
                            decoration: const InputDecoration(
                              hintText: '好きな分類名をつけられます',
                              hintStyle: TextStyle(
                                fontSize: 14,
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              ref
                                  .read(categoryProvider.notifier)
                                  .setCategoryName(i, value);
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color(0xFF40402F),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: const Size(64, 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: (state.selectButtonNum == null ||
                          state.selectButtonNum != i)
                      ? AppColor.secondaryColor
                      : AppColor.primary,
                ),
                onPressed: () {
                  if (state.selectButtonNum == i) {
                    ref.read(provider.notifier).setSelectButtonNum(null);
                  } else {
                    ref.read(provider.notifier).setSelectButtonNum(i);
                  }
                },
                child: Text(
                  '選択',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: (state.selectButtonNum == null ||
                              state.selectButtonNum != i)
                          ? AppColor.primary
                          : AppColor.backgroundColor),
                ),
              ),
            ],
          ),
      ]),
    );
  }
}

class CategoryTextField extends ConsumerWidget {
  const CategoryTextField({
    this.category,
    this.onTap,
    super.key,
  });

  final Category? category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('分類'),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              if (category != null)
                Transform.translate(
                  offset: const Offset(0, 1),
                  child: Container(
                    width: 8,
                    height: 14,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: category!.color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              Expanded(
                child: Text(
                  category?.name ?? 'なし',
                  style: context.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: AppColor.fontColor,
          height: 12.0,
          thickness: 1.0,
        ),
      ],
    );
  }
}
