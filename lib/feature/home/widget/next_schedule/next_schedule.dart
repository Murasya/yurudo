import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routine_app/core/design/app_assets.dart';
import 'package:routine_app/core/design/app_color.dart';
import 'package:routine_app/core/design/app_style.dart';
import 'package:routine_app/core/utils/contextEx.dart';
import 'package:routine_app/core/utils/date.dart';
import 'package:routine_app/feature/home/widget/select_day_widget.dart';

import '../../../../repository/todo/todo_provider.dart';
import '../next_schedule_close.dart';
import 'next_schedule_state.dart';

class NextSchedule extends ConsumerStatefulWidget {
  final NextScheduleArgs args;

  const NextSchedule({
    required this.args,
    super.key,
  });

  @override
  ConsumerState createState() => _NextScheduleState();
}

class _NextScheduleState extends ConsumerState<NextSchedule> {
  static const double _width = 185;
  late final AutoDisposeStateNotifierProvider<NextScheduleStateNotifier,
      NextScheduleState> provider;

  @override
  void initState() {
    provider = nextScheduleStateProvider(widget.args);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AlertDialog(
          surfaceTintColor: Colors.transparent,
          content: Stack(
            alignment: Alignment.topCenter,
            children: [
              Transform.translate(
                offset: const Offset(0, -70),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Positioned(
                      bottom: 10,
                      child: CustomPaint(
                        painter: HalfCircle(width: _width),
                      ),
                    ),
                    SvgPicture.asset(
                      AppAssets.uncheck,
                      width: 90,
                    ),
                    const Text(
                      'Congratulations!',
                      style: TextStyle(
                        color: AppColor.primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Transform.translate(
                        offset: const Offset(10, 0),
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () async {
                            bool? finish = await showDialog(
                              context: context,
                              builder: (_) => const NextScheduleClose(),
                            );
                            if (finish != null && finish) {
                              ref.read(todoProvider.notifier).complete(
                                    todo: widget.args.todo,
                                    completeDay: widget.args.completeDay,
                                    nextDay: null,
                                  );
                              if (!mounted) return;
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    context.l10n.completeYurudo,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColor.emphasis),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.l10n.setNextYurudo,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 6),
                  Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                      dividerTheme: const DividerThemeData(
                        space: 0,
                      ),
                    ),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.all(0),
                      title: Text(
                        context.l10n.setNextNotToday,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColor.fontColor3,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: SelectDayWidget(
                            label: context.l10n.selectCompleteDay,
                            selectDate: state.completeDay,
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 366)),
                            lastDate: DateTime.now(),
                            onSelectDate: (value) {
                              ref.read(provider.notifier).setCompleteDay(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: SelectDayWidget(
                      label: context.l10n.expectedDate,
                      selectDate: state.selectDay,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 366)),
                      onSelectDate: (value) {
                        ref.read(provider.notifier).changeDate(value);
                      },
                    ),
                  ),
                  if (ref.watch(provider).hasError)
                    Text(
                      ref.watch(provider).errorMessage,
                      style: const TextStyle(
                        color: AppColor.emphasis,
                      ),
                    ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: AppStyle.primaryButton,
                      onPressed: () {
                        if (!ref
                            .read(provider)
                            .selectDay
                            .isAfterDay(widget.args.completeDay)) {
                          ref.read(provider.notifier).setError(
                                true,
                                msg: context.l10n.afterCompleteDay,
                              );
                          return;
                        }
                        ref.read(todoProvider.notifier).complete(
                              todo: widget.args.todo,
                              completeDay: state.completeDay,
                              nextDay: ref.read(provider).selectDay,
                            );
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColor.emphasis,
              textStyle: context.textTheme.bodyMedium!.copyWith(
                fontSize: 13,
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.undoCheck),
          ),
        ),
      ],
    );
  }
}

class HalfCircle extends CustomPainter {
  final double width;

  const HalfCircle({required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final Rect rect = Offset(width / -2, width / -2) & Size(width, width);
    canvas.drawArc(rect, pi, pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
