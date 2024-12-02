package com.aplimelta.device_features

import android.content.pm.PackageManager
import android.hardware.Sensor
import android.hardware.SensorManager
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager
import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

@RequiresApi(Build.VERSION_CODES.M)
class MainActivity : FlutterFragmentActivity() {

    private lateinit var cameraManager: CameraManager
    private var cameraId: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            val status = call.argument<Boolean>("Status") ?: false
            Log.i(TAG, "SERIAL: " + Build.SERIAL);
            Log.i(TAG, "MODEL: " + Build.MODEL);
            Log.i(TAG, "ID: " + Build.ID);
            Log.i(TAG, "Manufacture: " + Build.MANUFACTURER);
            Log.i(TAG, "brand: " + Build.BRAND);
            Log.i(TAG, "type: " + Build.TYPE);
            Log.i(TAG, "user: " + Build.USER);
            Log.i(TAG, "BASE: " + Build.VERSION_CODES.BASE);
            Log.i(TAG, "INCREMENTAL " + Build.VERSION.INCREMENTAL);
            Log.i(TAG, "SDK  " + Build.VERSION.SDK);
            Log.i(TAG, "BOARD: " + Build.BOARD);
            Log.i(TAG, "BRAND " + Build.BRAND);
            Log.i(TAG, "HOST " + Build.HOST);
            Log.i(TAG, "FINGERPRINT: " + Build.FINGERPRINT);
            Log.i(TAG, "Version Code: " + Build.VERSION.RELEASE);
            when (call.method) {
                NATIVE_EVENT_TORCH_AVAILABLE -> isTorchAvailable(result)
                NATIVE_EVENT_ENABLE_TORCH -> enableTorch(result)
                NATIVE_EVENT_DISABLE_TORCH -> disableTorch(result)
                "checkSensors" -> sensorChecker(result)
                else -> result.notImplemented()
            }
        }
    }

    private fun sensorChecker(result: MethodChannel.Result) {
        val sensorManager = getSystemService(SENSOR_SERVICE) as SensorManager
        val sensors = sensorManager.getSensorList(Sensor.TYPE_ALL)
        val sensorMap = mutableMapOf<String, Boolean>()

        sensorMap["ambientLight"] = sensors.any { it.type == Sensor.TYPE_LIGHT }
        sensorMap["proximity"] = sensors.any { it.type == Sensor.TYPE_PROXIMITY }
        sensorMap["temperature"] = sensors.any { it.type == Sensor.TYPE_AMBIENT_TEMPERATURE }
        sensorMap["humidity"] = sensors.any { it.type == Sensor.TYPE_RELATIVE_HUMIDITY }
        sensorMap["humidity"] = sensors.any { it.type == Sensor.TYPE_PRESSURE }

        Log.d(TAG, "sensorChecker ambientLight: ${sensorMap.values}")
        Log.d(TAG, "sensorChecker proximity: ${sensorMap.values}")
        Log.d(TAG, "sensorChecker temperature: ${sensorMap.values}")
        Log.d(TAG, "sensorChecker humidity: ${sensorMap.values}")
        
        result.success(sensorMap)
    }

    private fun disableTorch(result: MethodChannel.Result) {
        if (cameraId != null) {
            try {
                cameraManager.setTorchMode(cameraId!!, false)
                result.success("Flashlight toggled: false")
            } catch (e: CameraAccessException) {
                result.error(
                    ERROR_DISABLE_TORCH_EXISTENT_USER,
                    "There is an existent camera user, cannot disable torch: $e", null
                )
            } catch (e: Exception) {
                result.error(
                    ERROR_DISABLE_TORCH,
                    "Could not disable torch", null
                )
            }
        } else {
            result.error(
                ERROR_DISABLE_TORCH_NOT_AVAILABLE,
                "Torch is not available", null
            )
        }
    }

    private fun enableTorch(result: MethodChannel.Result) {
        if (cameraId != null) {
            try {
                cameraManager.setTorchMode(cameraId!!, true)
                result.success("Flashlight toggled: true")
            } catch (e: CameraAccessException) {
                result.error(
                    ERROR_ENABLE_TORCH_EXISTENT_USER,
                    "There is an existent camera user, cannot enable torch: $e", null
                )
            } catch (e: Exception) {
                result.error(
                    ERROR_ENABLE_TORCH,
                    "Could not enable torch: $e", null
                )
            }
        } else {
            result.error(
                ERROR_ENABLE_TORCH_NOT_AVAILABLE,
                "Torch is not available", null
            )
        }
    }

    private fun isTorchAvailable(result: MethodChannel.Result) {
        result.success(applicationContext.packageManager.hasSystemFeature(PackageManager.FEATURE_CAMERA_FLASH))
    }

//    private fun toggleFlashlight(status: Boolean, result: MethodChannel.Result) {
//        val cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
//
//        try {
//            cameraId = cameraManager.cameraIdList[0]
//        } catch (e: Exception) {
//            Log.d(TAG, "Could not fetch camera id, the plugin won't work.")
//        }
//
//        if (cameraId != null) {
//            try {
//                cameraManager.setTorchMode(cameraId!!, status)
//                Log.d("Flashlight", "Torch mode set to $status for Camera2 API")
//                result.success("Flashlight toggled: $status")
//            } catch (e: CameraAccessException) {
//                Log.e("Flashlight", "Failed to access camera: ${e.message}")
//                result.error("CAMERA_ACCESS_ERROR", "Failed to access camera: ${e.message}", null)
//            } catch (e: Exception) {
//                Log.e("Flashlight", "Unexpected error: ${e.message}")
//                result.error("FLASHLIGHT_ERROR", "Failed to toggle flashlight: ${e.message}", null)
//            }
//        } else {
//            Log.e("Flashlight", "No camera with flash found on this device")
//            result.error("NO_FLASH", "No flashlight found on this device", null)
//        }
//    }

    companion object {
        private val TAG = MainActivity::class.java.simpleName

        private const val CHANNEL = "com.aplimelta.flashlight/main"

        private const val NATIVE_EVENT_TORCH_AVAILABLE = "torch_available"

        private const val NATIVE_EVENT_ENABLE_TORCH = "enable_torch"
        private const val ERROR_ENABLE_TORCH_EXISTENT_USER = "enable_torch_error_existent_user"
        private const val ERROR_ENABLE_TORCH = "enable_torch_error"
        private const val ERROR_ENABLE_TORCH_NOT_AVAILABLE = "enable_torch_not_available"

        private const val NATIVE_EVENT_DISABLE_TORCH = "disable_torch"
        private const val ERROR_DISABLE_TORCH_EXISTENT_USER = "disable_torch_error_existent_user"
        private const val ERROR_DISABLE_TORCH = "disable_torch_error"
        private const val ERROR_DISABLE_TORCH_NOT_AVAILABLE = "disable_torch_not_available"
    }
}
