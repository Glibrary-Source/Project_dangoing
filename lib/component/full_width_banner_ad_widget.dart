import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class FullWidthBannerAdWidget extends StatelessWidget {
  final AdManagerBannerAd? bannerAd;
  final double sidePadding;

  const FullWidthBannerAdWidget({super.key, required this.bannerAd, this.sidePadding = 0});

  @override
  Widget build(BuildContext context) {
    if(bannerAd != null) {
      return SizedBox(
        width: MediaQuery.sizeOf(context).width - sidePadding * 2,
        height: bannerAd!.sizes.first.height.toDouble(),
        child: AdWidget(ad: bannerAd!),
      );
    } else {
      return const SizedBox(width: 0, height: 0,);
    }
  }
}
