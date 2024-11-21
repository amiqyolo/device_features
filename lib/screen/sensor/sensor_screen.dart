import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_features/screen/sensor/behavior/behavior_screen.dart';
import 'package:device_features/screen/sensor/biometrics/biometrics_screen.dart';
import 'package:device_features/screen/sensor/physics/physics_screen.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../widget/feature_button.dart';

class SensorScreen extends StatelessWidget {
  const SensorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          FeatureButton(
            label: 'Sensor Fisik',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PhysicsScreen()),
            ),
          ),
          FeatureButton(
            label: 'Sensor Lingkungan',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BehaviorScreen()),
            ),
          ),
          FeatureButton(
            label: 'Sensor Biometrik',
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
