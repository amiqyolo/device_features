import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlashlightChannelScreen extends StatefulWidget {
  const FlashlightChannelScreen({super.key});

  @override
  State<FlashlightChannelScreen> createState() => _FlashlightChannelScreenState();
}

// USING platform channels to communicate between native dart with native android & ios.
class _FlashlightChannelScreenState extends State<FlashlightChannelScreen> {
  static const platform = MethodChannel('com.aplimelta.flashlight/channel');
  bool isFlashOn = false;
  String _statusMessage = "Press the button to toggle flashlight";

  Future<void> _toggleFlashLight() async {
    try {
      final bool newStatus = !isFlashOn;
      final dynamic result = await platform.invokeMethod(
        'toggleFlashLight',
        {'status': newStatus},
      );

      setState(() {
        isFlashOn = newStatus;
        _statusMessage = result;
      });
    } on PlatformException catch (e) {
      dev.log('Error Flash Light: ${e.message}');
      setState(() {
        _statusMessage = "Error: ${e.toString()}";
      });
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
              _statusMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleFlashLight,
              child: Text(isFlashOn ? 'Turn OFF' : 'Turn ON'),
            ),
          ],
        ),
      ),
    );
  }
}
