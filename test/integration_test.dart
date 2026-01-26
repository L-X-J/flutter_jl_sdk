import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_jl_sdk/flutter_jl_sdk.dart';
import 'package:flutter_jl_sdk/src/models/device_info.dart';
import 'package:flutter_jl_sdk/src/models/music_info.dart';
import 'package:flutter_jl_sdk/src/models/device_control.dart';

void main() {
  group('FlutterJlSdk Integration Tests', () {
    test('initialize and dispose', () async {
      // Test initialization
      final initialized = await FlutterJlSdk.initialize();
      expect(initialized, true);

      // Test dispose
      await FlutterJlSdk.dispose();
      // Should not throw
    });

    test('scan devices', () async {
      // Test scanning with default parameters
      final devices = await FlutterJlSdk.scanDevices();
      expect(devices, isList);

      // Test scanning with custom timeout
      final devicesWithTimeout = await FlutterJlSdk.scanDevices(timeout: 5000);
      expect(devicesWithTimeout, isList);

      // Test scanning with specific device types
      final headphones = await FlutterJlSdk.scanDevices(
        deviceTypes: [DeviceType.headphone],
      );
      expect(headphones, isList);
    });

    test('device connection', () async {
      const testDeviceId = 'test-device-1';

      // Test connection
      final connected = await FlutterJlSdk.connectDevice(testDeviceId);
      expect(connected, true);

      // Test connection status
      final status = await FlutterJlSdk.getConnectionStatus(testDeviceId);
      expect(status, ConnectionStatus.connected);

      // Test disconnect
      final disconnected = await FlutterJlSdk.disconnectDevice(testDeviceId);
      expect(disconnected, true);

      // Test get connected devices
      final connectedDevices = await FlutterJlSdk.getConnectedDevices();
      expect(connectedDevices, isList);
    });

    test('music control', () async {
      const testDeviceId = 'test-device-1';

      // Test play
      final played = await FlutterJlSdk.play(testDeviceId);
      expect(played, true);

      // Test pause
      final paused = await FlutterJlSdk.pause(testDeviceId);
      expect(paused, true);

      // Test stop
      final stopped = await FlutterJlSdk.stop(testDeviceId);
      expect(stopped, true);

      // Test previous track
      final previous = await FlutterJlSdk.previousTrack(testDeviceId);
      expect(previous, true);

      // Test next track
      final next = await FlutterJlSdk.nextTrack(testDeviceId);
      expect(next, true);

      // Test seek
      final seeked = await FlutterJlSdk.seek(testDeviceId, 60);
      expect(seeked, true);

      // Test set play mode
      final modeSet = await FlutterJlSdk.setPlayMode(testDeviceId, PlayMode.repeatAll);
      expect(modeSet, true);

      // Test get current music info
      final musicInfo = await FlutterJlSdk.getCurrentMusicInfo(testDeviceId);
      expect(musicInfo, isA<JlMusicInfo>());
    });

    test('volume control', () async {
      const testDeviceId = 'test-device-1';

      // Test set volume
      final volumeSet = await FlutterJlSdk.setVolume(testDeviceId, 75);
      expect(volumeSet, true);

      // Test get volume
      final volume = await FlutterJlSdk.getVolume(testDeviceId);
      expect(volume, isA<int>());

      // Test set muted
      final mutedSet = await FlutterJlSdk.setMuted(testDeviceId, true);
      expect(mutedSet, true);

      // Test is muted
      final isMuted = await FlutterJlSdk.isMuted(testDeviceId);
      expect(isMuted, isA<bool>());
    });

    test('EQ control', () async {
      const testDeviceId = 'test-device-1';

      // Test set EQ
      final eqControl = EqControl(preset: EqPreset.rock, bass: 0, mid: 2, treble: -1);
      final eqSet = await FlutterJlSdk.setEq(testDeviceId, eqControl);
      expect(eqSet, true);

      // Test get EQ
      final currentEq = await FlutterJlSdk.getEq(testDeviceId);
      expect(currentEq, isA<EqControl>());

      // Test set EQ preset
      final presetSet = await FlutterJlSdk.setEqPreset(testDeviceId, EqPreset.pop);
      expect(presetSet, true);
    });

    test('sound effect control', () async {
      const testDeviceId = 'test-device-1';

      // Test set sound effect
      final soundEffect = SoundEffectControl(reverb: 50, bassBoost: 30, trebleBoost: 20);
      final effectSet = await FlutterJlSdk.setSoundEffect(testDeviceId, soundEffect);
      expect(effectSet, true);

      // Test get sound effect
      final currentEffect = await FlutterJlSdk.getSoundEffect(testDeviceId);
      expect(currentEffect, isA<SoundEffectControl>());
    });

    test('alarm management', () async {
      const testDeviceId = 'test-device-1';

      // Test add alarm
      final alarm = JlAlarm(
        alarmId: 'alarm-1',
        hour: 7,
        minute: 30,
        repeatDays: [1, 2, 3, 4, 5],
        enabled: true,
      );
      final alarmAdded = await FlutterJlSdk.addAlarm(testDeviceId, alarm);
      expect(alarmAdded, true);

      // Test update alarm
      final updatedAlarm = JlAlarm(
        alarmId: 'alarm-1',
        hour: 8,
        minute: 0,
        repeatDays: [1, 2, 3, 4, 5, 6, 7],
        enabled: true,
      );
      final alarmUpdated = await FlutterJlSdk.updateAlarm(testDeviceId, updatedAlarm);
      expect(alarmUpdated, true);

      // Test get alarms
      final alarms = await FlutterJlSdk.getAlarms(testDeviceId);
      expect(alarms, isList);

      // Test delete alarm
      final alarmDeleted = await FlutterJlSdk.deleteAlarm(testDeviceId, 'alarm-1');
      expect(alarmDeleted, true);
    });

    test('FM control', () async {
      const testDeviceId = 'test-device-1';

      // Test set FM
      final fmControl = FmControl(mode: FmMode.receiver, frequency: 101.5);
      final fmSet = await FlutterJlSdk.setFm(testDeviceId, fmControl);
      expect(fmSet, true);

      // Test get FM
      final currentFm = await FlutterJlSdk.getFm(testDeviceId);
      expect(currentFm, isA<FmControl>());
    });

    test('light control', () async {
      const testDeviceId = 'test-device-1';

      // Test set light
      final lightControl = LightControl(mode: LightMode.solid, color: LightColor.red, brightness: 80);
      final lightSet = await FlutterJlSdk.setLight(testDeviceId, lightControl);
      expect(lightSet, true);

      // Test get light
      final currentLight = await FlutterJlSdk.getLight(testDeviceId);
      expect(currentLight, isA<LightControl>());
    });

    test('ANC control', () async {
      const testDeviceId = 'test-device-1';

      // Test set ANC
      final ancControl = AncControl(mode: AncMode.activeNoiseCancel, intensity: 80);
      final ancSet = await FlutterJlSdk.setAnc(testDeviceId, ancControl);
      expect(ancSet, true);

      // Test get ANC
      final currentAnc = await FlutterJlSdk.getAnc(testDeviceId);
      expect(currentAnc, isA<AncControl>());
    });

    test('key settings', () async {
      const testDeviceId = 'test-device-1';

      // Test set key settings
      final keySettings = KeySettings(keyMap: {
        KeyAction.doubleClick: KeyAction.playPause,
        KeyAction.longPress: KeyAction.findDevice,
      });
      final settingsSet = await FlutterJlSdk.setKeySettings(testDeviceId, keySettings);
      expect(settingsSet, true);

      // Test get key settings
      final currentSettings = await FlutterJlSdk.getKeySettings(testDeviceId);
      expect(currentSettings, isA<KeySettings>());
    });

    test('find device', () async {
      const testDeviceId = 'test-device-1';

      // Test find device
      final params = FindDeviceParams(mode: FindDeviceMode.blink, duration: 30);
      final found = await FlutterJlSdk.findDevice(testDeviceId, params);
      expect(found, true);
    });

    test('custom command', () async {
      const testDeviceId = 'test-device-1';

      // Test send custom command
      final command = CustomCommand(commandId: 'custom-1', data: {'key': 'value'});
      final response = await FlutterJlSdk.sendCustomCommand(testDeviceId, command);
      expect(response, isA<String>());
    });

    test('file browsing', () async {
      const testDeviceId = 'test-device-1';

      // Test get files
      final files = await FlutterJlSdk.getFiles(testDeviceId, '/music');
      expect(files, isList);
    });

    test('OTA upgrade', () async {
      const testDeviceId = 'test-device-1';

      // Test start OTA
      final otaStarted = await FlutterJlSdk.startOta(testDeviceId, '/firmware.bin');
      expect(otaStarted, true);

      // Test get OTA progress
      final progress = await FlutterJlSdk.getOtaProgress(testDeviceId);
      expect(progress, isA<double>());

      // Test cancel OTA
      final otaCancelled = await FlutterJlSdk.cancelOta(testDeviceId);
      expect(otaCancelled, true);
    });

    test('error handling', () async {
      // Test with invalid device ID
      try {
        await FlutterJlSdk.connectDevice('');
        // Should not reach here
        fail('Expected an error');
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });
}
