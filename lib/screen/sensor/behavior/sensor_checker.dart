import 'package:flutter/services.dart';

class SensorChecker {
  static const platform = MethodChannel("com.aplimelta.flashlight/main");

  Future<Map<String, bool>> checkSensors() async {
    try {
      final result =
          await platform.invokeMethod('checkSensors') as Map<dynamic, dynamic>;
      return result
              .map((key, value) => MapEntry(key.toString(), value == true));
    } catch (e) {
      print(e);
      return {
        "ambientLight": false,
        "proximity": false,
        "temperature": false,
        "humidity": false,
      };
    }
  }
}
