import 'package:device_features/screen/sensor/biometrics/finger_print_screen.dart';
import 'package:flutter/material.dart';

import '../../../widget/feature_button.dart';

class BiometricsScreen extends StatelessWidget {
  const BiometricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          FeatureButton(
            label: 'Fingerprint Sensor',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FingerPrintScreen()),
            ),
          ),
          FeatureButton(
            label: 'Face Recognition Sensor',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BiometricsScreen()),
            ),
          ),
          FeatureButton(
            label: 'Heart Rate Sensor',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BiometricsScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
