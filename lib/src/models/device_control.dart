/// 闹钟信息模型
class JlAlarm {
  /// 闹钟ID
  final String alarmId;

  /// 闹钟时间（小时）
  final int hour;

  /// 闹钟时间（分钟）
  final int minute;

  /// 重复模式（周一到周日）
  final List<int> repeatDays; // 0-6, 0=周日

  /// 是否启用
  final bool enabled;

  /// 闹钟铃声ID
  final String? ringtoneId;

  /// 闹钟铃声名称
  final String? ringtoneName;

  /// 创建时间
  final DateTime? createdAt;

  JlAlarm({
    required this.alarmId,
    required this.hour,
    required this.minute,
    required this.repeatDays,
    this.enabled = true,
    this.ringtoneId,
    this.ringtoneName,
    this.createdAt,
  });

  factory JlAlarm.fromJson(Map<String, dynamic> json) {
    return JlAlarm(
      alarmId: json['alarmId'] as String,
      hour: json['hour'] as int,
      minute: json['minute'] as int,
      repeatDays: List<int>.from(json['repeatDays'] as List),
      enabled: json['enabled'] as bool? ?? true,
      ringtoneId: json['ringtoneId'] as String?,
      ringtoneName: json['ringtoneName'] as String?,
      createdAt: json['createdAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alarmId': alarmId,
      'hour': hour,
      'minute': minute,
      'repeatDays': repeatDays,
      'enabled': enabled,
      'ringtoneId': ringtoneId,
      'ringtoneName': ringtoneName,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  /// 获取格式化的时间字符串
  String get formattedTime {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// 获取重复模式描述
  String get repeatDescription {
    if (repeatDays.isEmpty) return '不重复';
    if (repeatDays.length == 7) return '每天';
    
    final dayNames = ['日', '一', '二', '三', '四', '五', '六'];
    return repeatDays.map((day) => '周${dayNames[day]}').join('、');
  }

  /// 检查是否在指定日期重复
  bool repeatsOn(int dayOfWeek) {
    return repeatDays.contains(dayOfWeek);
  }

  @override
  String toString() {
    return 'JlAlarm(alarmId: $alarmId, time: $formattedTime, repeat: $repeatDescription)';
  }
}

/// FM控制参数
class FmControl {
  /// 频率（MHz）
  final double frequency;

  /// 是否启用
  final bool enabled;

  /// 音量（0-100）
  final int volume;

  /// 模式（收音/发射）
  final FmMode mode;

  FmControl({
    required this.frequency,
    this.enabled = true,
    this.volume = 50,
    required this.mode,
  });

  factory FmControl.fromJson(Map<String, dynamic> json) {
    return FmControl(
      frequency: (json['frequency'] as num).toDouble(),
      enabled: json['enabled'] as bool? ?? true,
      volume: json['volume'] as int? ?? 50,
      mode: FmMode.fromString(json['mode'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'frequency': frequency,
      'enabled': enabled,
      'volume': volume,
      'mode': mode.toString(),
    };
  }

  /// 获取格式化的频率字符串
  String get formattedFrequency {
    return '${frequency.toStringAsFixed(1)} MHz';
  }
}

/// FM模式枚举
enum FmMode {
  receiver,   // 收音模式
  transmitter; // 发射模式

  static FmMode fromString(String mode) {
    switch (mode.toLowerCase()) {
      case 'receiver':
      case '收音':
        return FmMode.receiver;
      case 'transmitter':
      case '发射':
        return FmMode.transmitter;
      default:
        return FmMode.receiver;
    }
  }

  @override
  String toString() {
    switch (this) {
      case FmMode.receiver:
        return 'receiver';
      case FmMode.transmitter:
        return 'transmitter';
    }
  }
}

/// 灯光控制参数
class LightControl {
  /// 灯光模式
  final LightMode mode;

  /// 闪烁频率（Hz）
  final double? frequency;

  /// 颜色（RGB格式，如 "#FF0000"）
  final String? color;

  /// 亮度（0-100）
  final int? brightness;

  /// 是否启用
  final bool enabled;

  LightControl({
    required this.mode,
    this.frequency,
    this.color,
    this.brightness,
    this.enabled = true,
  });

  factory LightControl.fromJson(Map<String, dynamic> json) {
    return LightControl(
      mode: LightMode.fromString(json['mode'] as String),
      frequency: (json['frequency'] as num?)?.toDouble(),
      color: json['color'] as String?,
      brightness: json['brightness'] as int?,
      enabled: json['enabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mode': mode.toString(),
      'frequency': frequency,
      'color': color,
      'brightness': brightness,
      'enabled': enabled,
    };
  }
}

/// 灯光模式枚举
enum LightMode {
  solid,      // 常亮
  blink,      // 闪烁
  breathe,    // 呼吸
  rainbow,    // 彩虹
  custom;     // 自定义

  static LightMode fromString(String mode) {
    switch (mode.toLowerCase()) {
      case 'solid':
      case '常亮':
        return LightMode.solid;
      case 'blink':
      case '闪烁':
        return LightMode.blink;
      case 'breathe':
      case '呼吸':
        return LightMode.breathe;
      case 'rainbow':
      case '彩虹':
        return LightMode.rainbow;
      case 'custom':
      case '自定义':
        return LightMode.custom;
      default:
        return LightMode.solid;
    }
  }

  @override
  String toString() {
    switch (this) {
      case LightMode.solid:
        return 'solid';
      case LightMode.blink:
        return 'blink';
      case LightMode.breathe:
        return 'breathe';
      case LightMode.rainbow:
        return 'rainbow';
      case LightMode.custom:
        return 'custom';
    }
  }
}

/// ANC（主动降噪）控制参数
class AncControl {
  /// ANC模式
  final AncMode mode;

  /// 降噪强度（0-100，仅在自定义模式下有效）
  final int? intensity;

  AncControl({
    required this.mode,
    this.intensity,
  });

  factory AncControl.fromJson(Map<String, dynamic> json) {
    return AncControl(
      mode: AncMode.fromString(json['mode'] as String),
      intensity: json['intensity'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mode': mode.toString(),
      'intensity': intensity,
    };
  }
}

/// ANC模式枚举
enum AncMode {
  normal,         // 正常模式
  activeNoiseCancel, // 主动降噪
  transparent,    // 通透模式
  custom;         // 自定义模式

  static AncMode fromString(String mode) {
    switch (mode.toLowerCase()) {
      case 'normal':
      case '正常':
        return AncMode.normal;
      case 'activenoisecancel':
      case '主动降噪':
        return AncMode.activeNoiseCancel;
      case 'transparent':
      case '通透':
        return AncMode.transparent;
      case 'custom':
      case '自定义':
        return AncMode.custom;
      default:
        return AncMode.normal;
    }
  }

  @override
  String toString() {
    switch (this) {
      case AncMode.normal:
        return 'normal';
      case AncMode.activeNoiseCancel:
        return 'activeNoiseCancel';
      case AncMode.transparent:
        return 'transparent';
      case AncMode.custom:
        return 'custom';
    }
  }
}

/// 按键设置参数
class KeySettings {
  /// 按键功能映射
  final Map<KeyType, KeyFunction> keyMap;

  /// 双击间隔（毫秒）
  final int? doubleClickInterval;

  /// 长按时间（毫秒）
  final int? longPressTime;

  KeySettings({
    required this.keyMap,
    this.doubleClickInterval,
    this.longPressTime,
  });

  factory KeySettings.fromJson(Map<String, dynamic> json) {
    final keyMapJson = json['keyMap'] as Map<String, dynamic>;
    final keyMap = keyMapJson.map(
      (key, value) => MapEntry(
        KeyType.fromString(key),
        KeyFunction.fromString(value as String),
      ),
    );

    return KeySettings(
      keyMap: keyMap,
      doubleClickInterval: json['doubleClickInterval'] as int?,
      longPressTime: json['longPressTime'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'keyMap': keyMap.map((key, value) => MapEntry(key.toString(), value.toString())),
      'doubleClickInterval': doubleClickInterval,
      'longPressTime': longPressTime,
    };
  }
}

/// 按键类型枚举
enum KeyType {
  playPause,      // 播放/暂停
  previous,       // 上一曲
  next,           // 下一曲
  volumeUp,       // 音量+
  volumeDown,     // 音量-
  mode,           // 模式切换
  power,          // 电源
  anc,            // ANC切换
  custom1,        // 自定义1
  custom2;        // 自定义2

  static KeyType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'playpause':
      case '播放暂停':
        return KeyType.playPause;
      case 'previous':
      case '上一曲':
        return KeyType.previous;
      case 'next':
      case '下一曲':
        return KeyType.next;
      case 'volumeup':
      case '音量+':
        return KeyType.volumeUp;
      case 'volumedown':
      case '音量-':
        return KeyType.volumeDown;
      case 'mode':
      case '模式':
        return KeyType.mode;
      case 'power':
      case '电源':
        return KeyType.power;
      case 'anc':
        return KeyType.anc;
      case 'custom1':
      case '自定义1':
        return KeyType.custom1;
      case 'custom2':
      case '自定义2':
        return KeyType.custom2;
      default:
        return KeyType.playPause;
    }
  }

  @override
  String toString() {
    switch (this) {
      case KeyType.playPause:
        return 'playPause';
      case KeyType.previous:
        return 'previous';
      case KeyType.next:
        return 'next';
      case KeyType.volumeUp:
        return 'volumeUp';
      case KeyType.volumeDown:
        return 'volumeDown';
      case KeyType.mode:
        return 'mode';
      case KeyType.power:
        return 'power';
      case KeyType.anc:
        return 'anc';
      case KeyType.custom1:
        return 'custom1';
      case KeyType.custom2:
        return 'custom2';
    }
  }
}

/// 按键功能枚举
enum KeyFunction {
  none,           // 无功能
  playPause,      // 播放/暂停
  previous,       // 上一曲
  next,           // 下一曲
  volumeUp,       // 音量+
  volumeDown,     // 音量-
  modeSwitch,     // 模式切换
  powerOff,       // 关机
  ancSwitch,      // ANC切换
  findDevice,     // 查找设备
  customCommand;  // 自定义命令

  static KeyFunction fromString(String function) {
    switch (function.toLowerCase()) {
      case 'none':
      case '无':
        return KeyFunction.none;
      case 'playpause':
      case '播放暂停':
        return KeyFunction.playPause;
      case 'previous':
      case '上一曲':
        return KeyFunction.previous;
      case 'next':
      case '下一曲':
        return KeyFunction.next;
      case 'volumeup':
      case '音量+':
        return KeyFunction.volumeUp;
      case 'volumedown':
      case '音量-':
        return KeyFunction.volumeDown;
      case 'modeswitch':
      case '模式切换':
        return KeyFunction.modeSwitch;
      case 'poweroff':
      case '关机':
        return KeyFunction.powerOff;
      case 'ancswitch':
      case 'anc切换':
        return KeyFunction.ancSwitch;
      case 'finddevice':
      case '查找设备':
        return KeyFunction.findDevice;
      case 'customcommand':
      case '自定义命令':
        return KeyFunction.customCommand;
      default:
        return KeyFunction.none;
    }
  }

  @override
  String toString() {
    switch (this) {
      case KeyFunction.none:
        return 'none';
      case KeyFunction.playPause:
        return 'playPause';
      case KeyFunction.previous:
        return 'previous';
      case KeyFunction.next:
        return 'next';
      case KeyFunction.volumeUp:
        return 'volumeUp';
      case KeyFunction.volumeDown:
        return 'volumeDown';
      case KeyFunction.modeSwitch:
        return 'modeSwitch';
      case KeyFunction.powerOff:
        return 'powerOff';
      case KeyFunction.ancSwitch:
        return 'ancSwitch';
      case KeyFunction.findDevice:
        return 'findDevice';
      case KeyFunction.customCommand:
        return 'customCommand';
    }
  }
}

/// 自定义命令参数
class CustomCommand {
  /// 命令ID
  final String commandId;

  /// 命令数据（十六进制字符串）
  final String data;

  /// 超时时间（毫秒）
  final int timeout;

  CustomCommand({
    required this.commandId,
    required this.data,
    this.timeout = 5000,
  });

  factory CustomCommand.fromJson(Map<String, dynamic> json) {
    return CustomCommand(
      commandId: json['commandId'] as String,
      data: json['data'] as String,
      timeout: json['timeout'] as int? ?? 5000,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commandId': commandId,
      'data': data,
      'timeout': timeout,
    };
  }
}

/// 查找设备参数
class FindDeviceParams {
  /// 查找模式
  final FindDeviceMode mode;

  /// 持续时间（秒）
  final int duration;

  /// 音量（0-100）
  final int volume;

  FindDeviceParams({
    required this.mode,
    this.duration = 30,
    this.volume = 80,
  });

  factory FindDeviceParams.fromJson(Map<String, dynamic> json) {
    return FindDeviceParams(
      mode: FindDeviceMode.fromString(json['mode'] as String),
      duration: json['duration'] as int? ?? 30,
      volume: json['volume'] as int? ?? 80,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mode': mode.toString(),
      'duration': duration,
      'volume': volume,
    };
  }
}

/// 查找模式枚举
enum FindDeviceMode {
  findDevice,     // 查找设备
  findPhone;      // 查找手机

  static FindDeviceMode fromString(String mode) {
    switch (mode.toLowerCase()) {
      case 'finddevice':
      case '查找设备':
        return FindDeviceMode.findDevice;
      case 'findphone':
      case '查找手机':
        return FindDeviceMode.findPhone;
      default:
        return FindDeviceMode.findDevice;
    }
  }

  @override
  String toString() {
    switch (this) {
      case FindDeviceMode.findDevice:
        return 'findDevice';
      case FindDeviceMode.findPhone:
        return 'findPhone';
    }
  }
}

/// 文件信息模型
class JlFileInfo {
  /// 文件路径
  final String path;

  /// 文件名
  final String name;

  /// 文件类型
  final FileType type;

  /// 文件大小（字节）
  final int size;

  /// 创建时间
  final DateTime? createdAt;

  JlFileInfo({
    required this.path,
    required this.name,
    required this.type,
    required this.size,
    this.createdAt,
  });

  factory JlFileInfo.fromJson(Map<String, dynamic> json) {
    return JlFileInfo(
      path: json['path'] as String,
      name: json['name'] as String,
      type: FileType.fromString(json['type'] as String),
      size: json['size'] as int,
      createdAt: json['createdAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'name': name,
      'type': type.toString(),
      'size': size,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  /// 获取格式化的文件大小
  String get formattedSize {
    if (size < 1024) {
      return '$size B';
    } else if (size < 1024 * 1024) {
      return '${(size / 1024).toStringAsFixed(1)} KB';
    } else if (size < 1024 * 1024 * 1024) {
      return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(size / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }
}

/// 文件类型枚举
enum FileType {
  directory,      // 目录
  audio,          // 音频文件
  video,          // 视频文件
  image,          // 图片文件
  document,       // 文档文件
  unknown;        // 未知类型

  static FileType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'directory':
      case '目录':
        return FileType.directory;
      case 'audio':
      case '音频':
        return FileType.audio;
      case 'video':
      case '视频':
        return FileType.video;
      case 'image':
      case '图片':
        return FileType.image;
      case 'document':
      case '文档':
        return FileType.document;
      default:
        return FileType.unknown;
    }
  }

  @override
  String toString() {
    switch (this) {
      case FileType.directory:
        return 'directory';
      case FileType.audio:
        return 'audio';
      case FileType.video:
        return 'video';
      case FileType.image:
        return 'image';
      case FileType.document:
        return 'document';
      case FileType.unknown:
        return 'unknown';
    }
  }
}