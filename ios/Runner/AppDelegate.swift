import Flutter
import UIKit
import AVFoundation

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.aplimelta.flashlight/main", binaryMessenger: controller.binaryMessenger)

            channel.setMethodCallHandler { (call, result) in
                if call.method == "torch_available" {
                    guard let args = call.arguments as? [String: Any], let status = args["status"] as? Bool else {
                        result(FlutterError(code: "INVALID_ARGUMENTS", message: "Arguments are missing", details: nil))
                        return
                    }

                    guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else {
                        result(FlutterError(code: "NO_TORCH", message: "Torch is not available on this device", details: nil))
                        return
                    }

                    do {
                        try device.lockForConfiguration()
                        device.torchMode = status ? .on : .off
                        device.unlockForConfiguration()
                        result(status)
                    } catch {
                        result(FlutterError(code: "TORCH_ERROR", message: "Failed to toggle torch", details: error.localizedDescription))
                    }
                } else if call.method == "checkSensors" {
                    result(self.checkSensors())
                } else {
                    result(FlutterMethodNotImplemented)
                }
            }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func checkSensors() -> [String: String] {
          return [
              "ambientLight": "Not Supported",
              "proximity": "Not Supported",
              "temperature": "Not Supported",
              "humidity": "Not Supported"
          ]
      }
}
