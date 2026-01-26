import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'models/device_info.dart';
import 'models/music_info.dart';
import 'models/device_control.dart';

/// 杰理SDK平台接口
abstract class FlutterJlSdkPlatform extends PlatformInterface {
  /// 构造函数
  FlutterJlSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterJlSdkPlatform _instance = _FlutterJlSdkPlatform();

  /// 获取平台实例
  static FlutterJlSdkPlatform get instance => _instance;

  /// 设置平台实例（用于测试或自定义实现）
  static set instance(FlutterJlSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// 初始化SDK
  Future<bool> initialize() {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  /// 释放SDK资源
  Future<void> dispose() {
    throw UnimplementedError('dispose() has not been implemented.');
  }

  /// 扫描附近的杰理设备
  /// [timeout] 扫描超时时间（毫秒），默认10000ms
  /// [deviceTypes] 指定设备类型过滤，为空则扫描所有类型
  Future<List<JlDeviceInfo>> scanDevices({
    int timeout = 10000,
    List<DeviceType> deviceTypes = const [],
  }) {
    throw UnimplementedError('scanDevices() has not been implemented.');
  }

  /// 停止扫描
  Future<void> stopScan() {
    throw UnimplementedError('stopScan() has not been implemented.');
  }

  /// 连接设备
  /// [deviceId] 设备ID
  Future<bool> connectDevice(String deviceId) {
    throw UnimplementedError('connectDevice() has not been implemented.');
  }

  /// 断开设备连接
  /// [deviceId] 设备ID
  Future<bool> disconnectDevice(String deviceId) {
    throw UnimplementedError('disconnectDevice() has not been implemented.');
  }

  /// 获取设备连接状态
  /// [deviceId] 设备ID
  Future<ConnectionStatus> getConnectionStatus(String deviceId) {
    throw UnimplementedError('getConnectionStatus() has not been implemented.');
  }

  /// 获取已连接设备列表
  Future<List<JlDeviceInfo>> getConnectedDevices() {
    throw UnimplementedError('getConnectedDevices() has not been implemented.');
  }

  /// 音乐控制相关方法

  /// 播放
  /// [deviceId] 设备ID
  Future<bool> play(String deviceId) {
    throw UnimplementedError('play() has not been implemented.');
  }

  /// 暂停
  /// [deviceId] 设备ID
  Future<bool> pause(String deviceId) {
    throw UnimplementedError('pause() has not been implemented.');
  }

  /// 停止
  /// [deviceId] 设备ID
  Future<bool> stop(String deviceId) {
    throw UnimplementedError('stop() has not been implemented.');
  }

  /// 上一曲
  /// [deviceId] 设备ID
  Future<bool> previousTrack(String deviceId) {
    throw UnimplementedError('previousTrack() has not been implemented.');
  }

  /// 下一曲
  /// [deviceId] 设备ID
  Future<bool> nextTrack(String deviceId) {
    throw UnimplementedError('nextTrack() has not been implemented.');
  }

  /// 设置播放进度
  /// [deviceId] 设备ID
  /// [position] 进度（秒）
  Future<bool> seek(String deviceId, int position) {
    throw UnimplementedError('seek() has not been implemented.');
  }

  /// 设置播放模式
  /// [deviceId] 设备ID
  /// [mode] 播放模式
  Future<bool> setPlayMode(String deviceId, PlayMode mode) {
    throw UnimplementedError('setPlayMode() has not been implemented.');
  }

  /// 获取当前音乐信息
  /// [deviceId] 设备ID
  Future<JlMusicInfo> getCurrentMusicInfo(String deviceId) {
    throw UnimplementedError('getCurrentMusicInfo() has not been implemented.');
  }

  /// 音量控制相关方法

  /// 设置音量
  /// [deviceId] 设备ID
  /// [volume] 音量值（0-100）
  Future<bool> setVolume(String deviceId, int volume) {
    throw UnimplementedError('setVolume() has not been implemented.');
  }

  /// 获取音量
  /// [deviceId] 设备ID
  Future<int> getVolume(String deviceId) {
    throw UnimplementedError('getVolume() has not been implemented.');
  }

  /// 静音/取消静音
  /// [deviceId] 设备ID
  /// [muted] 是否静音
  Future<bool> setMuted(String deviceId, bool muted) {
    throw UnimplementedError('setMuted() has not been implemented.');
  }

  /// 获取静音状态
  /// [deviceId] 设备ID
  Future<bool> isMuted(String deviceId) {
    throw UnimplementedError('isMuted() has not been implemented.');
  }

  /// EQ调节相关方法

  /// 设置EQ参数
  /// [deviceId] 设备ID
  /// [eqControl] EQ控制参数
  Future<bool> setEq(String deviceId, EqControl eqControl) {
    throw UnimplementedError('setEq() has not been implemented.');
  }

  /// 获取EQ参数
  /// [deviceId] 设备ID
  Future<EqControl> getEq(String deviceId) {
    throw UnimplementedError('getEq() has not been implemented.');
  }

  /// 设置EQ预设
  /// [deviceId] 设备ID
  /// [preset] EQ预设模式
  Future<bool> setEqPreset(String deviceId, EqPreset preset) {
    throw UnimplementedError('setEqPreset() has not been implemented.');
  }

  /// 音效调节相关方法

  /// 设置音效参数
  /// [deviceId] 设备ID
  /// [soundEffect] 音效控制参数
  Future<bool> setSoundEffect(String deviceId, SoundEffectControl soundEffect) {
    throw UnimplementedError('setSoundEffect() has not been implemented.');
  }

  /// 获取音效参数
  /// [deviceId] 设备ID
  Future<SoundEffectControl> getSoundEffect(String deviceId) {
    throw UnimplementedError('getSoundEffect() has not been implemented.');
  }

  /// 闹钟管理相关方法

  /// 添加闹钟
  /// [deviceId] 设备ID
  /// [alarm] 闹钟信息
  Future<bool> addAlarm(String deviceId, JlAlarm alarm) {
    throw UnimplementedError('addAlarm() has not been implemented.');
  }

  /// 删除闹钟
  /// [deviceId] 设备ID
  /// [alarmId] 闹钟ID
  Future<bool> deleteAlarm(String deviceId, String alarmId) {
    throw UnimplementedError('deleteAlarm() has not been implemented.');
  }

  /// 更新闹钟
  /// [deviceId] 设备ID
  /// [alarm] 闹钟信息
  Future<bool> updateAlarm(String deviceId, JlAlarm alarm) {
    throw UnimplementedError('updateAlarm() has not been implemented.');
  }

  /// 获取闹钟列表
  /// [deviceId] 设备ID
  Future<List<JlAlarm>> getAlarms(String deviceId) {
    throw UnimplementedError('getAlarms() has not been implemented.');
  }

  /// FM控制相关方法

  /// 设置FM参数
  /// [deviceId] 设备ID
  /// [fmControl] FM控制参数
  Future<bool> setFm(String deviceId, FmControl fmControl) {
    throw UnimplementedError('setFm() has not been implemented.');
  }

  /// 获取FM参数
  /// [deviceId] 设备ID
  Future<FmControl> getFm(String deviceId) {
    throw UnimplementedError('getFm() has not been implemented.');
  }

  /// 灯光控制相关方法

  /// 设置灯光参数
  /// [deviceId] 设备ID
  /// [lightControl] 灯光控制参数
  Future<bool> setLight(String deviceId, LightControl lightControl) {
    throw UnimplementedError('setLight() has not been implemented.');
  }

  /// 获取灯光参数
  /// [deviceId] 设备ID
  Future<LightControl> getLight(String deviceId) {
    throw UnimplementedError('getLight() has not been implemented.');
  }

  /// ANC控制相关方法

  /// 设置ANC参数
  /// [deviceId] 设备ID
  /// [ancControl] ANC控制参数
  Future<bool> setAnc(String deviceId, AncControl ancControl) {
    throw UnimplementedError('setAnc() has not been implemented.');
  }

  /// 获取ANC参数
  /// [deviceId] 设备ID
  Future<AncControl> getAnc(String deviceId) {
    throw UnimplementedError('getAnc() has not been implemented.');
  }

  /// 按键设置相关方法

  /// 设置按键功能
  /// [deviceId] 设备ID
  /// [keySettings] 按键设置参数
  Future<bool> setKeySettings(String deviceId, KeySettings keySettings) {
    throw UnimplementedError('setKeySettings() has not been implemented.');
  }

  /// 获取按键设置
  /// [deviceId] 设备ID
  Future<KeySettings> getKeySettings(String deviceId) {
    throw UnimplementedError('getKeySettings() has not been implemented.');
  }

  /// 查找设备相关方法

  /// 查找设备
  /// [deviceId] 设备ID
  /// [findDevice] 查找设备参数
  Future<bool> findDevice(String deviceId, FindDeviceParams findDevice) {
    throw UnimplementedError('findDevice() has not been implemented.');
  }

  /// 自定义命令相关方法

  /// 发送自定义命令
  /// [deviceId] 设备ID
  /// [command] 自定义命令参数
  Future<String> sendCustomCommand(String deviceId, CustomCommand command) {
    throw UnimplementedError('sendCustomCommand() has not been implemented.');
  }

  /// 文件浏览相关方法

  /// 获取文件列表
  /// [deviceId] 设备ID
  /// [path] 文件路径
  Future<List<JlFileInfo>> getFiles(String deviceId, String path) {
    throw UnimplementedError('getFiles() has not been implemented.');
  }

  /// OTA升级相关方法

  /// 开始OTA升级
  /// [deviceId] 设备ID
  /// [firmwarePath] 固件文件路径
  Future<bool> startOta(String deviceId, String firmwarePath) {
    throw UnimplementedError('startOta() has not been implemented.');
  }

  /// 获取OTA进度
  /// [deviceId] 设备ID
  Future<double> getOtaProgress(String deviceId) {
    throw UnimplementedError('getOtaProgress() has not been implemented.');
  }

  /// 取消OTA升级
  /// [deviceId] 设备ID
  Future<bool> cancelOta(String deviceId) {
    throw UnimplementedError('cancelOta() has not been implemented.');
  }

  /// 事件流相关方法

  /// 获取设备状态变化流
  Stream<JlDeviceInfo> get deviceStatusStream {
    throw UnimplementedError('deviceStatusStream has not been implemented.');
  }

  /// 获取音乐信息变化流
  Stream<JlMusicInfo> get musicInfoStream {
    throw UnimplementedError('musicInfoStream has not been implemented.');
  }

  /// 获取错误信息流
  Stream<JlError> get errorStream {
    throw UnimplementedError('errorStream has not been implemented.');
  }
}

/// 杰理SDK错误类
class JlError {
  /// 错误码
  final String errorCode;

  /// 错误信息
  final String errorMessage;

  /// 设备ID（可选）
  final String? deviceId;

  /// 原始错误（可选）
  final dynamic originalError;

  JlError({
    required this.errorCode,
    required this.errorMessage,
    this.deviceId,
    this.originalError,
  });

  @override
  String toString() {
    return 'JlError(errorCode: $errorCode, errorMessage: $errorMessage, deviceId: $deviceId)';
  }
}

/// 默认实现（用于占位）
class _FlutterJlSdkPlatform extends FlutterJlSdkPlatform {
  @override
  Future<bool> initialize() async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<void> dispose() async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<List<JlDeviceInfo>> scanDevices({
    int timeout = 10000,
    List<DeviceType> deviceTypes = const [],
  }) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<void> stopScan() async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> connectDevice(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> disconnectDevice(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<ConnectionStatus> getConnectionStatus(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<List<JlDeviceInfo>> getConnectedDevices() async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> play(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> pause(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> stop(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> previousTrack(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> nextTrack(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> seek(String deviceId, int position) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> setPlayMode(String deviceId, PlayMode mode) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<JlMusicInfo> getCurrentMusicInfo(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> setVolume(String deviceId, int volume) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<int> getVolume(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> setMuted(String deviceId, bool muted) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> isMuted(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> setEq(String deviceId, EqControl eqControl) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<EqControl> getEq(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> setEqPreset(String deviceId, EqPreset preset) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> setSoundEffect(String deviceId, SoundEffectControl soundEffect) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<SoundEffectControl> getSoundEffect(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> addAlarm(String deviceId, JlAlarm alarm) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> deleteAlarm(String deviceId, String alarmId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> updateAlarm(String deviceId, JlAlarm alarm) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<List<JlAlarm>> getAlarms(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> setFm(String deviceId, FmControl fmControl) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<FmControl> getFm(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> setLight(String deviceId, LightControl lightControl) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<LightControl> getLight(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> setAnc(String deviceId, AncControl ancControl) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<AncControl> getAnc(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> setKeySettings(String deviceId, KeySettings keySettings) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<KeySettings> getKeySettings(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> findDevice(String deviceId, FindDeviceParams findDevice) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<String> sendCustomCommand(String deviceId, CustomCommand command) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<List<JlFileInfo>> getFiles(String deviceId, String path) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> startOta(String deviceId, String firmwarePath) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<double> getOtaProgress(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Future<bool> cancelOta(String deviceId) async {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Stream<JlDeviceInfo> get deviceStatusStream {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Stream<JlMusicInfo> get musicInfoStream {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }

  @override
  Stream<JlError> get errorStream {
    throw UnimplementedError('FlutterJlSdkPlatform has not been initialized.');
  }
}