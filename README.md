# Flutter JieLi SDK Plugin

杰理SDK Flutter封装版本 - 支持蓝牙设备连接、音乐控制、设备设置等功能

## 功能特性

### 设备管理
- ✅ 设备扫描与发现
- ✅ 蓝牙设备连接/断开
- ✅ 连接状态监控
- ✅ 已连接设备列表

### 音乐控制
- ✅ 播放/暂停/停止
- ✅ 上一曲/下一曲
- ✅ 进度控制（Seek）
- ✅ 播放模式设置（单曲循环、列表循环、随机播放等）
- ✅ 当前音乐信息获取

### 音量控制
- ✅ 音量设置与获取
- ✅ 静音控制

### 音频调节
- ✅ EQ（均衡器）调节
- ✅ EQ预设（正常、摇滚、流行、爵士、古典、自定义）
- ✅ 音效调节（混响、低音增强、高音增强）

### 设备功能
- ✅ 闹钟管理（添加、删除、更新、列表）
- ✅ FM控制（接收器/发射器模式）
- ✅ 灯光控制（常亮、闪烁、呼吸、彩虹模式）
- ✅ ANC（主动降噪）控制
- ✅ 按键设置与自定义映射
- ✅ 设备查找功能
- ✅ 自定义命令发送

### 高级功能
- ✅ 文件浏览（SD卡、USB驱动器）
- ✅ OTA固件升级
- ✅ 事件流推送（设备状态、音乐信息、错误信息）

## 安装

### 1. 添加依赖

在 `pubspec.yaml` 中添加：

```yaml
dependencies:
  flutter_jl_sdk: ^0.0.1
```

### 2. 安装依赖

```bash
flutter pub get
```

### 3. Android配置

在 `android/app/build.gradle` 中添加权限：

```gradle
android {
    defaultConfig {
        // 添加蓝牙权限
        manifestPlaceholders = [
            "com.yuanquz.flutter.plugin.jl.BLUETOOTH_PERMISSION": "true"
        ]
    }
}
```

在 `AndroidManifest.xml` 中添加：

```xml
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### 4. iOS配置

在 `ios/Runner/Info.plist` 中添加：

```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>需要蓝牙权限来连接和控制杰理设备</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>需要蓝牙权限来连接和控制杰理设备</string>
```

## 快速开始

### 1. 初始化SDK

```dart
import 'package:flutter_jl_sdk/flutter_jl_sdk.dart';

void main() async {
  // 初始化SDK
  final initialized = await FlutterJlSdk.initialize();
  if (!initialized) {
    print('SDK初始化失败');
    return;
  }
  
  runApp(MyApp());
}
```

### 2. 扫描设备

```dart
// 扫描所有设备（默认超时10秒）
List<JlDeviceInfo> devices = await FlutterJlSdk.scanDevices();

// 扫描特定类型设备（如耳机）
List<JlDeviceInfo> headphones = await FlutterJlSdk.scanDevices(
  deviceTypes: [DeviceType.headphone],
  timeout: 5000, // 5秒超时
);

// 显示扫描结果
for (var device in devices) {
  print('设备: ${device.deviceName}, 类型: ${device.deviceType}');
}
```

### 3. 连接设备

```dart
// 连接设备
final connected = await FlutterJlSdk.connectDevice(device.deviceId);
if (connected) {
  print('设备连接成功');
  
  // 监听连接状态
  final status = await FlutterJlSdk.getConnectionStatus(device.deviceId);
  print('连接状态: $status');
}
```

### 4. 音乐控制

```dart
// 播放
await FlutterJlSdk.play(device.deviceId);

// 暂停
await FlutterJlSdk.pause(device.deviceId);

// 下一曲
await FlutterJlSdk.nextTrack(device.deviceId);

// 上一曲
await FlutterJlSdk.previousTrack(device.deviceId);

// 设置进度（单位：秒）
await FlutterJlSdk.seek(device.deviceId, 60);

// 设置播放模式
await FlutterJlSdk.setPlayMode(device.deviceId, PlayMode.repeatAll);

// 获取当前音乐信息
JlMusicInfo musicInfo = await FlutterJlSdk.getCurrentMusicInfo(device.deviceId);
print('当前歌曲: ${musicInfo.title} - ${musicInfo.artist}');
print('播放状态: ${musicInfo.playStatus}');
print('进度: ${musicInfo.position}/${musicInfo.duration}');
```

### 5. 音量控制

```dart
// 设置音量（0-100）
await FlutterJlSdk.setVolume(device.deviceId, 75);

// 获取音量
int volume = await FlutterJlSdk.getVolume(device.deviceId);

// 静音
await FlutterJlSdk.setMuted(device.deviceId, true);

// 取消静音
await FlutterJlSdk.setMuted(device.deviceId, false);

// 检查是否静音
bool isMuted = await FlutterJlSdk.isMuted(device.deviceId);
```

### 6. EQ调节

```dart
// 设置自定义EQ
final eqControl = EqControl(
  preset: EqPreset.custom,
  bass: 2,    // 低音 (-10 ~ 10)
  mid: 0,     // 中音 (-10 ~ 10)
  treble: -1, // 高音 (-10 ~ 10)
);
await FlutterJlSdk.setEq(device.deviceId, eqControl);

// 设置EQ预设
await FlutterJlSdk.setEqPreset(device.deviceId, EqPreset.rock);

// 获取当前EQ
EqControl currentEq = await FlutterJlSdk.getEq(device.deviceId);
```

### 7. 音效调节

```dart
// 设置音效
final soundEffect = SoundEffectControl(
  reverb: 50,      // 混响 (0-100)
  bassBoost: 30,   // 低音增强 (0-100)
  trebleBoost: 20, // 高音增强 (0-100)
);
await FlutterJlSdk.setSoundEffect(device.deviceId, soundEffect);

// 获取当前音效
SoundEffectControl currentEffect = await FlutterJlSdk.getSoundEffect(device.deviceId);
```

### 8. 闹钟管理

```dart
// 添加闹钟
final alarm = JlAlarm(
  alarmId: 'alarm-1',
  hour: 7,
  minute: 30,
  repeatDays: [1, 2, 3, 4, 5], // 周一到周五
  enabled: true,
);
await FlutterJlSdk.addAlarm(device.deviceId, alarm);

// 获取闹钟列表
List<JlAlarm> alarms = await FlutterJlSdk.getAlarms(device.deviceId);

// 更新闹钟
final updatedAlarm = JlAlarm(
  alarmId: 'alarm-1',
  hour: 8,
  minute: 0,
  repeatDays: [1, 2, 3, 4, 5, 6, 7], // 每天
  enabled: true,
);
await FlutterJlSdk.updateAlarm(device.deviceId, updatedAlarm);

// 删除闹钟
await FlutterJlSdk.deleteAlarm(device.deviceId, 'alarm-1');
```

### 9. FM控制

```dart
// 设置FM接收器
final fmControl = FmControl(
  mode: FmMode.receiver,
  frequency: 101.5, // 频率 (MHz)
);
await FlutterJlSdk.setFm(device.deviceId, fmControl);

// 获取FM设置
FmControl currentFm = await FlutterJlSdk.getFm(device.deviceId);
```

### 10. 灯光控制

```dart
// 设置灯光
final lightControl = LightControl(
  mode: LightMode.solid, // 常亮模式
  color: LightColor.red, // 红色
  brightness: 80,        // 亮度 (0-100)
);
await FlutterJlSdk.setLight(device.deviceId, lightControl);

// 获取灯光设置
LightControl currentLight = await FlutterJlSdk.getLight(device.deviceId);
```

### 11. ANC控制

```dart
// 设置ANC
final ancControl = AncControl(
  mode: AncMode.activeNoiseCancel, // 主动降噪模式
  intensity: 80,                   // 强度 (0-100)
);
await FlutterJlSdk.setAnc(device.deviceId, ancControl);

// 获取ANC设置
AncControl currentAnc = await FlutterJlSdk.getAnc(device.deviceId);
```

### 12. 按键设置

```dart
// 设置按键映射
final keySettings = KeySettings(keyMap: {
  KeyAction.doubleClick: KeyAction.playPause, // 双击：播放/暂停
  KeyAction.longPress: KeyAction.findDevice,  // 长按：查找设备
});
await FlutterJlSdk.setKeySettings(device.deviceId, keySettings);

// 获取按键设置
KeySettings currentSettings = await FlutterJlSdk.getKeySettings(device.deviceId);
```

### 13. 查找设备

```dart
// 查找设备（让设备发出声音或闪烁灯光）
final params = FindDeviceParams(
  mode: FindDeviceMode.blink, // 闪烁模式
  duration: 30,               // 持续时间（秒）
);
await FlutterJlSdk.findDevice(device.deviceId, params);
```

### 14. 自定义命令

```dart
// 发送自定义命令
final command = CustomCommand(
  commandId: 'custom-1',
  data: {'key': 'value'},
);
String response = await FlutterJlSdk.sendCustomCommand(device.deviceId, command);
print('设备响应: $response');
```

### 15. 文件浏览

```dart
// 获取文件列表
List<JlFileInfo> files = await FlutterJlSdk.getFiles(device.deviceId, '/music');
for (var file in files) {
  print('文件: ${file.name}, 大小: ${file.size} bytes');
}
```

### 16. OTA升级

```dart
// 开始OTA升级
final otaStarted = await FlutterJlSdk.startOta(device.deviceId, '/firmware.bin');
if (otaStarted) {
  print('OTA升级开始');
  
  // 监听升级进度
  Timer.periodic(Duration(seconds: 1), (timer) async {
    double progress = await FlutterJlSdk.getOtaProgress(device.deviceId);
    print('升级进度: ${(progress * 100).toStringAsFixed(1)}%');
    
    if (progress >= 1.0) {
      timer.cancel();
      print('OTA升级完成');
    }
  });
}

// 取消OTA升级
await FlutterJlSdk.cancelOta(device.deviceId);
```

### 17. 事件监听

```dart
// 监听设备状态变化
FlutterJlSdk.onDeviceStatusChanged.listen((status) {
  print('设备状态变化: ${status.deviceId} - ${status.connectionStatus}');
});

// 监听音乐信息变化
FlutterJlSdk.onMusicInfoChanged.listen((musicInfo) {
  print('音乐信息更新: ${musicInfo.title}');
});

// 监听错误信息
FlutterJlSdk.onError.listen((error) {
  print('错误: ${error.code} - ${error.message}');
});
```

### 18. 释放资源

```dart
// 释放SDK资源
await FlutterJlSdk.dispose();
```

## API参考

### FlutterJlSdk类

#### 初始化与释放
- `static Future<bool> initialize()` - 初始化SDK
- `static Future<void> dispose()` - 释放SDK资源

#### 设备管理
- `static Future<List<JlDeviceInfo>> scanDevices({int timeout, List<DeviceType> deviceTypes})` - 扫描设备
- `static Future<void> stopScan()` - 停止扫描
- `static Future<bool> connectDevice(String deviceId)` - 连接设备
- `static Future<bool> disconnectDevice(String deviceId)` - 断开设备
- `static Future<ConnectionStatus> getConnectionStatus(String deviceId)` - 获取连接状态
- `static Future<List<JlDeviceInfo>> getConnectedDevices()` - 获取已连接设备列表

#### 音乐控制
- `static Future<bool> play(String deviceId)` - 播放
- `static Future<bool> pause(String deviceId)` - 暂停
- `static Future<bool> stop(String deviceId)` - 停止
- `static Future<bool> previousTrack(String deviceId)` - 上一曲
- `static Future<bool> nextTrack(String deviceId)` - 下一曲
- `static Future<bool> seek(String deviceId, int position)` - 设置进度
- `static Future<bool> setPlayMode(String deviceId, PlayMode mode)` - 设置播放模式
- `static Future<JlMusicInfo> getCurrentMusicInfo(String deviceId)` - 获取当前音乐信息

#### 音量控制
- `static Future<bool> setVolume(String deviceId, int volume)` - 设置音量
- `static Future<int> getVolume(String deviceId)` - 获取音量
- `static Future<bool> setMuted(String deviceId, bool muted)` - 设置静音
- `static Future<bool> isMuted(String deviceId)` - 检查是否静音

#### EQ调节
- `static Future<bool> setEq(String deviceId, EqControl eqControl)` - 设置EQ
- `static Future<EqControl> getEq(String deviceId)` - 获取EQ
- `static Future<bool> setEqPreset(String deviceId, EqPreset preset)` - 设置EQ预设

#### 音效调节
- `static Future<bool> setSoundEffect(String deviceId, SoundEffectControl soundEffect)` - 设置音效
- `static Future<SoundEffectControl> getSoundEffect(String deviceId)` - 获取音效

#### 闹钟管理
- `static Future<bool> addAlarm(String deviceId, JlAlarm alarm)` - 添加闹钟
- `static Future<bool> deleteAlarm(String deviceId, String alarmId)` - 删除闹钟
- `static Future<bool> updateAlarm(String deviceId, JlAlarm alarm)` - 更新闹钟
- `static Future<List<JlAlarm>> getAlarms(String deviceId)` - 获取闹钟列表

#### FM控制
- `static Future<bool> setFm(String deviceId, FmControl fmControl)` - 设置FM
- `static Future<FmControl> getFm(String deviceId)` - 获取FM

#### 灯光控制
- `static Future<bool> setLight(String deviceId, LightControl lightControl)` - 设置灯光
- `static Future<LightControl> getLight(String deviceId)` - 获取灯光

#### ANC控制
- `static Future<bool> setAnc(String deviceId, AncControl ancControl)` - 设置ANC
- `static Future<AncControl> getAnc(String deviceId)` - 获取ANC

#### 按键设置
- `static Future<bool> setKeySettings(String deviceId, KeySettings keySettings)` - 设置按键
- `static Future<KeySettings> getKeySettings(String deviceId)` - 获取按键设置

#### 查找设备
- `static Future<bool> findDevice(String deviceId, FindDeviceParams params)` - 查找设备

#### 自定义命令
- `static Future<String> sendCustomCommand(String deviceId, CustomCommand command)` - 发送自定义命令

#### 文件浏览
- `static Future<List<JlFileInfo>> getFiles(String deviceId, String path)` - 获取文件列表

#### OTA升级
- `static Future<bool> startOta(String deviceId, String firmwarePath)` - 开始OTA升级
- `static Future<double> getOtaProgress(String deviceId)` - 获取OTA进度
- `static Future<bool> cancelOta(String deviceId)` - 取消OTA升级

#### 事件监听
- `static Stream<DeviceStatus> get onDeviceStatusChanged` - 设备状态变化事件
- `static Stream<JlMusicInfo> get onMusicInfoChanged` - 音乐信息变化事件
- `static Stream<JlError> get onError` - 错误事件

## 数据模型

### JlDeviceInfo
```dart
class JlDeviceInfo {
  final String deviceId;           // 设备ID
  final String deviceName;         // 设备名称
  final DeviceType deviceType;     // 设备类型
  final ConnectionStatus connectionStatus; // 连接状态
  final List<DeviceFeature> supportedFeatures; // 支持的功能
}
```

### JlMusicInfo
```dart
class JlMusicInfo {
  final String? title;             // 歌曲标题
  final String? artist;            // 艺术家
  final PlayStatus playStatus;     // 播放状态
  final PlayMode playMode;         // 播放模式
  final int duration;              // 总时长（秒）
  final int position;              // 当前进度（秒）
}
```

### JlAlarm
```dart
class JlAlarm {
  final String alarmId;            // 闹钟ID
  final int hour;                  // 小时
  final int minute;                // 分钟
  final List<int> repeatDays;      // 重复日期（1-7）
  final bool enabled;              // 是否启用
}
```

## 错误处理

插件使用标准的异常处理机制：

```dart
try {
  await FlutterJlSdk.connectDevice(deviceId);
} on PlatformException catch (e) {
  print('错误代码: ${e.code}');
  print('错误信息: ${e.message}');
  print('错误详情: ${e.details}');
} catch (e) {
  print('未知错误: $e');
}
```

### 常见错误代码

| 错误代码 | 描述 | 解决方案 |
|---------|------|---------|
| `INVALID_DEVICE_ID` | 设备ID无效 | 检查设备ID是否为空或格式错误 |
| `DEVICE_NOT_FOUND` | 设备未找到 | 确保设备在范围内并已开启蓝牙 |
| `BLUETOOTH_DISABLED` | 蓝牙未启用 | 启用设备蓝牙 |
| `PERMISSION_DENIED` | 权限被拒绝 | 检查应用权限设置 |
| `CONNECTION_FAILED` | 连接失败 | 重试连接或检查设备状态 |
| `DEVICE_DISCONNECTED` | 设备已断开 | 重新连接设备 |
| `NOT_SUPPORTED` | 功能不支持 | 检查设备是否支持该功能 |
| `OTA_FAILED` | OTA升级失败 | 检查固件文件和网络连接 |
| `INITIALIZE_ERROR` | SDK初始化失败 | 检查SDK集成和权限 |

## 线程安全

插件内部使用异步编程（async/await）和协程（Kotlin）确保线程安全。所有操作都在后台线程执行，不会阻塞UI线程。

## 内存管理

- 使用 `dispose()` 方法释放SDK资源
- 及时取消事件监听器
- 避免长时间持有设备引用

## 性能优化

1. **批量操作**：避免频繁调用API，尽量批量处理
2. **事件监听**：使用事件流而不是轮询
3. **资源释放**：及时释放不再使用的资源
4. **错误重试**：实现适当的重试机制

## 常见问题

### Q: 设备扫描不到？
A: 
1. 确保设备已开启并处于可发现模式
2. 检查蓝牙权限是否已授予
3. 确保设备在蓝牙范围内（通常10米内）
4. 尝试重启设备蓝牙

### Q: 连接失败？
A:
1. 确保设备未被其他应用连接
2. 检查设备电量
3. 尝试断开后重新连接
4. 重启设备

### Q: 音乐控制无效？
A:
1. 确保设备支持音乐控制功能
2. 检查设备是否正在播放音乐
3. 确认连接状态正常

### Q: OTA升级失败？
A:
1. 确保固件文件完整且兼容
2. 检查设备电量充足（建议>50%）
3. 保持设备在蓝牙范围内
4. 不要在升级过程中断开连接

### Q: 权限错误？
A:
1. 检查AndroidManifest.xml权限配置
2. 检查Info.plist权限配置
3. 在应用设置中授予必要权限
4. 重启应用

## 开发指南

### 集成JieLi SDK

由于杰理官方SDK需要单独集成，您需要：

1. 获取杰理官方SDK库文件（JL_BLEKit.framework, JL_OTALib.framework等）
2. 将SDK库文件添加到项目中
3. 在Android的`build.gradle`中添加依赖
4. 在iOS的`Podfile`中添加依赖
5. 更新`FlutterJlSdkPlugin.kt`和`FlutterJlSdkPlugin.swift`中的实际SDK调用

### 调试技巧

1. **启用日志**：在开发环境中启用详细日志
2. **使用模拟器**：在没有真实设备时使用模拟数据测试
3. **错误追踪**：实现错误回调来追踪问题
4. **性能监控**：监控内存使用和响应时间

## 贡献指南

1. Fork项目
2. 创建功能分支
3. 提交更改
4. 创建Pull Request

## 许可证

MIT License

## 支持

如有问题或建议，请提交Issue或联系项目维护者。

## 更新日志

### v0.0.1 (2026-01-16)
- ✅ 初始版本发布
- ✅ 实现所有基础功能
- ✅ 完整的单元测试和集成测试
- ✅ 详细的API文档
