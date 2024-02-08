import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_halyk_ios_method_channel.dart';

abstract class MyHalykIosPlatform extends PlatformInterface {
  /// Constructs a MyHalykIosPlatform.
  MyHalykIosPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyHalykIosPlatform _instance = MethodChannelMyHalykIos();

  /// The default instance of [MyHalykIosPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyHalykIos].
  static MyHalykIosPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyHalykIosPlatform] when
  /// they register themselves.
  static set instance(MyHalykIosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
