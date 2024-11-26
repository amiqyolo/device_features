import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../widget/feature_button.dart';

class AmbientLightScreen extends StatefulWidget {
  const AmbientLightScreen({super.key});

  @override
  State<AmbientLightScreen> createState() => _AmbientLightScreenState();
}

class _AmbientLightScreenState extends State<AmbientLightScreen> {
  double? _ambientLightValue;
  UserAccelerometerEvent? _userAccelerometerEvent;

  @override
  void initState() {
    super.initState();

    userAccelerometerEventStream().listen((event) {
      setState(() {
        _userAccelerometerEvent = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('User Accelerometer (sensors_plus):', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_userAccelerometerEvent != null
                ? 'X: ${_userAccelerometerEvent!.x}, Y: ${_userAccelerometerEvent!.y}, Z: ${_userAccelerometerEvent!.z}'
                : 'Fetching data...'),
          ],
        ),
      ),
    );
  }
}
