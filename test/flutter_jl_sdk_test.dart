import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_jl_sdk/flutter_jl_sdk.dart';
import 'package:flutter_jl_sdk/flutter_jl_sdk_platform_interface.dart';
import 'package:flutter_jl_sdk/flutter_jl_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterJlSdkPlatform
    with MockPlatformInterfaceMixin
    implements FlutterJlSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterJlSdkPlatform initialPlatform = FlutterJlSdkPlatform.instance;

  test('$MethodChannelFlutterJlSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterJlSdk>());
  });

  test('getPlatformVersion', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    expect(await flutterJlSdkPlugin.getPlatformVersion(), '42');
  });
}
