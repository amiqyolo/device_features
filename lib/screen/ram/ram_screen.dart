import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class RamScreen extends StatefulWidget {
  const RamScreen({super.key});

  @override
  State<RamScreen> createState() => _RamScreenState();
}

class _RamScreenState extends State<RamScreen> {
  String ramInfo = "Loading...";

  Future<void> fetchRamInfo() async {
    DeviceInfoPlugin deviceInfo = await DeviceInfoPlugin();
    String? info;

    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      // Fetching total RAM (requires advanced implementation)
      info = androidDeviceInfo?.isLowRamDevice.toString() ??
          "RAM info not available";
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      // Note: iOS does not directly provide RAM details via device_info_plus
      info = "RAM info not available on iOS";
    }

    setState(() {
      ramInfo = info ?? "RAM info not available";
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRamInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RAM Info')),
      body: Center(
        child: Text(
          ramInfo,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
