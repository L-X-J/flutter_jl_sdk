/// 杰理设备信息模型
class JlDeviceInfo {
  /// 设备ID
  final String deviceId;

  /// 设备名称
  final String deviceName;

  /// 设备MAC地址
  final String? macAddress;

  /// 设备类型 (耳机/音箱/声卡等)
  final DeviceType deviceType;

  /// 设备信号强度
  final int rssi;

  /// 设备固件版本
  final String? firmwareVersion;

  /// 设备连接状态
  final ConnectionStatus connectionStatus;

  /// 设备电量 (0-100)
  final int? batteryLevel;

  /// 设备功能支持列表
  final List<DeviceFeature> supportedFeatures;

  /// 创建时间
  final DateTime? createdAt;

  JlDeviceInfo({
    required this.deviceId,
    required this.deviceName,
    this.macAddress,
    required this.deviceType,
    required this.rssi,
    this.firmwareVersion,
    required this.connectionStatus,
    this.batteryLevel,
    required this.supportedFeatures,
    this.createdAt,
  });

  /// 从JSON创建设备信息
  factory JlDeviceInfo.fromJson(Map<String, dynamic> json) {
    return JlDeviceInfo(
      deviceId: json['deviceId'] as String,
      deviceName: json['deviceName'] as String,
      macAddress: json['macAddress'] as String?,
      deviceType: DeviceType.fromString(json['deviceType'] as String),
      rssi: json['rssi'] as int,
      firmwareVersion: json['firmwareVersion'] as String?,
      connectionStatus: ConnectionStatus.fromString(json['connectionStatus'] as String),
      batteryLevel: json['batteryLevel'] as int?,
      supportedFeatures: (json['supportedFeatures'] as List<dynamic>)
          .map((e) => DeviceFeature.fromString(e as String))
          .toList(),
      createdAt: json['createdAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int)
          : null,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'deviceName': deviceName,
      'macAddress': macAddress,
      'deviceType': deviceType.toString(),
      'rssi': rssi,
      'firmwareVersion': firmwareVersion,
      'connectionStatus': connectionStatus.toString(),
      'batteryLevel': batteryLevel,
      'supportedFeatures': supportedFeatures.map((e) => e.toString()).toList(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  /// 复制设备信息并更新指定字段
  JlDeviceInfo copyWith({
    String? deviceId,
    String? deviceName,
    String? macAddress,
    DeviceType? deviceType,
    int? rssi,
    String? firmwareVersion,
    ConnectionStatus? connectionStatus,
    int? batteryLevel,
    List<DeviceFeature>? supportedFeatures,
    DateTime? createdAt,
  }) {
    return JlDeviceInfo(
      deviceId: deviceId ?? this.deviceId,
      deviceName: deviceName ?? this.deviceName,
      macAddress: macAddress ?? this.macAddress,
      deviceType: deviceType ?? this.deviceType,
      rssi: rssi ?? this.rssi,
      firmwareVersion: firmwareVersion ?? this.firmwareVersion,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      supportedFeatures: supportedFeatures ?? this.supportedFeatures,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'JlDeviceInfo(deviceId: $deviceId, deviceName: $deviceName, deviceType: $deviceType, connectionStatus: $connectionStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is JlDeviceInfo &&
        other.deviceId == deviceId &&
        other.deviceName == deviceName &&
        other.deviceType == deviceType &&
        other.connectionStatus == connectionStatus;
  }

  @override
  int get hashCode {
    return deviceId.hashCode ^
        deviceName.hashCode ^
        deviceType.hashCode ^
        connectionStatus.hashCode;
  }
}

/// 设备类型枚举
enum DeviceType {
  headphone,      // 耳机
  speaker,        // 音箱
  soundCard,      // 声卡
  unknown;        // 未知

  static DeviceType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'headphone':
      case '耳机':
        return DeviceType.headphone;
      case 'speaker':
      case '音箱':
        return DeviceType.speaker;
      case 'soundcard':
      case '声卡':
        return DeviceType.soundCard;
      default:
        return DeviceType.unknown;
    }
  }

  @override
  String toString() {
    switch (this) {
      case DeviceType.headphone:
        return 'headphone';
      case DeviceType.speaker:
        return 'speaker';
      case DeviceType.soundCard:
        return 'soundCard';
      case DeviceType.unknown:
        return 'unknown';
    }
  }
}

/// 设备连接状态枚举
enum ConnectionStatus {
  disconnected,   // 已断开
  connecting,     // 连接中
  connected,      // 已连接
  disconnecting;  // 断开中

  static ConnectionStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'disconnected':
      case '已断开':
        return ConnectionStatus.disconnected;
      case 'connecting':
      case '连接中':
        return ConnectionStatus.connecting;
      case 'connected':
      case '已连接':
        return ConnectionStatus.connected;
      case 'disconnecting':
      case '断开中':
        return ConnectionStatus.disconnecting;
      default:
        return ConnectionStatus.disconnected;
    }
  }

  @override
  String toString() {
    switch (this) {
      case ConnectionStatus.disconnected:
        return 'disconnected';
      case ConnectionStatus.connecting:
        return 'connecting';
      case ConnectionStatus.connected:
        return 'connected';
      case ConnectionStatus.disconnecting:
        return 'disconnecting';
    }
  }
}

/// 设备功能枚举
enum DeviceFeature {
  musicControl,      // 音乐控制
  volumeControl,     // 音量控制
  deviceSettings,    // 设备设置
  fileBrowse,        // 文件浏览
  alarmManagement,   // 闹钟管理
  fmControl,         // FM控制
  lightControl,      // 灯光控制
  eqControl,         // EQ调节
  soundEffect,       // 音效调节
  keySettings,       // 按键设置
  findDevice,        // 查找设备
  ancControl,        // ANC设置
  customCommand,     // 自定义命令
  otaUpdate;         // OTA升级

  static DeviceFeature fromString(String feature) {
    switch (feature.toLowerCase()) {
      case 'musiccontrol':
      case '音乐控制':
        return DeviceFeature.musicControl;
      case 'volumecontrol':
      case '音量控制':
        return DeviceFeature.volumeControl;
      case 'devicesettings':
      case '设备设置':
        return DeviceFeature.deviceSettings;
      case 'filebrowse':
      case '文件浏览':
        return DeviceFeature.fileBrowse;
      case 'alarmmanagement':
      case '闹钟管理':
        return DeviceFeature.alarmManagement;
      case 'fmcontrol':
      case 'fm控制':
        return DeviceFeature.fmControl;
      case 'lightcontrol':
      case '灯光控制':
        return DeviceFeature.lightControl;
      case 'eqcontrol':
      case 'eq调节':
        return DeviceFeature.eqControl;
      case 'soundeffect':
      case '音效调节':
        return DeviceFeature.soundEffect;
      case 'keysettings':
      case '按键设置':
        return DeviceFeature.keySettings;
      case 'finddevice':
      case '查找设备':
        return DeviceFeature.findDevice;
      case 'anccontrol':
      case 'anc设置':
        return DeviceFeature.ancControl;
      case 'customcommand':
      case '自定义命令':
        return DeviceFeature.customCommand;
      case 'otaupdate':
      case 'ota升级':
        return DeviceFeature.otaUpdate;
      default:
        return DeviceFeature.musicControl;
    }
  }

  @override
  String toString() {
    switch (this) {
      case DeviceFeature.musicControl:
        return 'musicControl';
      case DeviceFeature.volumeControl:
        return 'volumeControl';
      case DeviceFeature.deviceSettings:
        return 'deviceSettings';
      case DeviceFeature.fileBrowse:
        return 'fileBrowse';
      case DeviceFeature.alarmManagement:
        return 'alarmManagement';
      case DeviceFeature.fmControl:
        return 'fmControl';
      case DeviceFeature.lightControl:
        return 'lightControl';
      case DeviceFeature.eqControl:
        return 'eqControl';
      case DeviceFeature.soundEffect:
        return 'soundEffect';
      case DeviceFeature.keySettings:
        return 'keySettings';
      case DeviceFeature.findDevice:
        return 'findDevice';
      case DeviceFeature.ancControl:
        return 'ancControl';
      case DeviceFeature.customCommand:
        return 'customCommand';
      case DeviceFeature.otaUpdate:
        return 'otaUpdate';
    }
  }
}