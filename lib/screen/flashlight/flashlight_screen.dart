import 'package:device_features/screen/flashlight/flashlight_channel_screen.dart';
import 'package:device_features/screen/flashlight/flashlight_torch_controller.dart';
import 'package:flutter/material.dart';

import '../../widget/feature_button.dart';

class FlashlightScreen extends StatelessWidget {
  const FlashlightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          FeatureButton(
            label: 'Flash Light Torch Controller',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const FlashlightTorchController()),
            ),
          ),
          FeatureButton(
            label: 'Flash Light Channel',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const FlashlightChannelScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
