import 'dart:async';

import 'flutter_jl_sdk_platform_interface.dart';
import 'flutter_jl_sdk_method_channel.dart';
import 'src/models/device_info.dart';
import 'src/models/music_info.dart';
import 'src/models/device_control.dart';

/// 杰理SDK Flutter封装类
/// 
/// 提供与杰理蓝牙设备交互的完整API接口
/// 
/// 使用示例：
/// ```dart
/// // 初始化SDK
/// await FlutterJlSdk.initialize();
/// 
/// // 扫描设备
/// final devices = await FlutterJlSdk.scanDevices();
/// 
/// // 连接设备
/// await FlutterJlSdk.connectDevice(devices.first.deviceId);
/// 
/// // 播放音乐
/// await FlutterJlSdk.play(devices.first.deviceId);
/// ```
class FlutterJlSdk {
  /// 私有构造函数，防止实例化
  FlutterJlSdk._();

  /// 初始化SDK
  /// 
  /// 在使用SDK之前必须调用此方法进行初始化
  /// 
  /// 返回值：
  /// - true: 初始化成功
  /// - false: 初始化失败
  static Future<bool> initialize() {
    return FlutterJlSdkPlatform.instance.initialize();
  }

  /// 释放SDK资源
  /// 
  /// 在应用退出时调用，释放系统资源
  static Future<void> dispose() {
    return FlutterJlSdkPlatform.instance.dispose();
  }

  /// 扫描附近的杰理设备
  /// 
  /// 参数：
  /// - [timeout] 扫描超时时间（毫秒），默认10000ms
  /// - [deviceTypes] 指定设备类型过滤，为空则扫描所有类型
  /// 
  /// 返回值：
  /// - 设备信息列表
  static Future<List<JlDeviceInfo>> scanDevices({
    int timeout = 10000,
    List<DeviceType> deviceTypes = const [],
  }) {
    return FlutterJlSdkPlatform.instance.scanDevices(
      timeout: timeout,
      deviceTypes: deviceTypes,
    );
  }

  /// 停止扫描设备
  static Future<void> stopScan() {
    return FlutterJlSdkPlatform.instance.stopScan();
  }

  /// 连接设备
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - true: 连接成功
  /// - false: 连接失败
  static Future<bool> connectDevice(String deviceId) {
    return FlutterJlSdkPlatform.instance.connectDevice(deviceId);
  }

  /// 断开设备连接
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - true: 断开成功
  /// - false: 断开失败
  static Future<bool> disconnectDevice(String deviceId) {
    return FlutterJlSdkPlatform.instance.disconnectDevice(deviceId);
  }

  /// 获取设备连接状态
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - 设备连接状态
  static Future<ConnectionStatus> getConnectionStatus(String deviceId) {
    return FlutterJlSdkPlatform.instance.getConnectionStatus(deviceId);
  }

  /// 获取已连接设备列表
  /// 
  /// 返回值：
  /// - 已连接设备信息列表
  static Future<List<JlDeviceInfo>> getConnectedDevices() {
    return FlutterJlSdkPlatform.instance.getConnectedDevices();
  }

  /// 音乐控制相关方法

  /// 播放
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> play(String deviceId) {
    return FlutterJlSdkPlatform.instance.play(deviceId);
  }

  /// 暂停
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> pause(String deviceId) {
    return FlutterJlSdkPlatform.instance.pause(deviceId);
  }

  /// 停止
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> stop(String deviceId) {
    return FlutterJlSdkPlatform.instance.stop(deviceId);
  }

  /// 上一曲
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> previousTrack(String deviceId) {
    return FlutterJlSdkPlatform.instance.previousTrack(deviceId);
  }

  /// 下一曲
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> nextTrack(String deviceId) {
    return FlutterJlSdkPlatform.instance.nextTrack(deviceId);
  }

  /// 设置播放进度
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [position] 进度（秒）
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> seek(String deviceId, int position) {
    return FlutterJlSdkPlatform.instance.seek(deviceId, position);
  }

  /// 设置播放模式
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [mode] 播放模式
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> setPlayMode(String deviceId, PlayMode mode) {
    return FlutterJlSdkPlatform.instance.setPlayMode(deviceId, mode);
  }

  /// 获取当前音乐信息
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - 音乐信息
  static Future<JlMusicInfo> getCurrentMusicInfo(String deviceId) {
    return FlutterJlSdkPlatform.instance.getCurrentMusicInfo(deviceId);
  }

  /// 音量控制相关方法

  /// 设置音量
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [volume] 音量值（0-100）
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> setVolume(String deviceId, int volume) {
    return FlutterJlSdkPlatform.instance.setVolume(deviceId, volume);
  }

  /// 获取音量
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - 音量值（0-100）
  static Future<int> getVolume(String deviceId) {
    return FlutterJlSdkPlatform.instance.getVolume(deviceId);
  }

  /// 静音/取消静音
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [muted] 是否静音
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> setMuted(String deviceId, bool muted) {
    return FlutterJlSdkPlatform.instance.setMuted(deviceId, muted);
  }

  /// 获取静音状态
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - 是否静音
  static Future<bool> isMuted(String deviceId) {
    return FlutterJlSdkPlatform.instance.isMuted(deviceId);
  }

  /// EQ调节相关方法

  /// 设置EQ参数
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [eqControl] EQ控制参数
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> setEq(String deviceId, EqControl eqControl) {
    return FlutterJlSdkPlatform.instance.setEq(deviceId, eqControl);
  }

  /// 获取EQ参数
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - EQ控制参数
  static Future<EqControl> getEq(String deviceId) {
    return FlutterJlSdkPlatform.instance.getEq(deviceId);
  }

  /// 设置EQ预设
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [preset] EQ预设模式
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> setEqPreset(String deviceId, EqPreset preset) {
    return FlutterJlSdkPlatform.instance.setEqPreset(deviceId, preset);
  }

  /// 音效调节相关方法

  /// 设置音效参数
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [soundEffect] 音效控制参数
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> setSoundEffect(String deviceId, SoundEffectControl soundEffect) {
    return FlutterJlSdkPlatform.instance.setSoundEffect(deviceId, soundEffect);
  }

  /// 获取音效参数
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - 音效控制参数
  static Future<SoundEffectControl> getSoundEffect(String deviceId) {
    return FlutterJlSdkPlatform.instance.getSoundEffect(deviceId);
  }

  /// 闹钟管理相关方法

  /// 添加闹钟
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [alarm] 闹钟信息
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> addAlarm(String deviceId, JlAlarm alarm) {
    return FlutterJlSdkPlatform.instance.addAlarm(deviceId, alarm);
  }

  /// 删除闹钟
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [alarmId] 闹钟ID
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> deleteAlarm(String deviceId, String alarmId) {
    return FlutterJlSdkPlatform.instance.deleteAlarm(deviceId, alarmId);
  }

  /// 更新闹钟
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [alarm] 闹钟信息
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> updateAlarm(String deviceId, JlAlarm alarm) {
    return FlutterJlSdkPlatform.instance.updateAlarm(deviceId, alarm);
  }

  /// 获取闹钟列表
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - 闹钟信息列表
  static Future<List<JlAlarm>> getAlarms(String deviceId) {
    return FlutterJlSdkPlatform.instance.getAlarms(deviceId);
  }

  /// FM控制相关方法

  /// 设置FM参数
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [fmControl] FM控制参数
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> setFm(String deviceId, FmControl fmControl) {
    return FlutterJlSdkPlatform.instance.setFm(deviceId, fmControl);
  }

  /// 获取FM参数
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - FM控制参数
  static Future<FmControl> getFm(String deviceId) {
    return FlutterJlSdkPlatform.instance.getFm(deviceId);
  }

  /// 灯光控制相关方法

  /// 设置灯光参数
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [lightControl] 灯光控制参数
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> setLight(String deviceId, LightControl lightControl) {
    return FlutterJlSdkPlatform.instance.setLight(deviceId, lightControl);
  }

  /// 获取灯光参数
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - 灯光控制参数
  static Future<LightControl> getLight(String deviceId) {
    return FlutterJlSdkPlatform.instance.getLight(deviceId);
  }

  /// ANC控制相关方法

  /// 设置ANC参数
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [ancControl] ANC控制参数
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> setAnc(String deviceId, AncControl ancControl) {
    return FlutterJlSdkPlatform.instance.setAnc(deviceId, ancControl);
  }

  /// 获取ANC参数
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - ANC控制参数
  static Future<AncControl> getAnc(String deviceId) {
    return FlutterJlSdkPlatform.instance.getAnc(deviceId);
  }

  /// 按键设置相关方法

  /// 设置按键功能
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [keySettings] 按键设置参数
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> setKeySettings(String deviceId, KeySettings keySettings) {
    return FlutterJlSdkPlatform.instance.setKeySettings(deviceId, keySettings);
  }

  /// 获取按键设置
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - 按键设置参数
  static Future<KeySettings> getKeySettings(String deviceId) {
    return FlutterJlSdkPlatform.instance.getKeySettings(deviceId);
  }

  /// 查找设备相关方法

  /// 查找设备
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [findDevice] 查找设备参数
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> findDevice(String deviceId, FindDeviceParams findDevice) {
    return FlutterJlSdkPlatform.instance.findDevice(deviceId, findDevice);
  }

  /// 自定义命令相关方法

  /// 发送自定义命令
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [command] 自定义命令参数
  /// 
  /// 返回值：
  /// - 命令响应数据
  static Future<String> sendCustomCommand(String deviceId, CustomCommand command) {
    return FlutterJlSdkPlatform.instance.sendCustomCommand(deviceId, command);
  }

  /// 文件浏览相关方法

  /// 获取文件列表
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [path] 文件路径
  /// 
  /// 返回值：
  /// - 文件信息列表
  static Future<List<JlFileInfo>> getFiles(String deviceId, String path) {
    return FlutterJlSdkPlatform.instance.getFiles(deviceId, path);
  }

  /// OTA升级相关方法

  /// 开始OTA升级
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// - [firmwarePath] 固件文件路径
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> startOta(String deviceId, String firmwarePath) {
    return FlutterJlSdkPlatform.instance.startOta(deviceId, firmwarePath);
  }

  /// 获取OTA进度
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - 进度（0.0-1.0）
  static Future<double> getOtaProgress(String deviceId) {
    return FlutterJlSdkPlatform.instance.getOtaProgress(deviceId);
  }

  /// 取消OTA升级
  /// 
  /// 参数：
  /// - [deviceId] 设备ID
  /// 
  /// 返回值：
  /// - true: 操作成功
  /// - false: 操作失败
  static Future<bool> cancelOta(String deviceId) {
    return FlutterJlSdkPlatform.instance.cancelOta(deviceId);
  }

  /// 事件流相关方法

  /// 获取设备状态变化流
  /// 
  /// 监听此流可以获取设备连接状态、信号强度等变化
  static Stream<JlDeviceInfo> get deviceStatusStream {
    return FlutterJlSdkPlatform.instance.deviceStatusStream;
  }

  /// 获取音乐信息变化流
  /// 
  /// 监听此流可以获取音乐播放状态、进度等变化
  static Stream<JlMusicInfo> get musicInfoStream {
    return FlutterJlSdkPlatform.instance.musicInfoStream;
  }

  /// 获取错误信息流
  /// 
  /// 监听此流可以获取SDK错误信息
  static Stream<JlError> get errorStream {
    return FlutterJlSdkPlatform.instance.errorStream;
  }

  /// 设置平台实例（用于测试或自定义实现）
  static set instance(FlutterJlSdkPlatform instance) {
    FlutterJlSdkPlatform.instance = instance;
  }

  /// 获取平台实例
  static FlutterJlSdkPlatform get instance {
    return FlutterJlSdkPlatform.instance;
  }
}

/// 导出所有模型类，方便用户使用
export 'src/models/device_info.dart';
export 'src/models/music_info.dart';
export 'src/models/device_control.dart';
export 'flutter_jl_sdk_platform_interface.dart';
export 'flutter_jl_sdk_method_channel.dart';