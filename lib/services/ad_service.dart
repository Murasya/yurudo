import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  late InterstitialAd _interstitialAd;

  Future<void> showInterstitial() async {
    await FirebaseAnalytics.instance.logAdImpression();
    _interstitialAd.show();
  }

  final unitId = Platform.isAndroid ?
      dotenv.env['ADMOB_ANDROID_UNITID']
      : dotenv.env['ADMOB_IOS_UNITID'];

  void adLoad({
    required VoidCallback onFinish,
  }) {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) =>
                debugPrint('$ad onAdShowedFullScreenContent.'),
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              debugPrint('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
              onFinish();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
            },
            onAdImpression: (InterstitialAd ad) =>
                debugPrint('$ad impression occurred.'),
          );
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }
}
