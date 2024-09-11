import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routine_app/core/design/app_assets.dart';
import 'package:routine_app/core/design/app_color.dart';
import 'package:routine_app/core/design/app_style.dart';
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
        title: Text(
          context.l10n.feedback,
          style: const TextStyle(
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
              contentWidget(context),
              mailWidget(context),
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
                  child: Text(context.l10n.submit),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contentWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              context.l10n.content,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.fontColor,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              context.l10n.required,
              style: const TextStyle(
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
                hintText: '${context.l10n.pleaseInput}\n\n\n\n\n\n',
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

  Widget mailWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              context.l10n.mailAddress,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.fontColor,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              context.l10n.mailAddressInfo,
              style: const TextStyle(
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
          decoration: InputDecoration(
            hintText: context.l10n.pleaseInput,
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
        errorMessage = context.l10n.mailAddressInvalid;
      });
      return;
    }
    final Email email = Email(
      body: '''
${context.l10n.submitAsIs}

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
                Text(
                  context.l10n.sendFeedback,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
                    child: Text(context.l10n.close),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
