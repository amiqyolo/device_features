import 'dart:developer' as dev;
import 'package:device_features/app_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlashlightChannelScreen extends StatefulWidget {
  const FlashlightChannelScreen({super.key});

  @override
  State<FlashlightChannelScreen> createState() => _FlashlightChannelScreenState();
}

// USING platform channels to communicate between native dart with native android & ios.
class _FlashlightChannelScreenState extends State<FlashlightChannelScreen> {
  static const MethodChannel _channel = MethodChannel(AppConsts.flashChannelName);
  bool isFlashOn = false;
  bool _isTorchAvailable = false;
  String _statusMessage = "Checking torch availability...";

  Future<void> _torchAvailable() async {
    try {
      final bool result = await _channel.invokeMethod(AppConsts.nativeEventIsTorchAvailable) as bool;
      setState(() {
        _isTorchAvailable = result;
        _statusMessage = result
            ? "Torch is available. Use the button below."
            : "Torch is not available on this device.";
      });
    } on PlatformException catch (e) {
      setState(() {
        _statusMessage = e.message.toString();
      });
    }
  }

  Future<void> _toggleFlashLight() async {
    if (!_isTorchAvailable) return;

    try {
      if (isFlashOn) {
        await _channel.invokeMethod(AppConsts.nativeEventEnableTorch);
      } else {
        await _channel.invokeMethod(AppConsts.nativeEventDisableTorch);
      }

      setState(() {
        isFlashOn = !isFlashOn;
        _statusMessage = isFlashOn
            ? "Torch is ON. Press the button to turn it OFF."
            : "Torch is OFF. Press the button to turn it ON.";
      });
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error toggling torch: ${e.message}")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _torchAvailable();
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
              onPressed: _isTorchAvailable ? _toggleFlashLight : null,
              child: Text(isFlashOn ? 'Turn OFF' : 'Turn ON'),
            ),
          ],
        ),
      ),
    );
  }
}
