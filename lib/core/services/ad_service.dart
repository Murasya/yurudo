import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:routine_app/core/services/get_env.dart';

class AdService {
  InterstitialAd? _interstitialAd;

  Future<void> showInterstitial() async {
    await FirebaseAnalytics.instance.logAdImpression();
    _interstitialAd?.show();
  }

  Future<String> get adUnitId => Platform.isAndroid
      ? GetEnv().admobAndroidUnitId
      : GetEnv().admobIosUnitId;

  void adLoad({
    required VoidCallback onFinish,
  }) {
    adUnitId.then((value) =>
        InterstitialAd.load(
          adUnitId: value,
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
            onAdFailedToLoad: (LoadAdError error) {
              Logger().e("InterstitialAd failed to load: $error");
            },
          ),
        ));
  }
}
