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

  static Future<Map<String, List<Map<String, String>>>> getCpuInfoMultiCore() async {
    final cpuInfo = await File('/proc/cpuinfo').readAsString();
    final lines = cpuInfo.split('\n');

    List<Map<String, String>> coreDetails = [];
    Map<String, String> currentCore = {};

    for (var line in lines) {
      if (line.trim().isEmpty) {
        if (currentCore.isNotEmpty) {
          coreDetails.add(Map.from(currentCore));
          currentCore.clear();
        }
      } else if (line.contains(':')) {
        final parts = line.split(':');
        currentCore[parts[0].trim()] = parts[1].trim();
      }
    }

    // Pastikan core terakhir dimasukkan
    if (currentCore.isNotEmpty) {
      coreDetails.add(currentCore);
    }

    // Grupkan informasi berdasarkan core (berdasarkan key "processor")
    final Map<String, List<Map<String, String>>> coreGroupedInfo = {};
    for (int i = 0; i < coreDetails.length; i++) {
      coreGroupedInfo['Core $i'] = [coreDetails[i]];
    }

    return coreGroupedInfo;
  }
}