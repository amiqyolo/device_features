import 'package:device_info_plus/device_info_plus.dart';
import 'package:disk_space_2/disk_space_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils.dart';

class DeviceFile extends StatefulWidget {
  const DeviceFile({super.key});

  @override
  State<DeviceFile> createState() => _DeviceFileState();
}

class _DeviceFileState extends State<DeviceFile> {
  String _platformVersion = 'Unknown';
  double _totalDiskSpace = 0.0;
  double _freeDiskSpace = 0.0;
  String _model = "Unknown";
  String _brand = "Unknown";

  final _diskSpacePlugin = DiskSpace();

  @override
  void initState() {
    super.initState();
    _initPlatformState();
    _initDeviceInfo();
  }

  Future<void> _initPlatformState() async {
    String platformVersion;
    double totalDiskSpace;
    double freeDiskSpace;
    // double freeDiskSpaceForPath;

    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _diskSpacePlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    totalDiskSpace = await DiskSpace.getTotalDiskSpace ?? 0.0;
    freeDiskSpace = await DiskSpace.getFreeDiskSpace ?? 0.0;

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _totalDiskSpace = totalDiskSpace;
      _freeDiskSpace = freeDiskSpace;
      print(_totalDiskSpace / 1024);
      print(_freeDiskSpace / 1024);
      print(_freeDiskSpace / 1000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information Perangkat'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Informasi Perangkat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              FutureBuilder<Map<String, List<Map<String, String>>>>(
                future: Utils.getCpuInfoMultiCore(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final coreInfo = snapshot.data ?? {};
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: coreInfo.entries.map((entry) {
                      final coreName = entry.key;
                      final coreDetails = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(coreName,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          ...coreDetails.map((details) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: details.entries
                                  .map((e) => Text('${e.key}: ${e.value}'))
                                  .toList(),
                            );
                          }),
                          SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 16),
              FutureBuilder<int>(
                future: Utils.getTotalRAM(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final totalRAM = snapshot.data ?? 0;
                  final ramInGB =
                      (totalRAM / (1024 * 1024 * 1024)).toStringAsFixed(2);

                  return Column(
                    children: [
                      Text('Brand: $_brand'),
                      Text('Model: $_model'),
                      Text('Total RAM: $ramInGB GB'),
                      Text('Free RAM: $ramInGB GB'),
                      Text('Available RAM: $ramInGB GB'),
                      const SizedBox(height: 20),
                      Text('Running on: $_platformVersion'),
                      Text('Total disk space: ${(_totalDiskSpace / 1000).toStringAsFixed(2)} GB'),
                      Text('Free disk space: ${(_freeDiskSpace / 1024).toStringAsFixed(2)} GB'),
                      Text('Free disk space: ${(_freeDiskSpace / 1000).toStringAsFixed(2)} GB'),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String model;
    String brand;

    try {
      final AndroidDeviceInfo androidDeviceInfo =
      await deviceInfoPlugin.androidInfo;

      model = androidDeviceInfo.model;
      brand = androidDeviceInfo.manufacturer;

    } on PlatformException {
      model = "";
      brand = "";
    }

    if (!mounted) return;

    setState(() {
      _model = model;
      _brand = brand;
    });
  }
}
