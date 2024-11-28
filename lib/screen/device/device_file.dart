import 'package:flutter/material.dart';
import 'package:system_info2/system_info2.dart';

import '../../utils.dart';

class DeviceFile extends StatefulWidget {
  const DeviceFile({super.key});

  @override
  State<DeviceFile> createState() => _DeviceFileState();
}

class _DeviceFileState extends State<DeviceFile> {
  String _storageInfo = "Fetching...";

  @override
  void initState() {
    super.initState();
    _getStorageInfo();
  }

  Future<void> _getStorageInfo() async {
    try {
      final totalSpace = SysInfo.getTotalPhysicalMemory(); // Total capacity
      final freeSpace = SysInfo.getTotalPhysicalMemory(); // Free space

      setState(() {
        _storageInfo = """
Total Internal Storage: ${(totalSpace / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB
Available Free Space: ${(freeSpace / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB
        """;
      });
    } catch (e) {
      setState(() {
        _storageInfo = "Error fetching storage info: $e";
      });
    }
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
                          Text(coreName, style: TextStyle(fontWeight: FontWeight.bold)),
                          ...coreDetails.map((details) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: details.entries.map((e) => Text('${e.key}: ${e.value}')).toList(),
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
                  final ramInGB = (totalRAM / (1024 * 1024 * 1024)).toStringAsFixed(2);
        
                  return Column(
                    children: [
                      Text('Total RAM: $ramInGB GB'),
                      Text('Free RAM: $ramInGB GB'),
                      Text('Available RAM: $ramInGB GB'),
                      const SizedBox(height: 20),
                      Text(
                        _storageInfo,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _getStorageInfo,
                        child: const Text("Refresh Storage Info"),
                      ),
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
}
