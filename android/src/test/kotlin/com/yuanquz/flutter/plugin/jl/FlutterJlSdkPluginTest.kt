package com.yuanquz.flutter.plugin.jl

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.TestCoroutineDispatcher
import kotlinx.coroutines.test.resetMain
import kotlinx.coroutines.test.runBlockingTest
import kotlinx.coroutines.test.setMain
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.Mockito.*
import org.mockito.junit.MockitoJUnitRunner
import kotlin.test.assertEquals
import kotlin.test.assertNotNull

/**
 * FlutterJlSdkPlugin单元测试
 */
@RunWith(MockitoJUnitRunner::class)
class FlutterJlSdkPluginTest {

    @Mock
    private lateinit var mockFlutterPluginBinding: FlutterPlugin.FlutterPluginBinding

    @Mock
    private lateinit var mockMethodChannel: MethodChannel

    @Mock
    private lateinit var mockDeviceStatusEventChannel: EventChannel

    @Mock
    private lateinit var mockMusicInfoEventChannel: EventChannel

    @Mock
    private lateinit var mockErrorEventChannel: EventChannel

    @Mock
    private lateinit var mockContext: Context

    @Mock
    private lateinit var mockResult: MethodChannel.Result

    private lateinit var plugin: FlutterJlSdkPlugin

    private val testDispatcher = TestCoroutineDispatcher()

    @OptIn(ExperimentalCoroutinesApi::class)
    @Before
    fun setup() {
        Dispatchers.setMain(testDispatcher)
        plugin = FlutterJlSdkPlugin()
    }

    @OptIn(ExperimentalCoroutinesApi::class)
    @After
    fun tearDown() {
        Dispatchers.resetMain()
        testDispatcher.cleanupTestCoroutines()
    }

    @Test
    fun `plugin registers correctly`() {
        // Verify plugin can be instantiated
        assertNotNull(plugin)
    }

    @Test
    fun `initialize returns true`() = runBlockingTest {
        val call = MethodCall("initialize", null)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `scanDevices returns empty list`() = runBlockingTest {
        val arguments = mapOf(
            "timeout" to 10000,
            "deviceTypes" to emptyList<String>()
        )
        val call = MethodCall("scanDevices", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(emptyList<Any>())
    }

    @Test
    fun `connectDevice returns true`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("connectDevice", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `connectDevice fails with null deviceId`() = runBlockingTest {
        val call = MethodCall("connectDevice", emptyMap<String, Any>())
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).error("INVALID_DEVICE_ID", "Device ID is required", null)
    }

    @Test
    fun `disconnectDevice returns true`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("disconnectDevice", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `getConnectionStatus returns disconnected`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("getConnectionStatus", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success("disconnected")
    }

    @Test
    fun `getConnectedDevices returns empty list`() = runBlockingTest {
        val call = MethodCall("getConnectedDevices", null)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(emptyList<Any>())
    }

    @Test
    fun `play returns true`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("play", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `pause returns true`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("pause", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `stop returns true`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("stop", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `previousTrack returns true`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("previousTrack", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `nextTrack returns true`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("nextTrack", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `seek returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "position" to 60
        )
        val call = MethodCall("seek", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `setPlayMode returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "mode" to "repeatAll"
        )
        val call = MethodCall("setPlayMode", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `getCurrentMusicInfo returns empty map`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("getCurrentMusicInfo", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(any())
    }

    @Test
    fun `setVolume returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "volume" to 75
        )
        val call = MethodCall("setVolume", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `getVolume returns 50`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("getVolume", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(50)
    }

    @Test
    fun `setMuted returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "muted" to true
        )
        val call = MethodCall("setMuted", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `isMuted returns false`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("isMuted", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(false)
    }

    @Test
    fun `setEq returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "eqControl" to mapOf(
                "preset" to "rock",
                "bands" to listOf(0, 2, -1, 1, 0)
            )
        )
        val call = MethodCall("setEq", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `getEq returns empty map`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("getEq", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(any())
    }

    @Test
    fun `setEqPreset returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "preset" to "pop"
        )
        val call = MethodCall("setEqPreset", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `setSoundEffect returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "soundEffect" to mapOf(
                "reverb" to 50,
                "bassBoost" to 30,
                "trebleBoost" to 20
            )
        )
        val call = MethodCall("setSoundEffect", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `getSoundEffect returns empty map`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("getSoundEffect", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(any())
    }

    @Test
    fun `addAlarm returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "alarm" to mapOf(
                "alarmId" to "alarm-1",
                "hour" to 7,
                "minute" to 30,
                "repeatDays" to listOf(1, 2, 3, 4, 5),
                "enabled" to true
            )
        )
        val call = MethodCall("addAlarm", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `deleteAlarm returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "alarmId" to "alarm-1"
        )
        val call = MethodCall("deleteAlarm", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `updateAlarm returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "alarm" to mapOf(
                "alarmId" to "alarm-1",
                "hour" to 8,
                "minute" to 0,
                "repeatDays" to listOf(1, 2, 3, 4, 5, 6, 7),
                "enabled" to true
            )
        )
        val call = MethodCall("updateAlarm", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `getAlarms returns empty list`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("getAlarms", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(emptyList<Any>())
    }

    @Test
    fun `setFm returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "fmControl" to mapOf(
                "mode" to "receiver",
                "frequency" to 101.5
            )
        )
        val call = MethodCall("setFm", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `getFm returns empty map`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("getFm", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(any())
    }

    @Test
    fun `setLight returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "lightControl" to mapOf(
                "mode" to "solid",
                "color" to "red",
                "brightness" to 80
            )
        )
        val call = MethodCall("setLight", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `getLight returns empty map`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("getLight", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(any())
    }

    @Test
    fun `setAnc returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "ancControl" to mapOf(
                "mode" to "activeNoiseCancel",
                "level" to 80
            )
        )
        val call = MethodCall("setAnc", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `getAnc returns empty map`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("getAnc", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(any())
    }

    @Test
    fun `setKeySettings returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "keySettings" to mapOf(
                "doubleClickAction" to "playPause",
                "longPressAction" to "findDevice"
            )
        )
        val call = MethodCall("setKeySettings", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `getKeySettings returns empty map`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("getKeySettings", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(any())
    }

    @Test
    fun `findDevice returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "findDevice" to mapOf(
                "mode" to "blink",
                "duration" to 30
            )
        )
        val call = MethodCall("findDevice", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `sendCustomCommand returns empty string`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "command" to mapOf(
                "commandId" to "custom-1",
                "data" to mapOf("key" to "value")
            )
        )
        val call = MethodCall("sendCustomCommand", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success("")
    }

    @Test
    fun `getFiles returns empty list`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "path" to "/music"
        )
        val call = MethodCall("getFiles", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(emptyList<Any>())
    }

    @Test
    fun `startOta returns true`() = runBlockingTest {
        val arguments = mapOf(
            "deviceId" to "test-device-1",
            "firmwarePath" to "/firmware.bin"
        )
        val call = MethodCall("startOta", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `getOtaProgress returns 0_0`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("getOtaProgress", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(0.0)
    }

    @Test
    fun `cancelOta returns true`() = runBlockingTest {
        val arguments = mapOf("deviceId" to "test-device-1")
        val call = MethodCall("cancelOta", arguments)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(true)
    }

    @Test
    fun `dispose returns null`() = runBlockingTest {
        val call = MethodCall("dispose", null)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).success(null)
    }

    @Test
    fun `unknown method returns notImplemented`() {
        val call = MethodCall("unknownMethod", null)
        plugin.onMethodCall(call, mockResult)
        verify(mockResult).notImplemented()
    }
}
