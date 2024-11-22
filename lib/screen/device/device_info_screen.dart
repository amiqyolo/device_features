import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_info2/system_info2.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  late Map<String, dynamic> deviceInfo = {};
  late TargetPlatform? platform;

  Future<void> fetchDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> info;
    int deviceMemory = -1;

    try {
      deviceMemory = SysInfo.getTotalPhysicalMemory() ~/ (1024 * 1024) ?? -1;
      if (platform == TargetPlatform.android) {
        final AndroidDeviceInfo androidDeviceInfo =
            await deviceInfoPlugin.androidInfo;

        // print('DATA: ${androidDeviceInfo.data}');
        const int megaByte = 1024 * 1024;
        print('Kernel architecture     : ${SysInfo.kernelArchitecture}');
        print('Raw Kernel architecture : ${SysInfo.rawKernelArchitecture}');
        print('Kernel bitness          : ${SysInfo.kernelBitness}');
        print('Kernel name             : ${SysInfo.kernelName}');
        print('Kernel version          : ${SysInfo.kernelVersion}');
        print('Operating system name   : ${SysInfo.operatingSystemName}');
        print('Operating system version: ${SysInfo.operatingSystemVersion}');
        print('User directory          : ${SysInfo.userDirectory}');
        print('User id                 : ${SysInfo.userId}');
        print('User name               : ${SysInfo.userName}');
        print('User space bitness      : ${SysInfo.userSpaceBitness}');
        final cores = SysInfo.cores;
        print('Number of core    : ${cores.length}');
        for (final core in cores) {
          print('Architecture          : ${core.architecture}');
          print('Name                  : ${core.name}');
          print('Socket                : ${core.socket}');
          print('Vendor                : ${core.vendor}');
        }
        print('Total physical memory   '
            ': ${SysInfo.getTotalPhysicalMemory() ~/ megaByte} MB');
        print('Free physical memory    '
            ': ${SysInfo.getFreePhysicalMemory() ~/ megaByte} MB');
        print('Total virtual memory    '
            ': ${SysInfo.getTotalVirtualMemory() ~/ megaByte} MB');
        print('Free virtual memory     '
            ': ${SysInfo.getFreeVirtualMemory() ~/ megaByte} MB');
        print('Virtual memory size     '
            ': ${SysInfo.getVirtualMemorySize() ~/ megaByte} MB');

        // androidDeviceInfo.data.forEach(
        //   (key, value) => print(value),
        // );

        info = {
          'Basic Info': {
            'Brand': androidDeviceInfo.brand,
            'Model': androidDeviceInfo.model,
            'Version': androidDeviceInfo.version.release,
            'SDK Version': androidDeviceInfo.version.sdkInt,
            'Device': androidDeviceInfo.device,
            'Product': androidDeviceInfo.product,
          },
          'Hardware': {
            'Processor':
                androidDeviceInfo.supportedAbis ?? 'Unknown',
            'Total Physical Memory': '$deviceMemory MB',
            // 'Free Physical Memory': '${SysInfo.getFreePhysicalMemory() ~/ (1024 * 1024)} MB',
            // 'Total Virtual Memory': '${SysInfo.getTotalVirtualMemory() ~/ (1024 * 1024)} MB',
            // 'Free Virtual Memory': '${SysInfo.getFreeVirtualMemory() ~/ (1024 * 1024)} MB',
            // 'Virtual Memory Size': '${SysInfo.getVirtualMemorySize() ~/ (1024 * 1024)} MB',
            'Storage': "Total Storage: Placeholder GB",
            'Hardware': androidDeviceInfo.hardware,
            'Is Physical Device':
                androidDeviceInfo.isPhysicalDevice ? 'Yes' : 'No',
            'Supported 64-bit ABIs': androidDeviceInfo.supported64BitAbis,
          },
          'Software': {
            'Android Version': androidDeviceInfo.version.release,
            'SDK Version': androidDeviceInfo.version.sdkInt,
            'Security Patch': androidDeviceInfo.version.securityPatch,
          },
        };
      } else if (platform == TargetPlatform.iOS) {
        final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        info = {
          'Basic Info': {
            'Model': iosInfo.model,
            'Device': iosInfo.name,
            'System Name': iosInfo.systemName,
            'System Version': iosInfo.systemVersion,
          },
          'Hardware': {
            'Processor': iosInfo.utsname.machine,
            'Is Physical Device': iosInfo.isPhysicalDevice ? 'Yes' : 'No',
            'Name': iosInfo.name,
          },
          'Software': {
            'Build': iosInfo.utsname.release,
            'Kernel': iosInfo.utsname.version,
          },
          'Battery & Wireless': {
            'Wifi Address': iosInfo.identifierForVendor ?? 'Unavailable',
          },
        };
      } else {
        info = {'Error': 'Unsupported platform'};
      }
    } on PlatformException catch (e) {
      print(e);
      deviceMemory = -1;
      info = {'Error': 'Failed to PlatformException: $e'};
    } catch (e) {
      print(e);
      deviceMemory = -1;
      info = {'Error': 'Failed to get device info: $e'};
    }

    setState(() {
      deviceInfo = info;
      print(deviceInfo); // Debug: Check the structure of deviceInfo
    });
  }

  // @override
  // void initState() {
  //   fetchDeviceInfo();
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    platform = Theme.of(context).platform;
    fetchDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device Info')),
      body: deviceInfo.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        shrinkWrap: true,
              children: deviceInfo.entries.map((entry) {
                final value = entry.value;
                print('Processing entry: ${entry.key}'); // Debug
                print('Value: $value'); // Debug
                if (value is Map<String, dynamic> && value.isNotEmpty) {
                  return ExpansionTile(
                    title: Text(entry.key),
                    children: value.entries.map((subEntry) {
                      return ListTile(
                        title: Text(subEntry.key),
                        subtitle: Text(subEntry.value.toString()),
                      );
                    }).toList(),
                  );
                } else if (value != null) {
                  // Handle non-map entries
                  return ListTile(
                    title: Text(entry.key),
                    subtitle: Text(value.toString()),
                  );
                } else {
                  // Handle unexpected null or empty cases
                  return ListTile(
                    title: Text(entry.key),
                    subtitle: const Text('No data available'),
                  );
                }
              }).toList(),
            ),
    );
  }
}
