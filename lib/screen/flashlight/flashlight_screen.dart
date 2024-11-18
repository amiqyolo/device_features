import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlashlightScreen extends StatefulWidget {
  const FlashlightScreen({super.key});

  @override
  State<FlashlightScreen> createState() => _FlashlightScreenState();
}

// USING platform channels to communicate between native dart with native android & ios.
class _FlashlightScreenState extends State<FlashlightScreen> {
  static const platform = MethodChannel('com.aplimelta.flashlight/channel');
  bool isFlashOn = false;

  Future<void> toggleFlashLight() async {
    try {
      final bool result = await platform.invokeMethod(
        'toggleFlashLight',
        {'status': !isFlashOn},
      );

      setState(() {
        isFlashOn = result;
      });
    } on PlatformException catch (e) {
      dev.log('Error: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              'Flashlight is ${isFlashOn ? "ON" : "OFF"}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleFlashLight,
              child: Text(isFlashOn ? 'Turn OFF' : 'Turn ON'),
            ),
          ],
        ),
      ),
    );
  }
}
