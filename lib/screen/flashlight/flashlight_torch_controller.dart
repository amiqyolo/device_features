import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class FlashlightTorchController extends StatefulWidget {
  const FlashlightTorchController({super.key});

  @override
  State<FlashlightTorchController> createState() =>
      _FlashlightTorchControllerState();
}

class _FlashlightTorchControllerState extends State<FlashlightTorchController> {
  bool _isFlashOn = false;
  bool _isFlashSupported = false;

  @override
  void initState() {
    super.initState();

    _checkFlashSupport();
  }

  Future<void> _checkFlashSupport() async {
    try {
      final isSupported = await TorchLight.isTorchAvailable();
      setState(() {
        _isFlashSupported = isSupported;
      });
    } catch (e) {
      setState(() {
        _isFlashSupported = false;
      });
    }
  }

  Future<void> _toggleFlash() async {
    if (!_isFlashSupported) return;

    try {
      if (_isFlashOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }

      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Torch error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _isFlashSupported
            ? IconButton(
                icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off),
                iconSize: 64.0,
                onPressed: _toggleFlash,
              )
            : const Text(
                "Flashlight not supported on this device",
                style: TextStyle(fontSize: 18),
              ),
      ),
    );
  }
}
