import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_jl_sdk/flutter_jl_sdk_method_channel.dart';
import 'package:flutter_jl_sdk/src/models/device_info.dart';
import 'package:flutter_jl_sdk/src/models/music_info.dart';
import 'package:flutter_jl_sdk/src/models/device_control.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFlutterJlSdk platform = MethodChannelFlutterJlSdk();
  const MethodChannel channel = MethodChannel('com.yuanquz.flutter.plugin.jl/flutter_jl_sdk');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'initialize':
            return true;
          case 'scanDevices':
            return [
              {
                'deviceId': 'test-device-1',
                'deviceName': 'Test Device 1',
                'deviceType': 'headphone',
                'connectionStatus': 'disconnected',
                'supportedFeatures': ['musicControl', 'volumeControl'],
              }
            ];
          case 'connectDevice':
            return true;
          case 'disconnectDevice':
            return true;
          case 'getConnectionStatus':
            return 'connected';
          case 'getConnectedDevices':
            return [];
          case 'play':
            return true;
          case 'pause':
            return true;
          case 'stop':
            return true;
          case 'previousTrack':
            return true;
          case 'nextTrack':
            return true;
          case 'seek':
            return true;
          case 'setPlayMode':
            return true;
          case 'getCurrentMusicInfo':
            return {
              'title': 'Test Song',
              'artist': 'Test Artist',
              'playStatus': 'playing',
              'playMode': 'repeatAll',
              'duration': 180,
              'position': 60,
            };
          case 'setVolume':
            return true;
          case 'getVolume':
            return 50;
          case 'setMuted':
            return true;
          case 'isMuted':
            return false;
          case 'setEq':
            return true;
          case 'getEq':
            return {
              'preset': 'rock',
              'bands': [0, 2, -1, 1, 0],
            };
          case 'setEqPreset':
            return true;
          case 'setSoundEffect':
            return true;
          case 'getSoundEffect':
            return {
              'reverb': 50,
              'bassBoost': 30,
              'trebleBoost': 20,
            };
          case 'addAlarm':
            return true;
          case 'deleteAlarm':
            return true;
          case 'updateAlarm':
            return true;
          case 'getAlarms':
            return [];
          case 'setFm':
            return true;
          case 'getFm':
            return {
              'mode': 'receiver',
              'frequency': 101.5,
            };
          case 'setLight':
            return true;
          case 'getLight':
            return {
              'mode': 'solid',
              'color': 'red',
              'brightness': 80,
            };
          case 'setAnc':
            return true;
          case 'getAnc':
            return {
              'mode': 'activeNoiseCancel',
              'level': 80,
            };
          case 'setKeySettings':
            return true;
          case 'getKeySettings':
            return {
              'doubleClickAction': 'playPause',
              'longPressAction': 'findDevice',
            };
          case 'findDevice':
            return true;
          case 'sendCustomCommand':
            return 'response';
          case 'getFiles':
            return [];
          case 'startOta':
            return true;
          case 'getOtaProgress':
            return 0.0;
          case 'cancelOta':
            return true;
          case 'dispose':
            return null;
          default:
            return FlutterMethodNotImplemented;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('initialize', () async {
    expect(await platform.initialize(), true);
  });

  test('scanDevices', () async {
    final devices = await platform.scanDevices();
    expect(devices, isList);
    expect(devices.length, greaterThan(0));
    expect(devices.first.deviceId, 'test-device-1');
  });

  test('connectDevice', () async {
    expect(await platform.connectDevice('test-device-1'), true);
  });

  test('disconnectDevice', () async {
    expect(await platform.disconnectDevice('test-device-1'), true);
  });

  test('getConnectionStatus', () async {
    final status = await platform.getConnectionStatus('test-device-1');
    expect(status, ConnectionStatus.connected);
  });

  test('getConnectedDevices', () async {
    final devices = await platform.getConnectedDevices();
    expect(devices, isList);
  });

  test('play', () async {
    expect(await platform.play('test-device-1'), true);
  });

  test('pause', () async {
    expect(await platform.pause('test-device-1'), true);
  });

  test('stop', () async {
    expect(await platform.stop('test-device-1'), true);
  });

  test('previousTrack', () async {
    expect(await platform.previousTrack('test-device-1'), true);
  });

  test('nextTrack', () async {
    expect(await platform.nextTrack('test-device-1'), true);
  });

  test('seek', () async {
    expect(await platform.seek('test-device-1', 60), true);
  });

  test('setPlayMode', () async {
    expect(await platform.setPlayMode('test-device-1', PlayMode.repeatAll), true);
  });

  test('getCurrentMusicInfo', () async {
    final musicInfo = await platform.getCurrentMusicInfo('test-device-1');
    expect(musicInfo.title, 'Test Song');
    expect(musicInfo.artist, 'Test Artist');
    expect(musicInfo.playStatus, PlayStatus.playing);
  });

  test('setVolume', () async {
    expect(await platform.setVolume('test-device-1', 75), true);
  });

  test('getVolume', () async {
    final volume = await platform.getVolume('test-device-1');
    expect(volume, 50);
  });

  test('setMuted', () async {
    expect(await platform.setMuted('test-device-1', true), true);
  });

  test('isMuted', () async {
    final isMuted = await platform.isMuted('test-device-1');
    expect(isMuted, false);
  });

  test('setEq', () async {
    final eqControl = EqControl(preset: EqPreset.rock, bands: [0, 2, -1, 1, 0]);
    expect(await platform.setEq('test-device-1', eqControl), true);
  });

  test('getEq', () async {
    final eqControl = await platform.getEq('test-device-1');
    expect(eqControl.preset, EqPreset.rock);
    expect(eqControl.bands, [0, 2, -1, 1, 0]);
  });

  test('setEqPreset', () async {
    expect(await platform.setEqPreset('test-device-1', EqPreset.pop), true);
  });

  test('setSoundEffect', () async {
    final soundEffect = SoundEffectControl(reverb: 50, bassBoost: 30, trebleBoost: 20);
    expect(await platform.setSoundEffect('test-device-1', soundEffect), true);
  });

  test('getSoundEffect', () async {
    final soundEffect = await platform.getSoundEffect('test-device-1');
    expect(soundEffect.reverb, 50);
    expect(soundEffect.bassBoost, 30);
    expect(soundEffect.trebleBoost, 20);
  });

  test('addAlarm', () async {
    final alarm = JlAlarm(
      alarmId: 'alarm-1',
      hour: 7,
      minute: 30,
      repeatDays: [1, 2, 3, 4, 5],
      enabled: true,
    );
    expect(await platform.addAlarm('test-device-1', alarm), true);
  });

  test('deleteAlarm', () async {
    expect(await platform.deleteAlarm('test-device-1', 'alarm-1'), true);
  });

  test('updateAlarm', () async {
    final alarm = JlAlarm(
      alarmId: 'alarm-1',
      hour: 8,
      minute: 0,
      repeatDays: [1, 2, 3, 4, 5, 6, 7],
      enabled: true,
    );
    expect(await platform.updateAlarm('test-device-1', alarm), true);
  });

  test('getAlarms', () async {
    final alarms = await platform.getAlarms('test-device-1');
    expect(alarms, isList);
  });

  test('setFm', () async {
    final fmControl = FmControl(mode: FmMode.receiver, frequency: 101.5);
    expect(await platform.setFm('test-device-1', fmControl), true);
  });

  test('getFm', () async {
    final fmControl = await platform.getFm('test-device-1');
    expect(fmControl.mode, FmMode.receiver);
    expect(fmControl.frequency, 101.5);
  });

  test('setLight', () async {
    final lightControl = LightControl(mode: LightMode.solid, color: LightColor.red, brightness: 80);
    expect(await platform.setLight('test-device-1', lightControl), true);
  });

  test('getLight', () async {
    final lightControl = await platform.getLight('test-device-1');
    expect(lightControl.mode, LightMode.solid);
    expect(lightControl.color, LightColor.red);
    expect(lightControl.brightness, 80);
  });

  test('setAnc', () async {
    final ancControl = AncControl(mode: AncMode.activeNoiseCancel, level: 80);
    expect(await platform.setAnc('test-device-1', ancControl), true);
  });

  test('getAnc', () async {
    final ancControl = await platform.getAnc('test-device-1');
    expect(ancControl.mode, AncMode.activeNoiseCancel);
    expect(ancControl.level, 80);
  });

  test('setKeySettings', () async {
    final keySettings = KeySettings(doubleClickAction: KeyAction.playPause, longPressAction: KeyAction.findDevice);
    expect(await platform.setKeySettings('test-device-1', keySettings), true);
  });

  test('getKeySettings', () async {
    final keySettings = await platform.getKeySettings('test-device-1');
    expect(keySettings.doubleClickAction, KeyAction.playPause);
    expect(keySettings.longPressAction, KeyAction.findDevice);
  });

  test('findDevice', () async {
    final params = FindDeviceParams(mode: FindDeviceMode.blink, duration: 30);
    expect(await platform.findDevice('test-device-1', params), true);
  });

  test('sendCustomCommand', () async {
    final command = CustomCommand(commandId: 'custom-1', data: {'key': 'value'});
    final response = await platform.sendCustomCommand('test-device-1', command);
    expect(response, 'response');
  });

  test('getFiles', () async {
    final files = await platform.getFiles('test-device-1', '/music');
    expect(files, isList);
  });

  test('startOta', () async {
    expect(await platform.startOta('test-device-1', '/firmware.bin'), true);
  });

  test('getOtaProgress', () async {
    final progress = await platform.getOtaProgress('test-device-1');
    expect(progress, 0.0);
  });

  test('cancelOta', () async {
    expect(await platform.cancelOta('test-device-1'), true);
  });

  test('dispose', () async {
    await platform.dispose();
    // Should not throw
  });
}
