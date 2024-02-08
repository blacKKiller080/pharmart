import 'dart:async';

import 'package:flutter/services.dart';

class MyHalykIos {
  static const MethodChannel _channel = const MethodChannel('my_halyk_ios');

  static Future<void> initializeHalykID({
    required String clientID,
    required String scope,
    required String redirectURL,
    String? state,
    required String localization,
    required String configuration,
  }) async {
    await _channel.invokeMethod('initializeHalykID', {
      'clientID': clientID,
      'scope': scope,
      'redirectURL': redirectURL,
      'state': state,
      'localization': localization,
      'configuration': configuration,
    });
  }
}
