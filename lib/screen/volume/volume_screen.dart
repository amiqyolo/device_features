import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';

class VolumeScreen extends StatefulWidget {
  const VolumeScreen({super.key});

  @override
  State<VolumeScreen> createState() => _VolumeScreenState();
}

class _VolumeScreenState extends State<VolumeScreen> {
  double _volume = 0.5;

  @override
  void initState() {
    super.initState();
    VolumeController().listener((volume) {
      setState(() {
        _volume = volume;
      });
    });
  }

  @override
  void dispose() {
    VolumeController().removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Volume Control')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Adjust Volume"),
            Slider(
              value: _volume,
              onChanged: (value) {
                setState(() {
                  _volume = value;
                  VolumeController().setVolume(value);
                });
              },
              min: 0,
              max: 1,
              divisions: 10,
              label: "${(_volume * 100).round()}%",
            ),
          ],
        ),
      ),
    );;
  }
}
