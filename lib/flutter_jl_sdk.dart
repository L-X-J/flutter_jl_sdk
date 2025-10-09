
import 'flutter_jl_sdk_platform_interface.dart';

class FlutterJlSdk {
  Future<String?> getPlatformVersion() {
    return FlutterJlSdkPlatform.instance.getPlatformVersion();
  }
}
