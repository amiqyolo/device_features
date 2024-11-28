import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WifiConnectivityScreen extends StatefulWidget {
  const WifiConnectivityScreen({super.key});

  @override
  State<WifiConnectivityScreen> createState() => _WifiConnectivityScreenState();
}

class _WifiConnectivityScreenState extends State<WifiConnectivityScreen> {
  bool _wifiSupport = false;
  bool _isWifiConnected = false;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;


  @override
  void initState() {
    super.initState();
    // _checkWifiStatus();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _wifiSupport = true;
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      _wifiSupport = false;
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  Future<void> _checkWifiStatus() async {
    final connectivity = await Connectivity().checkConnectivity();
    setState(() {
      _wifiSupport = connectivity != ConnectivityResult.none;
      _isWifiConnected = connectivity == ConnectivityResult.wifi;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WiFi Status')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(flex: 2),
          Text(
            'Active connection types:',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text("Device WiFi Support: ${_wifiSupport ? 'Support' : 'Not Support'}"),
          const Spacer(),
          ListView(
            shrinkWrap: true,
            children: List.generate(
                _connectionStatus.length,
                    (index) => Center(
                  child: Text(
                    _connectionStatus[index].toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                )),
          ),
          const Spacer(flex: 2),
        ],
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     children: [
      //       Text("Device WiFi Support: ${_wifiSupport ? 'Support' : 'Not Support'}"),
      //       if (_wifiSupport) ...[
      //         Text("WiFi Connected: ${_isWifiConnected ? 'Yes' : 'No'}"),
      //       ],
      //       const SizedBox(height: 16),
      //       ElevatedButton(
      //         onPressed: _checkWifiStatus,
      //         child: const Text("Refresh WiFi Status"),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
