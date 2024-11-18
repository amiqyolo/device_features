package com.aplimelta.device_features

import io.flutter.embedding.android.FlutterActivity
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.aplimelta.flashlight/channel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "toggleFlashLight") {
                val status = call.argument<Boolean>("Status") ?: false
                val cameraManager = getSystemService(CAMERA_SERVICE) as CameraManager
                try {
                    val cameraId = cameraManager.cameraIdList.first()
                    cameraManager.setTorchMode(cameraId, status)
                    result.success(status)
                } catch (e: CameraAccessException) {
                    result.error("CAMERA_ACCESS_ERROR", "Failed to access the camera", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
