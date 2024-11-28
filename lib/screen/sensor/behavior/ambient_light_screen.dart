import 'dart:async';

import 'package:flutter/material.dart';

class AmbientLightScreen extends StatefulWidget {
  const AmbientLightScreen({super.key});

  @override
  State<AmbientLightScreen> createState() => _AmbientLightScreenState();
}

class _AmbientLightScreenState extends State<AmbientLightScreen> {
  String _luxString = 'Unknown';

  // Light not support
  // Light? _light;
  StreamSubscription? _subscription;
  bool _isLightSensorAvailable = false;

  void onData(int luxValue) async {
    print('Lux Value: $luxValue');
    setState(() {
      _isLightSensorAvailable = true;
      _luxString = '$luxValue';
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }

  void startListening() {
    // _light = Light();
    // try {
    //   _subscription = _light?.lightSensorStream.listen(onData);
    // } on LightException catch (e) {
    //   setState(() {
    //     _isLightSensorAvailable = false;
    //   });
    //   print(e);
    // }
  }

  @override
  void initState() {
    super.initState();

    startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: _isLightSensorAvailable
              ? Text(
                  'Ambient Light: $_luxString lux',
                  style: const TextStyle(fontSize: 20),
                )
              : const Text(
                  'Ambient Light Sensor not supported on this device.',
                  style: TextStyle(fontSize: 18),
                ),
        ),
      ),
    );
  }
}
