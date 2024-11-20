package com.aplimelta.device_features

import android.content.Context
import android.hardware.Camera
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private var legacyCamera: Camera? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "toggleFlashLight") {
                val status = call.argument<Boolean>("Status") ?: false
                toggleFlashlight(status, result)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun toggleFlashlight(status: Boolean, result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            useCamera2API(status, result)
        } else {
            useLegacyCameraAPI(status, result)
        }
    }

    @RequiresApi(Build.VERSION_CODES.M)
    private fun useCamera2API(status: Boolean, result: MethodChannel.Result) {
        val cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        val cameraId = cameraManager.cameraIdList.find { id ->
            val characteristics = cameraManager.getCameraCharacteristics(id)
            val hasFlash = characteristics.get(CameraCharacteristics.FLASH_INFO_AVAILABLE) ?: false
            hasFlash
        }

        if (cameraId != null) {
            try {
                cameraManager.setTorchMode(cameraId, status)
                Log.d("Flashlight", "Torch mode set to $status for Camera2 API")
                result.success("Flashlight toggled: $status")
            } catch (e: CameraAccessException) {
                Log.e("Flashlight", "Failed to access camera: ${e.message}")
                result.error("CAMERA_ACCESS_ERROR", "Failed to access camera: ${e.message}", null)
            } catch (e: Exception) {
                Log.e("Flashlight", "Unexpected error: ${e.message}")
                result.error("FLASHLIGHT_ERROR", "Failed to toggle flashlight: ${e.message}", null)
            }
        } else {
            Log.e("Flashlight", "No camera with flash found on this device")
            result.error("NO_FLASH", "No flashlight found on this device", null)
        }
    }

    private fun useLegacyCameraAPI(status: Boolean, result: MethodChannel.Result) {
        try {
            if (legacyCamera == null) {
                legacyCamera = Camera.open() // Buka kamera default
            }

            val params = legacyCamera?.parameters
            if (status) {
                params?.flashMode = Camera.Parameters.FLASH_MODE_TORCH
            } else {
                params?.flashMode = Camera.Parameters.FLASH_MODE_OFF
            }
            legacyCamera?.parameters = params

            if (!status) {
                legacyCamera?.release() // Lepaskan kamera jika dimatikan
                legacyCamera = null
            }

            Log.d("Flashlight", "Flashlight toggled to $status for Camera API 1")
            result.success("Flashlight toggled: $status")
        } catch (e: Exception) {
            Log.e("Flashlight", "Failed to toggle flashlight: ${e.message}")
            result.error("LEGACY_CAMERA_ERROR", "Failed to toggle flashlight: ${e.message}", null)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        // Pastikan kamera dilepaskan jika aplikasi ditutup
        legacyCamera?.release()
        legacyCamera = null
    }


    companion object {
        private const val CHANNEL = "com.aplimelta.flashlight/channel"
    }
}
