import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/feature/signIn/vo/sign_in_state.dart';
import 'package:routine_app/core/utils/contextEx.dart';
import 'package:routine_app/core/design/app_color.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../repository/todo/todo_provider.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notifier = ref.watch(signInProvider.notifier);
    var state = ref.watch(signInProvider);

    Widget body() {
      if (state.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.user == null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'バックアップを行うにはログインが必要です',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SignInButton(
              Buttons.google,
              onPressed: () async {
                try {
                  await notifier.onTapSignIn();
                } on Exception catch (ex) {
                  context.showSnackBar(
                    SnackBar(
                      content: Text(ex.toString()),
                    ),
                  );
                }
              },
            )
          ],
        );
      } else {
        return ListView(
          children: [
            ListTile(
              title: const Text('データのバックアップ'),
              onTap: () {
                notifier.onTapBackup().then(
                      (isSuccess) => isSuccess
                          ? context.showSnackBar(
                              const SnackBar(
                                content: Text('バックアップに成功しました'),
                              ),
                            )
                          : context.showSnackBar(
                              const SnackBar(
                                content: Text('バックアップに失敗しました'),
                              ),
                            ),
                    );
              },
            ),
            ListTile(
              title: const Text('データの復元'),
              subtitle: const Text('※今のデータは消え、バックアップデータに上書きされます'),
              onTap: () {
                notifier
                    .onTapRestore(
                      refresh: () => ref.watch(todoProvider.notifier).getAll(),
                    )
                    .then(
                      (isSuccess) => isSuccess
                          ? context.showSnackBar(
                              const SnackBar(
                                content: Text('復元に成功しました'),
                              ),
                            )
                          : context.showSnackBar(
                              const SnackBar(
                                content: Text('復元に失敗しました'),
                              ),
                            ),
                    );
              },
            ),
            ListTile(
              title: const Text('ログアウト'),
              onTap: () {
                notifier.onTapSignOut().then(
                      (value) => context.showSnackBar(
                        const SnackBar(
                          content: Text('ログアウトしました'),
                        ),
                      ),
                    );
              },
            ),
          ],
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'バックアップ',
          style: context.textTheme.titleMedium,
        ),
        backgroundColor: AppColor.secondaryColor,
        leading: IconButton(
          iconSize: 30,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: body(),
    );
  }
}
