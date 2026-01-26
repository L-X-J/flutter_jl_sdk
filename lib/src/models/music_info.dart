/// 音乐信息模型
class JlMusicInfo {
  /// 歌曲标题
  final String? title;

  /// 艺术家
  final String? artist;

  /// 专辑
  final String? album;

  /// 歌曲时长（秒）
  final int? duration;

  /// 当前播放进度（秒）
  final int? position;

  /// 播放状态
  final PlayStatus playStatus;

  /// 音量（0-100）
  final int? volume;

  /// 是否静音
  final bool isMuted;

  /// 当前播放模式
  final PlayMode playMode;

  /// 歌曲ID（用于设备端识别）
  final String? songId;

  /// 创建时间
  final DateTime? createdAt;

  JlMusicInfo({
    this.title,
    this.artist,
    this.album,
    this.duration,
    this.position,
    required this.playStatus,
    this.volume,
    this.isMuted = false,
    required this.playMode,
    this.songId,
    this.createdAt,
  });

  /// 从JSON创建音乐信息
  factory JlMusicInfo.fromJson(Map<String, dynamic> json) {
    return JlMusicInfo(
      title: json['title'] as String?,
      artist: json['artist'] as String?,
      album: json['album'] as String?,
      duration: json['duration'] as int?,
      position: json['position'] as int?,
      playStatus: PlayStatus.fromString(json['playStatus'] as String),
      volume: json['volume'] as int?,
      isMuted: json['isMuted'] as bool? ?? false,
      playMode: PlayMode.fromString(json['playMode'] as String),
      songId: json['songId'] as String?,
      createdAt: json['createdAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int)
          : null,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'album': album,
      'duration': duration,
      'position': position,
      'playStatus': playStatus.toString(),
      'volume': volume,
      'isMuted': isMuted,
      'playMode': playMode.toString(),
      'songId': songId,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  /// 复制音乐信息并更新指定字段
  JlMusicInfo copyWith({
    String? title,
    String? artist,
    String? album,
    int? duration,
    int? position,
    PlayStatus? playStatus,
    int? volume,
    bool? isMuted,
    PlayMode? playMode,
    String? songId,
    DateTime? createdAt,
  }) {
    return JlMusicInfo(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      playStatus: playStatus ?? this.playStatus,
      volume: volume ?? this.volume,
      isMuted: isMuted ?? this.isMuted,
      playMode: playMode ?? this.playMode,
      songId: songId ?? this.songId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// 获取进度百分比
  double get progressPercentage {
    if (duration == null || position == null || duration == 0) {
      return 0.0;
    }
    return (position! / duration!).clamp(0.0, 1.0);
  }

  /// 格式化时间显示
  String get formattedPosition {
    if (position == null) return '--:--';
    final minutes = position! ~/ 60;
    final seconds = position! % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get formattedDuration {
    if (duration == null) return '--:--';
    final minutes = duration! ~/ 60;
    final seconds = duration! % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  String toString() {
    return 'JlMusicInfo(title: $title, artist: $artist, playStatus: $playStatus)';
  }
}

/// 播放状态枚举
enum PlayStatus {
  stopped,    // 停止
  playing,    // 播放
  paused,     // 暂停
  buffering;  // 缓冲中

  static PlayStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'stopped':
      case '停止':
        return PlayStatus.stopped;
      case 'playing':
      case '播放':
        return PlayStatus.playing;
      case 'paused':
      case '暂停':
        return PlayStatus.paused;
      case 'buffering':
      case '缓冲中':
        return PlayStatus.buffering;
      default:
        return PlayStatus.stopped;
    }
  }

  @override
  String toString() {
    switch (this) {
      case PlayStatus.stopped:
        return 'stopped';
      case PlayStatus.playing:
        return 'playing';
      case PlayStatus.paused:
        return 'paused';
      case PlayStatus.buffering:
        return 'buffering';
    }
  }
}

/// 播放模式枚举
enum PlayMode {
  repeatAll,      // 列表循环
  repeatOne,      // 单曲循环
  shuffle,        // 随机播放
  sequential;     // 顺序播放

  static PlayMode fromString(String mode) {
    switch (mode.toLowerCase()) {
      case 'repeatall':
      case '列表循环':
        return PlayMode.repeatAll;
      case 'repeatone':
      case '单曲循环':
        return PlayMode.repeatOne;
      case 'shuffle':
      case '随机播放':
        return PlayMode.shuffle;
      case 'sequential':
      case '顺序播放':
        return PlayMode.sequential;
      default:
        return PlayMode.repeatAll;
    }
  }

  @override
  String toString() {
    switch (this) {
      case PlayMode.repeatAll:
        return 'repeatAll';
      case PlayMode.repeatOne:
        return 'repeatOne';
      case PlayMode.shuffle:
        return 'shuffle';
      case PlayMode.sequential:
        return 'sequential';
    }
  }
}

/// 音量控制参数
class VolumeControl {
  /// 音量值 (0-100)
  final int volume;

  /// 是否静音
  final bool isMuted;

  VolumeControl({
    required this.volume,
    this.isMuted = false,
  });

  factory VolumeControl.fromJson(Map<String, dynamic> json) {
    return VolumeControl(
      volume: json['volume'] as int,
      isMuted: json['isMuted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'volume': volume,
      'isMuted': isMuted,
    };
  }
}

/// EQ调节参数
class EqControl {
  /// 低音增益 (-12 ~ +12 dB)
  final double bass;

  /// 中音增益 (-12 ~ +12 dB)
  final double mid;

  /// 高音增益 (-12 ~ +12 dB)
  final double treble;

  /// 预设模式
  final EqPreset preset;

  EqControl({
    required this.bass,
    required this.mid,
    required this.treble,
    required this.preset,
  });

  factory EqControl.fromJson(Map<String, dynamic> json) {
    return EqControl(
      bass: (json['bass'] as num).toDouble(),
      mid: (json['mid'] as num).toDouble(),
      treble: (json['treble'] as num).toDouble(),
      preset: EqPreset.fromString(json['preset'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bass': bass,
      'mid': mid,
      'treble': treble,
      'preset': preset.toString(),
    };
  }
}

/// EQ预设模式
enum EqPreset {
  normal,      // 正常
  rock,        // 摇滚
  pop,         // 流行
  jazz,        // 爵士
  classical,   // 古典
  custom;      // 自定义

  static EqPreset fromString(String preset) {
    switch (preset.toLowerCase()) {
      case 'normal':
      case '正常':
        return EqPreset.normal;
      case 'rock':
      case '摇滚':
        return EqPreset.rock;
      case 'pop':
      case '流行':
        return EqPreset.pop;
      case 'jazz':
      case '爵士':
        return EqPreset.jazz;
      case 'classical':
      case '古典':
        return EqPreset.classical;
      case 'custom':
      case '自定义':
        return EqPreset.custom;
      default:
        return EqPreset.normal;
    }
  }

  @override
  String toString() {
    switch (this) {
      case EqPreset.normal:
        return 'normal';
      case EqPreset.rock:
        return 'rock';
      case EqPreset.pop:
        return 'pop';
      case EqPreset.jazz:
        return 'jazz';
      case EqPreset.classical:
        return 'classical';
      case EqPreset.custom:
        return 'custom';
    }
  }
}

/// 音效调节参数
class SoundEffectControl {
  /// 混响强度 (0-100)
  final int reverb;

  /// 低音增强 (0-100)
  final int bassBoost;

  /// 高音增强 (0-100)
  final int trebleBoost;

  SoundEffectControl({
    required this.reverb,
    required this.bassBoost,
    required this.trebleBoost,
  });

  factory SoundEffectControl.fromJson(Map<String, dynamic> json) {
    return SoundEffectControl(
      reverb: json['reverb'] as int,
      bassBoost: json['bassBoost'] as int,
      trebleBoost: json['trebleBoost'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reverb': reverb,
      'bassBoost': bassBoost,
      'trebleBoost': trebleBoost,
    };
  }
}