import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class VibrationScreen extends StatefulWidget {
  const VibrationScreen({super.key});

  @override
  State<VibrationScreen> createState() => _VibrationScreenState();
}

class _VibrationScreenState extends State<VibrationScreen> {
  bool _isVibrationSupported = false;

  @override
  void initState() {
    super.initState();
    _checkVibrationSupport();
  }


  Future<void> _checkVibrationSupport() async {
    final isSupported = await Vibration.hasVibrator() ?? false;
    setState(() {
      _isVibrationSupported = isSupported;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vibration Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Vibration Supported: $_isVibrationSupported"),
            ElevatedButton(
              onPressed: _isVibrationSupported
                  ? () => Vibration.vibrate(duration: 500)
                  : null,
              child: const Text("Test Vibration"),
            ),
          ],
        ),
      ),
    );
  }
}
