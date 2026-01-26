import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

import 'flutter_jl_sdk_platform_interface.dart';
import 'src/models/device_info.dart';
import 'src/models/music_info.dart';
import 'src/models/device_control.dart';

/// 使用方法通道实现的杰理SDK平台接口
class FlutterJlSdkMethodChannel extends FlutterJlSdkPlatform {
  /// 方法通道名称
  static const String _channelName = 'com.yuanquz.flutter.plugin.jl/flutter_jl_sdk';

  /// 事件通道名称
  static const String _eventChannelName = 'com.yuanquz.flutter.plugin.jl/flutter_jl_sdk_events';

  /// 方法通道
  final MethodChannel _methodChannel;

  /// 事件通道
  final EventChannel _deviceStatusEventChannel;
  final EventChannel _musicInfoEventChannel;
  final EventChannel _errorEventChannel;

  /// 流控制器
  StreamController<JlDeviceInfo>? _deviceStatusController;
  StreamController<JlMusicInfo>? _musicInfoController;
  StreamController<JlError>? _errorController;

  /// 构造函数
  FlutterJlSdkMethodChannel({
    MethodChannel? methodChannel,
    EventChannel? deviceStatusEventChannel,
    EventChannel? musicInfoEventChannel,
    EventChannel? errorEventChannel,
  })  : _methodChannel = methodChannel ?? const MethodChannel(_channelName),
        _deviceStatusEventChannel = deviceStatusEventChannel ?? const EventChannel(_eventChannelName),
        _musicInfoEventChannel = musicInfoEventChannel ?? const EventChannel('$_eventChannelName/music'),
        _errorEventChannel = errorEventChannel ?? const EventChannel('$_eventChannelName/error');

  @override
  Future<bool> initialize() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('initialize');
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('初始化失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      await _methodChannel.invokeMethod('dispose');
      
      // 关闭所有流控制器
      await _deviceStatusController?.close();
      await _musicInfoController?.close();
      await _errorController?.close();
      
      _deviceStatusController = null;
      _musicInfoController = null;
      _errorController = null;
    } on PlatformException catch (e) {
      debugPrint('释放资源失败: ${e.message}');
    }
  }

  @override
  Future<List<JlDeviceInfo>> scanDevices({
    int timeout = 10000,
    List<DeviceType> deviceTypes = const [],
  }) async {
    try {
      final result = await _methodChannel.invokeMethod('scanDevices', {
        'timeout': timeout,
        'deviceTypes': deviceTypes.map((e) => e.toString()).toList(),
      });
      
      if (result is List) {
        return result
            .map((e) => JlDeviceInfo.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      return [];
    } on PlatformException catch (e) {
      debugPrint('扫描设备失败: ${e.message}');
      return [];
    }
  }

  @override
  Future<void> stopScan() async {
    try {
      await _methodChannel.invokeMethod('stopScan');
    } on PlatformException catch (e) {
      debugPrint('停止扫描失败: ${e.message}');
    }
  }

  @override
  Future<bool> connectDevice(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('connectDevice', {
        'deviceId': deviceId,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('连接设备失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> disconnectDevice(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('disconnectDevice', {
        'deviceId': deviceId,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('断开设备失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<ConnectionStatus> getConnectionStatus(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod<String>('getConnectionStatus', {
        'deviceId': deviceId,
      });
      return ConnectionStatus.fromString(result ?? 'disconnected');
    } on PlatformException catch (e) {
      debugPrint('获取连接状态失败: ${e.message}');
      return ConnectionStatus.disconnected;
    }
  }

  @override
  Future<List<JlDeviceInfo>> getConnectedDevices() async {
    try {
      final result = await _methodChannel.invokeMethod('getConnectedDevices');
      
      if (result is List) {
        return result
            .map((e) => JlDeviceInfo.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      return [];
    } on PlatformException catch (e) {
      debugPrint('获取已连接设备失败: ${e.message}');
      return [];
    }
  }

  @override
  Future<bool> play(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('play', {
        'deviceId': deviceId,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('播放失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> pause(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('pause', {
        'deviceId': deviceId,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('暂停失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> stop(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('stop', {
        'deviceId': deviceId,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('停止失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> previousTrack(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('previousTrack', {
        'deviceId': deviceId,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('上一曲失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> nextTrack(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('nextTrack', {
        'deviceId': deviceId,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('下一曲失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> seek(String deviceId, int position) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('seek', {
        'deviceId': deviceId,
        'position': position,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('设置进度失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> setPlayMode(String deviceId, PlayMode mode) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('setPlayMode', {
        'deviceId': deviceId,
        'mode': mode.toString(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('设置播放模式失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<JlMusicInfo> getCurrentMusicInfo(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod('getCurrentMusicInfo', {
        'deviceId': deviceId,
      });
      
      if (result is Map) {
        return JlMusicInfo.fromJson(Map<String, dynamic>.from(result));
      }
      return JlMusicInfo(playStatus: PlayStatus.stopped, playMode: PlayMode.repeatAll);
    } on PlatformException catch (e) {
      debugPrint('获取音乐信息失败: ${e.message}');
      return JlMusicInfo(playStatus: PlayStatus.stopped, playMode: PlayMode.repeatAll);
    }
  }

  @override
  Future<bool> setVolume(String deviceId, int volume) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('setVolume', {
        'deviceId': deviceId,
        'volume': volume,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('设置音量失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<int> getVolume(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod<int>('getVolume', {
        'deviceId': deviceId,
      });
      return result ?? 50;
    } on PlatformException catch (e) {
      debugPrint('获取音量失败: ${e.message}');
      return 50;
    }
  }

  @override
  Future<bool> setMuted(String deviceId, bool muted) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('setMuted', {
        'deviceId': deviceId,
        'muted': muted,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('设置静音失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> isMuted(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('isMuted', {
        'deviceId': deviceId,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('获取静音状态失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> setEq(String deviceId, EqControl eqControl) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('setEq', {
        'deviceId': deviceId,
        'eqControl': eqControl.toJson(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('设置EQ失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<EqControl> getEq(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod('getEq', {
        'deviceId': deviceId,
      });
      
      if (result is Map) {
        return EqControl.fromJson(Map<String, dynamic>.from(result));
      }
      return EqControl(bass: 0, mid: 0, treble: 0, preset: EqPreset.normal);
    } on PlatformException catch (e) {
      debugPrint('获取EQ失败: ${e.message}');
      return EqControl(bass: 0, mid: 0, treble: 0, preset: EqPreset.normal);
    }
  }

  @override
  Future<bool> setEqPreset(String deviceId, EqPreset preset) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('setEqPreset', {
        'deviceId': deviceId,
        'preset': preset.toString(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('设置EQ预设失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> setSoundEffect(String deviceId, SoundEffectControl soundEffect) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('setSoundEffect', {
        'deviceId': deviceId,
        'soundEffect': soundEffect.toJson(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('设置音效失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<SoundEffectControl> getSoundEffect(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod('getSoundEffect', {
        'deviceId': deviceId,
      });
      
      if (result is Map) {
        return SoundEffectControl.fromJson(Map<String, dynamic>.from(result));
      }
      return SoundEffectControl(reverb: 0, bassBoost: 0, trebleBoost: 0);
    } on PlatformException catch (e) {
      debugPrint('获取音效失败: ${e.message}');
      return SoundEffectControl(reverb: 0, bassBoost: 0, trebleBoost: 0);
    }
  }

  @override
  Future<bool> addAlarm(String deviceId, JlAlarm alarm) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('addAlarm', {
        'deviceId': deviceId,
        'alarm': alarm.toJson(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('添加闹钟失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> deleteAlarm(String deviceId, String alarmId) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('deleteAlarm', {
        'deviceId': deviceId,
        'alarmId': alarmId,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('删除闹钟失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> updateAlarm(String deviceId, JlAlarm alarm) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('updateAlarm', {
        'deviceId': deviceId,
        'alarm': alarm.toJson(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('更新闹钟失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<List<JlAlarm>> getAlarms(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod('getAlarms', {
        'deviceId': deviceId,
      });
      
      if (result is List) {
        return result
            .map((e) => JlAlarm.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      return [];
    } on PlatformException catch (e) {
      debugPrint('获取闹钟列表失败: ${e.message}');
      return [];
    }
  }

  @override
  Future<bool> setFm(String deviceId, FmControl fmControl) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('setFm', {
        'deviceId': deviceId,
        'fmControl': fmControl.toJson(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('设置FM失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<FmControl> getFm(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod('getFm', {
        'deviceId': deviceId,
      });
      
      if (result is Map) {
        return FmControl.fromJson(Map<String, dynamic>.from(result));
      }
      return FmControl(frequency: 87.5, mode: FmMode.receiver);
    } on PlatformException catch (e) {
      debugPrint('获取FM失败: ${e.message}');
      return FmControl(frequency: 87.5, mode: FmMode.receiver);
    }
  }

  @override
  Future<bool> setLight(String deviceId, LightControl lightControl) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('setLight', {
        'deviceId': deviceId,
        'lightControl': lightControl.toJson(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('设置灯光失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<LightControl> getLight(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod('getLight', {
        'deviceId': deviceId,
      });
      
      if (result is Map) {
        return LightControl.fromJson(Map<String, dynamic>.from(result));
      }
      return LightControl(mode: LightMode.solid);
    } on PlatformException catch (e) {
      debugPrint('获取灯光失败: ${e.message}');
      return LightControl(mode: LightMode.solid);
    }
  }

  @override
  Future<bool> setAnc(String deviceId, AncControl ancControl) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('setAnc', {
        'deviceId': deviceId,
        'ancControl': ancControl.toJson(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('设置ANC失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<AncControl> getAnc(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod('getAnc', {
        'deviceId': deviceId,
      });
      
      if (result is Map) {
        return AncControl.fromJson(Map<String, dynamic>.from(result));
      }
      return AncControl(mode: AncMode.normal);
    } on PlatformException catch (e) {
      debugPrint('获取ANC失败: ${e.message}');
      return AncControl(mode: AncMode.normal);
    }
  }

  @override
  Future<bool> setKeySettings(String deviceId, KeySettings keySettings) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('setKeySettings', {
        'deviceId': deviceId,
        'keySettings': keySettings.toJson(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('设置按键失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<KeySettings> getKeySettings(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod('getKeySettings', {
        'deviceId': deviceId,
      });
      
      if (result is Map) {
        return KeySettings.fromJson(Map<String, dynamic>.from(result));
      }
      return KeySettings(keyMap: {});
    } on PlatformException catch (e) {
      debugPrint('获取按键设置失败: ${e.message}');
      return KeySettings(keyMap: {});
    }
  }

  @override
  Future<bool> findDevice(String deviceId, FindDeviceParams findDevice) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('findDevice', {
        'deviceId': deviceId,
        'findDevice': findDevice.toJson(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('查找设备失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<String> sendCustomCommand(String deviceId, CustomCommand command) async {
    try {
      final result = await _methodChannel.invokeMethod<String>('sendCustomCommand', {
        'deviceId': deviceId,
        'command': command.toJson(),
      });
      return result ?? '';
    } on PlatformException catch (e) {
      debugPrint('发送自定义命令失败: ${e.message}');
      return '';
    }
  }

  @override
  Future<List<JlFileInfo>> getFiles(String deviceId, String path) async {
    try {
      final result = await _methodChannel.invokeMethod('getFiles', {
        'deviceId': deviceId,
        'path': path,
      });
      
      if (result is List) {
        return result
            .map((e) => JlFileInfo.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      return [];
    } on PlatformException catch (e) {
      debugPrint('获取文件列表失败: ${e.message}');
      return [];
    }
  }

  @override
  Future<bool> startOta(String deviceId, String firmwarePath) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('startOta', {
        'deviceId': deviceId,
        'firmwarePath': firmwarePath,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('开始OTA升级失败: ${e.message}');
      return false;
    }
  }

  @override
  Future<double> getOtaProgress(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod<double>('getOtaProgress', {
        'deviceId': deviceId,
      });
      return result ?? 0.0;
    } on PlatformException catch (e) {
      debugPrint('获取OTA进度失败: ${e.message}');
      return 0.0;
    }
  }

  @override
  Future<bool> cancelOta(String deviceId) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('cancelOta', {
        'deviceId': deviceId,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('取消OTA升级失败: ${e.message}');
      return false;
    }
  }

  @override
  Stream<JlDeviceInfo> get deviceStatusStream {
    _deviceStatusController ??= StreamController<JlDeviceInfo>(
      onListen: () {
        _deviceStatusEventChannel.receiveBroadcastStream().listen(
          (data) {
            try {
              final info = JlDeviceInfo.fromJson(Map<String, dynamic>.from(data));
              _deviceStatusController?.add(info);
            } catch (e) {
              debugPrint('解析设备状态数据失败: $e');
            }
          },
          onError: (error) {
            _deviceStatusController?.addError(error);
          },
          onDone: () {
            _deviceStatusController?.close();
            _deviceStatusController = null;
          },
        );
      },
      onCancel: () {
        _deviceStatusController?.close();
        _deviceStatusController = null;
      },
    );
    
    return _deviceStatusController!.stream;
  }

  @override
  Stream<JlMusicInfo> get musicInfoStream {
    _musicInfoController ??= StreamController<JlMusicInfo>(
      onListen: () {
        _musicInfoEventChannel.receiveBroadcastStream().listen(
          (data) {
            try {
              final info = JlMusicInfo.fromJson(Map<String, dynamic>.from(data));
              _musicInfoController?.add(info);
            } catch (e) {
              debugPrint('解析音乐信息数据失败: $e');
            }
          },
          onError: (error) {
            _musicInfoController?.addError(error);
          },
          onDone: () {
            _musicInfoController?.close();
            _musicInfoController = null;
          },
        );
      },
      onCancel: () {
        _musicInfoController?.close();
        _musicInfoController = null;
      },
    );
    
    return _musicInfoController!.stream;
  }

  @override
  Stream<JlError> get errorStream {
    _errorController ??= StreamController<JlError>(
      onListen: () {
        _errorEventChannel.receiveBroadcastStream().listen(
          (data) {
            try {
              final error = JlError(
                errorCode: data['errorCode'] as String,
                errorMessage: data['errorMessage'] as String,
                deviceId: data['deviceId'] as String?,
                originalError: data['originalError'],
              );
              _errorController?.add(error);
            } catch (e) {
              debugPrint('解析错误数据失败: $e');
            }
          },
          onError: (error) {
            _errorController?.addError(error);
          },
          onDone: () {
            _errorController?.close();
            _errorController = null;
          },
        );
      },
      onCancel: () {
        _errorController?.close();
        _errorController = null;
      },
    );
    
    return _errorController!.stream;
  }
}