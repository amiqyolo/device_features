import 'dart:io';

class Utils {
  static Future<Map<String, String>> getCpuInfo() async {
    final cpuInfo = await File('/proc/cpuinfo').readAsString();
    final lines = cpuInfo.split('\n');
    final Map<String, String> cpuDetails = {};

    for (var line in lines) {
      if (line.contains(':')) {
        final parts = line.split(':');
        cpuDetails[parts[0].trim()] = parts[1].trim();
      }
    }
    return cpuDetails;
  }

  static Future<int> getTotalRAM() async {
    final memInfo = await File('/proc/meminfo').readAsString();
    final lines = memInfo.split('\n');

    for (var line in lines) {
      if (line.startsWith('MemTotal:')) {
        final parts = line.split(RegExp(r'\s+'));
        return int.parse(parts[1]) * 1024; // Convert KB to Bytes
      }
    }
    return 0;
  }
}