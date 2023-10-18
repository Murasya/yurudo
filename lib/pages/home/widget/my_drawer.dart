import 'package:flutter/material.dart';
import 'package:routine_app/utils/contextEx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../design/app_color.dart';
import '../../../router.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
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
                  drawerMain(
                    text: 'ホーム',
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouter.home,
                        (route) => route.settings.name == AppRouter.home,
                      );
                    },
                  ),
                  drawerMain(
                    text: 'ゆるDO一覧',
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouter.list,
                        (route) => route.settings.name == AppRouter.list,
                      );
                    },
                  ),
                  if (const String.fromEnvironment("flavor") == "dev")
                    drawerMain(
                      text: 'デバッグメニュー',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRouter.debug,
                        );
                      },
                    ),
                ],
              ),
            ),
            // drawerItem(
            //   text: 'アプリの使い方',
            // ),
            drawerItem(
              text: 'フィードバック / お問い合わせ',
              onTap: () => Navigator.pushNamed(context, AppRouter.feedback),
            ),
            drawerItem(
              text: '利用規約',
              hasIcon: true,
              onTap: () => launchUrlString(
                  "https://docs.google.com/document/d/1cUHk1Fe2MVvRZY0MNzgKhJCMityXPQiZ8lwAEgZoDWs/edit?usp=sharing"),
            ),
            drawerItem(
              text: 'プライバシーポリシー',
              hasIcon: true,
              onTap: () => launchUrlString(
                  "https://docs.google.com/document/d/15JC1IkhR7aRr59sCZ5BACsxsVu15Pd2umM8VIwZqWRE/edit?usp=sharing"),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerMain({
    required String text,
    VoidCallback? onTap,
  }) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 24,
                margin: const EdgeInsets.only(left: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColor.bannerColor,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget drawerItem({
    required String text,
    bool hasIcon = false,
    VoidCallback? onTap,
  }) {
    return Builder(builder: (context) {
      return Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  const SizedBox(width: 40),
                  Text(
                    text,
                    style: context.textTheme.bodySmall,
                  ),
                  const SizedBox(width: 4),
                  if (hasIcon) const Icon(Icons.open_in_new),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
