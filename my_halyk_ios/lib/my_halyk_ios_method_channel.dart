import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_halyk_ios_platform_interface.dart';

/// An implementation of [MyHalykIosPlatform] that uses method channels.
class MethodChannelMyHalykIos extends MyHalykIosPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_halyk_ios');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
