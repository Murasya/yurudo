import 'package:flutter/material.dart';
import 'package:routine_app/router.dart';

class InterstitialAd extends StatelessWidget {
  const InterstitialAd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((value) => Navigator.popUntil(context, (route) => route.settings.name == AppRouter.home));
    return Container(
      child: Text('広告'),
    );
  }
}
