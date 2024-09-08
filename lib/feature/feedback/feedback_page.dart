import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routine_app/core/design/app_assets.dart';
import 'package:routine_app/core/design/app_style.dart';
import 'package:routine_app/core/design/app_color.dart';
import 'package:routine_app/core/utils/contextEx.dart';

import '../../core/navigation/router.dart';

class FeedbackPage extends ConsumerStatefulWidget {
  const FeedbackPage({
    super.key,
  });

  @override
  ConsumerState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends ConsumerState<FeedbackPage> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'フィードバック / お問い合わせ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColor.secondaryColor,
        foregroundColor: AppColor.fontColor,
        leading: IconButton(
          iconSize: 30,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              contentWidget(),
              mailWidget(),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: AppStyle.primaryButton.copyWith(
                    backgroundColor:
                        const WidgetStatePropertyAll(AppColor.primary),
                  ),
                  onPressed: () {
                    _sendEmail(context);
                  },
                  child: const Text('送信'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contentWidget() {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              '内容',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.fontColor,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '※必須',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: AppColor.emphasis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 184,
          child: TextField(
            controller: _contentController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: AppColor.fontColor,
            ),
            decoration: InputDecoration(
                hintText: '入力してください\n\n\n\n\n\n',
                contentPadding: const EdgeInsets.all(12),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
          ),
        ),
      ],
    );
  }

  Widget mailWidget() {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'メールアドレス',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.fontColor,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '※返信をご希望の場合はご入力ください',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: AppColor.emphasis,
              ),
            ),
          ],
        ),
        TextField(
          controller: _emailController,
          onChanged: (_) {
            setState(() {
              errorMessage = '';
            });
          },
          style: const TextStyle(
            fontSize: 14,
          ),
          decoration: const InputDecoration(
            hintText: '入力してください',
          ),
        ),
        if (errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorMessage,
              style: const TextStyle(
                fontSize: 14,
                color: AppColor.emphasis,
              ),
            ),
          ),
        const SizedBox(height: 40),
      ],
    );
  }

  Future<void> _sendEmail(BuildContext context) async {
    bool emailValid = RegExp(r"[\w\-._]+@[\w\-._]+\.[A-Za-z]+")
        .hasMatch(_emailController.text);
    if (_emailController.text.isNotEmpty && !emailValid) {
      setState(() {
        errorMessage = 'メールアドレスが不正です';
      });
      return;
    }
    final Email email = Email(
      body: '''
このまま送信してください。

${_contentController.text}

返信先：${_emailController.text}      
''',
      subject: 'ゆるDOお問い合わせ',
      recipients: ['noteappm@gmail.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      if (!mounted) return;
      sentOverlay(context);
    } catch (e) {
      context.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void sentOverlay(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRouter.home,
                          (_) => false,
                        );
                      },
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Text(
                  'フィードバック/お問い合わせを\n送信しました',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.fontColor,
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.uncheck,
                      width: 200,
                      height: 145,
                    ),
                    const Text(
                      'Thank you very much !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.primary,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: AppStyle.primaryButton.copyWith(
                      backgroundColor:
                          const WidgetStatePropertyAll(AppColor.primary),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouter.home,
                        (_) => false,
                      );
                    },
                    child: const Text('閉じる'),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
