import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrintScreen extends StatelessWidget {
  const FingerPrintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalAuthentication localAuth = LocalAuthentication();

    Future<void> authenticateWithFingerprint() async {
      try {
        final isAuthenticated = await localAuth.authenticate(
            localizedReason: 'Authenticate to access secure features');
        final message = isAuthenticated
            ? "Authentication Successful"
            : "Authentication Failed";
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Fingerprint Authentication')),
      body: Center(
        child: ElevatedButton(
          onPressed: authenticateWithFingerprint,
          child: const Text("Authenticate with Fingerprint"),
        ),
      ),
    );
  }
}
