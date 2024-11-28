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

  Future<void> _testVibration() async {
    if (_isVibrationSupported) {
      await Vibration.vibrate(duration: 1000);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vibration Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Vibration Supported: ${_isVibrationSupported ? 'Yes' : 'No'}"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isVibrationSupported ? _testVibration : null,
              child: const Text("Test Vibration"),
            ),
          ],
        ),
      ),
    );
  }
}
