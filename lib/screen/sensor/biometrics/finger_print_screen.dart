import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrintScreen extends StatefulWidget {
  const FingerPrintScreen({super.key});

  @override
  State<FingerPrintScreen> createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  String _authMessage = 'Press the button to authenticate';

  @override
  void initState() {
    super.initState();
    _checkBiometricSupport();
  }

  Future<void> _checkBiometricSupport() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final isDeviceSupported = await _auth.isDeviceSupported();
      final List<BiometricType> availableBiometrics = await _auth.getAvailableBiometrics();

      debugPrint("Available biometrics: $availableBiometrics");

      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        debugPrint("Fingerprint is available!");
      } else {
        debugPrint("Fingerprint is not available!");
      }

      debugPrint('canCheckBiometrics: $canCheck');
      debugPrint('isDeviceSupported: $isDeviceSupported');
      logDeviceInfo();

      setState(() {
        // _canCheckBiometrics = canCheck && isDeviceSupported;
        _canCheckBiometrics = canCheck;
      });
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        _authMessage = 'Error checking biometric support: $e';
      });
    }
  }

  Future<void> _authenticate() async {
    try {
      setState(() {
        _authMessage = 'Authenticating...';
      });

      final authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate to access secure features',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      setState(() {
        _authMessage = authenticated
            ? 'Authentication Successful'
            : 'Authentication Failed';
      });
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        _authMessage = 'Authentication Error: $e';
      });
    }
  }

  Future<void> logDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;

    debugPrint('Device: ${androidInfo.model}');
    debugPrint('Android Version: ${androidInfo.version.sdkInt}');
    debugPrint('Fingerprint Support: $_canCheckBiometrics');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _canCheckBiometrics
                    ? 'Device support fingerprint authentication'
                    : 'Device does not support fingerprint authentication',
                style: TextStyle(
                    color: _canCheckBiometrics ? Colors.black : Colors.red),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _canCheckBiometrics == true ? _authenticate : null,
                child: const Text('Authenticate with Fingerprint'),
              ),
              const SizedBox(height: 16.0),
              Text(
                _authMessage,
                style: const TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
