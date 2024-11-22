import 'package:flutter/material.dart';

import '../../utils.dart';

class DeviceFile extends StatefulWidget {
  const DeviceFile({super.key});

  @override
  State<DeviceFile> createState() => _DeviceFileState();
}

class _DeviceFileState extends State<DeviceFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information Perangkat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Perangkat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            FutureBuilder<Map<String, String>>(
              future: Utils.getCpuInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final cpuInfo = snapshot.data ?? {};
                final vendor = cpuInfo['vendor_id'] ?? 'Tidak Diketahui';
                final processor = cpuInfo['processor'] ?? 'Tidak Diketahui';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Vendor CPU: $vendor'),
                    Text('Processor: $processor'),
                  ],
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

                return Text('Total RAM: $ramInGB GB');
              },
            ),
          ],
        ),
      ),
    );
  }
}
