import 'package:flutter/material.dart';
import 'package:flutter_jl_sdk/flutter_jl_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化SDK
  final initialized = await FlutterJlSdk.initialize();
  if (!initialized) {
    print('SDK初始化失败');
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '杰理SDK示例',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<JlDeviceInfo> _devices = [];
  JlDeviceInfo? _connectedDevice;
  bool _isScanning = false;
  String _status = '就绪';

  @override
  void initState() {
    super.initState();
    _setupEventListeners();
  }

  void _setupEventListeners() {
    // 监听设备状态变化
    FlutterJlSdk.onDeviceStatusChanged.listen((status) {
      setState(() {
        _status = '设备状态: ${status.deviceId} - ${status.connectionStatus}';
      });
    });

    // 监听音乐信息变化
    FlutterJlSdk.onMusicInfoChanged.listen((musicInfo) {
      setState(() {
        _status = '音乐: ${musicInfo.title} - ${musicInfo.playStatus}';
      });
    });

    // 监听错误信息
    FlutterJlSdk.onError.listen((error) {
      setState(() {
        _status = '错误: ${error.code} - ${error.message}';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('错误: ${error.message}')),
      );
    });
  }

  Future<void> _scanDevices() async {
    setState(() {
      _isScanning = true;
      _status = '正在扫描设备...';
    });

    try {
      final devices = await FlutterJlSdk.scanDevices(
        timeout: 10000,
        deviceTypes: [DeviceType.headphone, DeviceType.speaker],
      );

      setState(() {
        _devices = devices;
        _isScanning = false;
        _status = '扫描完成，找到 ${devices.length} 个设备';
      });
    } catch (e) {
      setState(() {
        _isScanning = false;
        _status = '扫描失败: $e';
      });
    }
  }

  Future<void> _connectDevice(JlDeviceInfo device) async {
    try {
      final connected = await FlutterJlSdk.connectDevice(device.deviceId);
      if (connected) {
        setState(() {
          _connectedDevice = device;
          _status = '已连接: ${device.deviceName}';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('设备连接成功: ${device.deviceName}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('连接失败: $e')),
      );
    }
  }

  Future<void> _disconnectDevice() async {
    if (_connectedDevice == null) return;

    try {
      await FlutterJlSdk.disconnectDevice(_connectedDevice!.deviceId);
      setState(() {
        _connectedDevice = null;
        _status = '已断开连接';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('断开失败: $e')),
      );
    }
  }

  Future<void> _play() async {
    if (_connectedDevice == null) return;
    try {
      await FlutterJlSdk.play(_connectedDevice!.deviceId);
      setState(() {
        _status = '正在播放...';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('播放失败: $e')),
      );
    }
  }

  Future<void> _pause() async {
    if (_connectedDevice == null) return;
    try {
      await FlutterJlSdk.pause(_connectedDevice!.deviceId);
      setState(() {
        _status = '已暂停';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('暂停失败: $e')),
      );
    }
  }

  Future<void> _nextTrack() async {
    if (_connectedDevice == null) return;
    try {
      await FlutterJlSdk.nextTrack(_connectedDevice!.deviceId);
      setState(() {
        _status = '下一曲';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('下一曲失败: $e')),
      );
    }
  }

  Future<void> _previousTrack() async {
    if (_connectedDevice == null) return;
    try {
      await FlutterJlSdk.previousTrack(_connectedDevice!.deviceId);
      setState(() {
        _status = '上一曲';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('上一曲失败: $e')),
      );
    }
  }

  Future<void> _setVolume(int volume) async {
    if (_connectedDevice == null) return;
    try {
      await FlutterJlSdk.setVolume(_connectedDevice!.deviceId, volume);
      setState(() {
        _status = '音量设置为: $volume';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('设置音量失败: $e')),
      );
    }
  }

  Future<void> _setEqPreset(EqPreset preset) async {
    if (_connectedDevice == null) return;
    try {
      await FlutterJlSdk.setEqPreset(_connectedDevice!.deviceId, preset);
      setState(() {
        _status = 'EQ预设设置为: ${preset.toString().split('.').last}';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('设置EQ失败: $e')),
      );
    }
  }

  Future<void> _findDevice() async {
    if (_connectedDevice == null) return;
    try {
      final params = FindDeviceParams(
        mode: FindDeviceMode.blink,
        duration: 30,
      );
      await FlutterJlSdk.findDevice(_connectedDevice!.deviceId, params);
      setState(() {
        _status = '正在查找设备...';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('查找设备失败: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('杰理SDK示例'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 状态栏
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _status,
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // 设备连接状态
          if (_connectedDevice != null)
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.green[50],
              child: Row(
                children: [
                  Icon(Icons.bluetooth_connected, color: Colors.green),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _connectedDevice!.deviceName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                        Text(
                          'ID: ${_connectedDevice!.deviceId}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.disconnect, color: Colors.red),
                    onPressed: _disconnectDevice,
                  ),
                ],
              ),
            ),

          // 控制面板
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                // 扫描按钮
                Card(
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: Text('扫描设备'),
                    subtitle: Text(_isScanning ? '正在扫描...' : '点击开始扫描'),
                    trailing: _isScanning
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(Icons.arrow_forward),
                    onTap: _isScanning ? null : _scanDevices,
                  ),
                ),

                SizedBox(height: 16),

                // 设备列表
                if (_devices.isNotEmpty) ...[
                  Text(
                    '找到的设备 (${_devices.length})',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  ..._devices.map((device) => Card(
                    child: ListTile(
                      leading: Icon(
                        device.deviceType == DeviceType.headphone
                            ? Icons.headset
                            : Icons.speaker,
                        color: Colors.blue,
                      ),
                      title: Text(device.deviceName),
                      subtitle: Text(
                        'ID: ${device.deviceId}\n类型: ${device.deviceType.toString().split('.').last}',
                      ),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () => _connectDevice(device),
                    ),
                  )).toList(),
                ],

                SizedBox(height: 16),

                // 音乐控制
                if (_connectedDevice != null) ...[
                  Text(
                    '音乐控制',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Card(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.skip_previous),
                              onPressed: _previousTrack,
                              tooltip: '上一曲',
                            ),
                            IconButton(
                              icon: Icon(Icons.play_arrow),
                              onPressed: _play,
                              tooltip: '播放',
                            ),
                            IconButton(
                              icon: Icon(Icons.pause),
                              onPressed: _pause,
                              tooltip: '暂停',
                            ),
                            IconButton(
                              icon: Icon(Icons.skip_next),
                              onPressed: _nextTrack,
                              tooltip: '下一曲',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // 音量控制
                  Text(
                    '音量控制',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text('调整音量'),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.volume_down),
                              Expanded(
                                child: Slider(
                                  min: 0,
                                  max: 100,
                                  divisions: 100,
                                  label: '音量',
                                  onChanged: (value) {
                                    // 实时更新UI，但不频繁调用API
                                  },
                                  onChangeEnd: (value) {
                                    _setVolume(value.toInt());
                                  },
                                ),
                              ),
                              Icon(Icons.volume_up),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // EQ预设
                  Text(
                    'EQ预设',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Card(
                    child: Column(
                      children: EqPreset.values.map((preset) {
                        return ListTile(
                          title: Text(preset.toString().split('.').last),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () => _setEqPreset(preset),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 16),

                  // 其他功能
                  Text(
                    '其他功能',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.search, color: Colors.orange),
                          title: Text('查找设备'),
                          subtitle: Text('让设备发出声音或闪烁'),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: _findDevice,
                        ),
                        ListTile(
                          leading: Icon(Icons.alarm, color: Colors.purple),
                          title: Text('闹钟管理'),
                          subtitle: Text('添加、删除、更新闹钟'),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('闹钟管理功能开发中...')),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, color: Colors.teal),
                          title: Text('设备设置'),
                          subtitle: Text('EQ、音效、灯光等高级设置'),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('高级设置功能开发中...')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // 释放SDK资源
    FlutterJlSdk.dispose();
    super.dispose();
  }
}
