import 'package:flutter_test/flutter_test.dart';
import 'package:my_halyk_ios/my_halyk_ios.dart';
import 'package:my_halyk_ios/my_halyk_ios_platform_interface.dart';
import 'package:my_halyk_ios/my_halyk_ios_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyHalykIosPlatform
    with MockPlatformInterfaceMixin
    implements MyHalykIosPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyHalykIosPlatform initialPlatform = MyHalykIosPlatform.instance;

  test('$MethodChannelMyHalykIos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyHalykIos>());
  });

  test('getPlatformVersion', () async {
    MyHalykIos myHalykIosPlugin = MyHalykIos();
    MockMyHalykIosPlatform fakePlatform = MockMyHalykIosPlatform();
    MyHalykIosPlatform.instance = fakePlatform;

    // expect(await myHalykIosPlugin.getPlatformVersion(), '42');
  });
}
