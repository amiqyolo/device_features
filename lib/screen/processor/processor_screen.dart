import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class ProcessorScreen extends StatefulWidget {
  const ProcessorScreen({super.key});

  @override
  State<ProcessorScreen> createState() => _ProcessorScreenState();
}

class _ProcessorScreenState extends State<ProcessorScreen> {
  String processorInfo = "Loading...";

  Future<void> fetchProcessorInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? info;

    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      info = androidDeviceInfo.hardware; // Processor Information
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      info = iosInfo.utsname.machine; // Model identifier (e.g., iPhone14,4)
    }

    setState(() {
      processorInfo = info ?? "Processor info not available";
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProcessorInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Processor Info')),
      body: Center(
        child: Text(
          processorInfo,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
