import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_jl_sdk/flutter_jl_sdk.dart';
import 'package:flutter_jl_sdk/flutter_jl_sdk_platform_interface.dart';
import 'package:flutter_jl_sdk/flutter_jl_sdk_method_channel.dart';
import 'package:flutter_jl_sdk/src/models/device_info.dart';
import 'package:flutter_jl_sdk/src/models/music_info.dart';
import 'package:flutter_jl_sdk/src/models/device_control.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// 模拟FlutterJlSdkPlatform用于测试
class MockFlutterJlSdkPlatform with MockPlatformInterfaceMixin implements FlutterJlSdkPlatform {
  
  @override
  Future<bool> initialize() async => true;
  
  @override
  Future<void> dispose() async {}
  
  @override
  Future<List<JlDeviceInfo>> scanDevices({int timeout = 10000, List<DeviceType> deviceTypes = const []}) async {
    return [
      JlDeviceInfo(
        deviceId: 'test-device-1',
        deviceName: 'Test Device 1',
        deviceType: DeviceType.headphone,
        connectionStatus: ConnectionStatus.disconnected,
        supportedFeatures: [DeviceFeature.musicControl, DeviceFeature.volumeControl],
      ),
    ];
  }
  
  @override
  Future<void> stopScan() async {}
  
  @override
  Future<bool> connectDevice(String deviceId) async => true;
  
  @override
  Future<bool> disconnectDevice(String deviceId) async => true;
  
  @override
  Future<ConnectionStatus> getConnectionStatus(String deviceId) async => ConnectionStatus.connected;
  
  @override
  Future<List<JlDeviceInfo>> getConnectedDevices() async => [];
  
  @override
  Future<bool> play(String deviceId) async => true;
  
  @override
  Future<bool> pause(String deviceId) async => true;
  
  @override
  Future<bool> stop(String deviceId) async => true;
  
  @override
  Future<bool> previousTrack(String deviceId) async => true;
  
  @override
  Future<bool> nextTrack(String deviceId) async => true;
  
  @override
  Future<bool> seek(String deviceId, int position) async => true;
  
  @override
  Future<bool> setPlayMode(String deviceId, PlayMode mode) async => true;
  
  @override
  Future<JlMusicInfo> getCurrentMusicInfo(String deviceId) async {
    return JlMusicInfo(
      title: 'Test Song',
      artist: 'Test Artist',
      playStatus: PlayStatus.playing,
      playMode: PlayMode.repeatAll,
      duration: 180,
      position: 60,
    );
  }
  
  @override
  Future<bool> setVolume(String deviceId, int volume) async => true;
  
  @override
  Future<int> getVolume(String deviceId) async => 50;
  
  @override
  Future<bool> setMuted(String deviceId, bool muted) async => true;
  
  @override
  Future<bool> isMuted(String deviceId) async => false;
  
  @override
  Future<bool> setEq(String deviceId, EqControl eqControl) async => true;
  
  @override
  Future<EqControl> getEq(String deviceId) async => EqControl(preset: EqPreset.rock, bands: [0, 2, -1, 1, 0]);
  
  @override
  Future<bool> setEqPreset(String deviceId, EqPreset preset) async => true;
  
  @override
  Future<bool> setSoundEffect(String deviceId, SoundEffectControl soundEffect) async => true;
  
  @override
  Future<SoundEffectControl> getSoundEffect(String deviceId) async => SoundEffectControl(reverb: 50, bassBoost: 30, trebleBoost: 20);
  
  @override
  Future<bool> addAlarm(String deviceId, JlAlarm alarm) async => true;
  
  @override
  Future<bool> deleteAlarm(String deviceId, String alarmId) async => true;
  
  @override
  Future<bool> updateAlarm(String deviceId, JlAlarm alarm) async => true;
  
  @override
  Future<List<JlAlarm>> getAlarms(String deviceId) async => [];
  
  @override
  Future<bool> setFm(String deviceId, FmControl fmControl) async => true;
  
  @override
  Future<FmControl> getFm(String deviceId) async => FmControl(mode: FmMode.receiver, frequency: 101.5);
  
  @override
  Future<bool> setLight(String deviceId, LightControl lightControl) async => true;
  
  @override
  Future<LightControl> getLight(String deviceId) async => LightControl(mode: LightMode.solid, color: LightColor.red, brightness: 80);
  
  @override
  Future<bool> setAnc(String deviceId, AncControl ancControl) async => true;
  
  @override
  Future<AncControl> getAnc(String deviceId) async => AncControl(mode: AncMode.activeNoiseCancel, level: 80);
  
  @override
  Future<bool> setKeySettings(String deviceId, KeySettings keySettings) async => true;
  
  @override
  Future<KeySettings> getKeySettings(String deviceId) async => KeySettings(doubleClickAction: KeyAction.playPause, longPressAction: KeyAction.findDevice);
  
  @override
  Future<bool> findDevice(String deviceId, FindDeviceParams params) async => true;
  
  @override
  Future<String> sendCustomCommand(String deviceId, CustomCommand command) async => 'response';
  
  @override
  Future<List<JlFileInfo>> getFiles(String deviceId, String path) async => [];
  
  @override
  Future<bool> startOta(String deviceId, String firmwarePath) async => true;
  
  @override
  Future<double> getOtaProgress(String deviceId) async => 0.0;
  
  @override
  Future<bool> cancelOta(String deviceId) async => true;
}

void main() {
  final FlutterJlSdkPlatform initialPlatform = FlutterJlSdkPlatform.instance;

  test('$MethodChannelFlutterJlSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterJlSdk>());
  });

  test('initialize', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    expect(await flutterJlSdkPlugin.initialize(), true);
  });

  test('scanDevices', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final devices = await flutterJlSdkPlugin.scanDevices();
    expect(devices, isList);
    expect(devices.length, greaterThan(0));
    expect(devices.first.deviceId, 'test-device-1');
  });

  test('connectDevice', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    expect(await flutterJlSdkPlugin.connectDevice('test-device-1'), true);
  });

  test('play', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    expect(await flutterJlSdkPlugin.play('test-device-1'), true);
  });

  test('getCurrentMusicInfo', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final musicInfo = await flutterJlSdkPlugin.getCurrentMusicInfo('test-device-1');
    expect(musicInfo.title, 'Test Song');
    expect(musicInfo.artist, 'Test Artist');
    expect(musicInfo.playStatus, PlayStatus.playing);
  });

  test('setVolume', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    expect(await flutterJlSdkPlugin.setVolume('test-device-1', 75), true);
  });

  test('getVolume', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final volume = await flutterJlSdkPlugin.getVolume('test-device-1');
    expect(volume, 50);
  });

  test('setEq', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final eqControl = EqControl(preset: EqPreset.rock, bands: [0, 2, -1, 1, 0]);
    expect(await flutterJlSdkPlugin.setEq('test-device-1', eqControl), true);
  });

  test('getEq', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final eqControl = await flutterJlSdkPlugin.getEq('test-device-1');
    expect(eqControl.preset, EqPreset.rock);
    expect(eqControl.bands, [0, 2, -1, 1, 0]);
  });

  test('setEqPreset', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    expect(await flutterJlSdkPlugin.setEqPreset('test-device-1', EqPreset.pop), true);
  });

  test('setSoundEffect', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final soundEffect = SoundEffectControl(reverb: 50, bassBoost: 30, trebleBoost: 20);
    expect(await flutterJlSdkPlugin.setSoundEffect('test-device-1', soundEffect), true);
  });

  test('getSoundEffect', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final soundEffect = await flutterJlSdkPlugin.getSoundEffect('test-device-1');
    expect(soundEffect.reverb, 50);
    expect(soundEffect.bassBoost, 30);
    expect(soundEffect.trebleBoost, 20);
  });

  test('addAlarm', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final alarm = JlAlarm(
      alarmId: 'alarm-1',
      hour: 7,
      minute: 30,
      repeatDays: [1, 2, 3, 4, 5],
      enabled: true,
    );
    expect(await flutterJlSdkPlugin.addAlarm('test-device-1', alarm), true);
  });

  test('deleteAlarm', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    expect(await flutterJlSdkPlugin.deleteAlarm('test-device-1', 'alarm-1'), true);
  });

  test('updateAlarm', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final alarm = JlAlarm(
      alarmId: 'alarm-1',
      hour: 8,
      minute: 0,
      repeatDays: [1, 2, 3, 4, 5, 6, 7],
      enabled: true,
    );
    expect(await flutterJlSdkPlugin.updateAlarm('test-device-1', alarm), true);
  });

  test('getAlarms', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final alarms = await flutterJlSdkPlugin.getAlarms('test-device-1');
    expect(alarms, isList);
  });

  test('setFm', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final fmControl = FmControl(mode: FmMode.receiver, frequency: 101.5);
    expect(await flutterJlSdkPlugin.setFm('test-device-1', fmControl), true);
  });

  test('getFm', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final fmControl = await flutterJlSdkPlugin.getFm('test-device-1');
    expect(fmControl.mode, FmMode.receiver);
    expect(fmControl.frequency, 101.5);
  });

  test('setLight', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final lightControl = LightControl(mode: LightMode.solid, color: LightColor.red, brightness: 80);
    expect(await flutterJlSdkPlugin.setLight('test-device-1', lightControl), true);
  });

  test('getLight', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final lightControl = await flutterJlSdkPlugin.getLight('test-device-1');
    expect(lightControl.mode, LightMode.solid);
    expect(lightControl.color, LightColor.red);
    expect(lightControl.brightness, 80);
  });

  test('setAnc', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final ancControl = AncControl(mode: AncMode.activeNoiseCancel, level: 80);
    expect(await flutterJlSdkPlugin.setAnc('test-device-1', ancControl), true);
  });

  test('getAnc', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final ancControl = await flutterJlSdkPlugin.getAnc('test-device-1');
    expect(ancControl.mode, AncMode.activeNoiseCancel);
    expect(ancControl.level, 80);
  });

  test('setKeySettings', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final keySettings = KeySettings(doubleClickAction: KeyAction.playPause, longPressAction: KeyAction.findDevice);
    expect(await flutterJlSdkPlugin.setKeySettings('test-device-1', keySettings), true);
  });

  test('getKeySettings', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final keySettings = await flutterJlSdkPlugin.getKeySettings('test-device-1');
    expect(keySettings.doubleClickAction, KeyAction.playPause);
    expect(keySettings.longPressAction, KeyAction.findDevice);
  });

  test('findDevice', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final params = FindDeviceParams(mode: FindDeviceMode.blink, duration: 30);
    expect(await flutterJlSdkPlugin.findDevice('test-device-1', params), true);
  });

  test('sendCustomCommand', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final command = CustomCommand(commandId: 'custom-1', data: {'key': 'value'});
    final response = await flutterJlSdkPlugin.sendCustomCommand('test-device-1', command);
    expect(response, 'response');
  });

  test('getFiles', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final files = await flutterJlSdkPlugin.getFiles('test-device-1', '/music');
    expect(files, isList);
  });

  test('startOta', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    expect(await flutterJlSdkPlugin.startOta('test-device-1', '/firmware.bin'), true);
  });

  test('getOtaProgress', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    final progress = await flutterJlSdkPlugin.getOtaProgress('test-device-1');
    expect(progress, 0.0);
  });

  test('cancelOta', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    expect(await flutterJlSdkPlugin.cancelOta('test-device-1'), true);
  });

  test('dispose', () async {
    FlutterJlSdk flutterJlSdkPlugin = FlutterJlSdk();
    MockFlutterJlSdkPlatform fakePlatform = MockFlutterJlSdkPlatform();
    FlutterJlSdkPlatform.instance = fakePlatform;

    await flutterJlSdkPlugin.dispose();
    // Should not throw
  });
}
