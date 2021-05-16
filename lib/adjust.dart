//
//  adjust_sdk.dart
//  Adjust SDK
//
//  Created by Srdjan Tubin (@2beens) on 25th April 2018.
//  Copyright (c) 2018-2021 Adjust GmbH. All rights reserved.
//

import 'dart:async';

import 'package:adjust_sdk/adjust_app_store_subscription.dart';
import 'package:adjust_sdk/adjust_attribution.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:adjust_sdk/adjust_play_store_subscription.dart';
import 'package:adjust_sdk/adjust_third_party_sharing.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

const MethodChannel _channel = const MethodChannel('com.adjust.sdk/api');
const String _sdkPrefix = 'flutter4.28.0';

class Adjust {
  const Adjust._();

  static final Adjust instance = Adjust._();

  Future<void> start(AdjustConfig config) async {
    config.sdkPrefix = _sdkPrefix;
    await _channel.invokeMethod('start', config.toMap);
  }

  Future<void> trackEvent(AdjustEvent event) async {
    await _channel.invokeMethod('trackEvent', event.toMap);
  }

  Future<void> setEnabled(bool isEnabled) async {
    await _channel.invokeMethod('setEnabled', {'isEnabled': isEnabled});
  }

  Future<void> setOfflineMode(bool isOffline) async {
    await _channel.invokeMethod('setOfflineMode', {'isOffline': isOffline});
  }

  Future<void> setPushToken(String token) async {
    await _channel.invokeMethod('setPushToken', {'pushToken': token});
  }

  Future<void> setReferrer(String referrer) async {
    _channel.invokeMethod('setReferrer', {'referrer': referrer});
  }

  Future<void> appWillOpenUrl(String url) async {
    await _channel.invokeMethod('appWillOpenUrl', {'url': url});
  }

  Future<void> sendFirstPackages() async {
    await _channel.invokeMethod('sendFirstPackages');
  }

  Future<void> gdprForgetMe() async {
    await _channel.invokeMethod('gdprForgetMe');
  }

  Future<void> disableThirdPartySharing() async {
    await _channel.invokeMethod('disableThirdPartySharing');
  }

  Future<void> onResume() async {
    await _channel.invokeMethod('onResume');
  }

  Future<void> onPause() async {
    await _channel.invokeMethod('onPause');
  }

  Future<bool> isEnabled() async {
    final bool isEnabled = await _channel.invokeMethod('isEnabled');
    return isEnabled;
  }

  // Return value could be `null`
  Future<String?> getAdid() async {
    final String? adid = await _channel.invokeMethod('getAdid');
    return adid;
  }

  Future<String?> getIdfa() async {
    final String? idfa = await _channel.invokeMethod('getIdfa');
    return idfa;
  }

  Future<String?> getAmazonAdId() async {
    final String? amazonAdId = await _channel.invokeMethod('getAmazonAdId');
    return amazonAdId;
  }

  Future<String?> getGoogleAdId() async {
    final String? googleAdId = await _channel.invokeMethod('getGoogleAdId');
    return googleAdId;
  }

  Future<num?>
      requestTrackingAuthorizationWithCompletionHandler() async {
    final num? status = await _channel
        .invokeMethod('requestTrackingAuthorizationWithCompletionHandler');
    return status;
  }

  Future<int?> getAppTrackingAuthorizationStatus() async {
    final int? authorizationStatus =
        await _channel.invokeMethod('getAppTrackingAuthorizationStatus');
    return authorizationStatus;
  }

  Future<AdjustAttribution> getAttribution() async {
    final dynamic attributionMap =
        await _channel.invokeMethod('getAttribution');
    return AdjustAttribution.fromMap(attributionMap);
  }

  Future<String> getSdkVersion() async {
    final String sdkVersion = await _channel.invokeMethod('getSdkVersion');
    return _sdkPrefix + '@' + sdkVersion;
  }

  Future<void> addSessionCallbackParameter(String key, String value) async {
    await _channel.invokeMethod(
        'addSessionCallbackParameter', {'key': key, 'value': value});
  }

  Future<void> addSessionPartnerParameter(String key, String value) async {
    await _channel.invokeMethod(
        'addSessionPartnerParameter', {'key': key, 'value': value});
  }

  Future<void> removeSessionCallbackParameter(String key) async {
    await _channel.invokeMethod('removeSessionCallbackParameter', {'key': key});
  }

  Future<void> removeSessionPartnerParameter(String key) async {
    await _channel.invokeMethod('removeSessionPartnerParameter', {'key': key});
  }

  Future<void> resetSessionCallbackParameters() async {
    await _channel.invokeMethod('resetSessionCallbackParameters');
  }

  Future<void> resetSessionPartnerParameters() async {
    await _channel.invokeMethod('resetSessionPartnerParameters');
  }

  static void trackAdRevenue(String source, String payload) async {
    await _channel
        .invokeMethod('trackAdRevenue', {'source': source, 'payload': payload});
  }

  Future<void> trackAppStoreSubscription(
      AdjustAppStoreSubscription subscription) async {
    await _channel.invokeMethod(
        'trackAppStoreSubscription', subscription.toMap);
  }

  Future<void> trackPlayStoreSubscription(
      AdjustPlayStoreSubscription subscription) async {
    await _channel.invokeMethod(
        'trackPlayStoreSubscription', subscription.toMap);
  }

  Future<void> trackThirdPartySharing(
      AdjustThirdPartySharing thirdPartySharing) async {
    await _channel.invokeMethod(
        'trackThirdPartySharing', thirdPartySharing.toMap);
  }

  Future<void> trackMeasurementConsent(bool measurementConsent) async {
    await _channel.invokeMethod(
        'trackMeasurementConsent', {'measurementConsent': measurementConsent});
  }

  Future<void> updateConversionValue(int conversionValue) async {
    await _channel.invokeMethod(
        'updateConversionValue', {'conversionValue': conversionValue});
  }

  // For testing purposes only. Do not use in production.
  @visibleForTesting
  Future<void> setTestOptions(final dynamic testOptions) async {
    await _channel.invokeMethod('setTestOptions', testOptions);
  }
}
