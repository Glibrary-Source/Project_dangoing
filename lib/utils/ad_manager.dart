import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'dart:io' show Platform;

class AdManager {
  static AdManager instance = AdManager();

  AdManagerBannerAd? homeBannerAd;

  AdManager({this.homeBannerAd});

  factory AdManager.init() => instance = AdManager(
      homeBannerAd: _loadBannerAd()
  );
}

AdManagerBannerAd _loadBannerAd() {
  const String androidBannerAdUnitId = 'ca-app-pub-6758764449876389/8327611143';
  const String iosBannerAdUnitId = 'ca-app-pub-3940256099942544/2934735716';

  String adUnitId = androidBannerAdUnitId;
  if (Platform.isIOS) adUnitId = iosBannerAdUnitId;

  return AdManagerBannerAd(
      sizes: [AdSize.banner],
      adUnitId: adUnitId,
      listener: AdManagerBannerAdListener(),
      request: const AdManagerAdRequest())
    ..load();
}
