import 'package:device_features/screen/sensor/behavior/ambient_light_screen.dart';
import 'package:device_features/screen/sensor/behavior/humidity_screen.dart';
import 'package:device_features/screen/sensor/behavior/proximity_screen.dart';
import 'package:device_features/screen/sensor/behavior/temperature_screen.dart';
import 'package:flutter/material.dart';

import '../../../widget/feature_button.dart';

class BehaviorScreen extends StatelessWidget {
  const BehaviorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          FeatureButton(
            label: 'Ambient Light Sensor',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AmbientLightScreen()),
            ),
          ),
          FeatureButton(
            label: 'Proximity Sensor',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProximityScreen()),
            ),
          ),
          FeatureButton(
            label: 'Temperature Sensor',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TemperatureScreen()),
            ),
          ),
          FeatureButton(
            label: 'Humidity Sensor',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HumidityScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
