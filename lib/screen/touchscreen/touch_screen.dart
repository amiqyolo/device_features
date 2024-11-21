import 'package:device_features/screen/touchscreen/touch_event_screen.dart';
import 'package:device_features/screen/touchscreen/touch_tracker_screen.dart';
import 'package:flutter/material.dart';

import '../../widget/feature_button.dart';

class TouchScreen extends StatelessWidget {
  const TouchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          FeatureButton(
            label: 'Touch Event',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TouchEventScreen()),
            ),
          ),
          FeatureButton(
            label: 'Touch Tracker',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TouchTrackerScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
