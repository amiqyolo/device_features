import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class WifiConnectivityScreen extends StatefulWidget {
  const WifiConnectivityScreen({super.key});

  @override
  State<WifiConnectivityScreen> createState() => _WifiConnectivityScreenState();
}

class _WifiConnectivityScreenState extends State<WifiConnectivityScreen> {
  String _wifiStatus = "Unknown";

  @override
  void initState() {
    super.initState();
    _checkWifiStatus();
  }

  Future<void> _checkWifiStatus() async {
    final connectivity = await Connectivity().checkConnectivity();
    setState(() {
      _wifiStatus = connectivity == ConnectivityResult.wifi
          ? 'Connected to WiFi'
          : 'Not Connected to WiFi';
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WiFi Status')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("WiFi Status: $_wifiStatus"),
            ElevatedButton(
              onPressed: _checkWifiStatus,
              child: const Text("Refresh WiFi Status"),
            ),
          ],
        ),
      ),
    );
  }
}
