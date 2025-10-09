import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_jl_sdk_method_channel.dart';

abstract class FlutterJlSdkPlatform extends PlatformInterface {
  /// Constructs a FlutterJlSdkPlatform.
  FlutterJlSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterJlSdkPlatform _instance = MethodChannelFlutterJlSdk();

  /// The default instance of [FlutterJlSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterJlSdk].
  static FlutterJlSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterJlSdkPlatform] when
  /// they register themselves.
  static set instance(FlutterJlSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
