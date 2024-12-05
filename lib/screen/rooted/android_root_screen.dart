import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidRootScreen extends StatefulWidget {
  const AndroidRootScreen({super.key});

  @override
  State<AndroidRootScreen> createState() => _AndroidRootScreenState();
}

class _AndroidRootScreenState extends State<AndroidRootScreen> {
  static const platform = MethodChannel('com.aplimelta.flashlight/main');

  //Initial Android root checker in set false value
  bool _rootedCheck = false;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      checkRoot();
    }
  }

  /// Memuat data sensor dari kelas SensorChecker
  Future<void> checkRoot() async {
    bool rootedCheck;
    try {
      rootedCheck = await platform.invokeMethod<bool>('isRootChecker') as bool;
      print(
          "Android device is rooted: $rootedCheck"); // Tambahkan log untuk memeriksa data yang diterima
    } on PlatformException catch (e) {
      print('Error fetching sensor data: ${e.message}');
      rootedCheck = false;
    }

    if (!mounted) return;

    setState(() {
      // Mengonversi result ke Map<String, dynamic> agar bisa diakses dengan benar
      _rootedCheck = rootedCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Platform.isAndroid
              ? Text('Running on Android\n\n Root Checker: $_rootedCheck')
              : const Text('Running on iOS')),
    );
  }
}
