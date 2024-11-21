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
              MaterialPageRoute(builder: (_) => const BehaviorScreen()),
            ),
          ),
          FeatureButton(
            label: 'Proximity Sensor',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BehaviorScreen()),
            ),
          ),
          FeatureButton(
            label: 'Temperature Sensor',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BehaviorScreen()),
            ),
          ),
          FeatureButton(
            label: 'Humidity Sensor',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BehaviorScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
