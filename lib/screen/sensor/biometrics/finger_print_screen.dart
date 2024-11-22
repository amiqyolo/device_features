import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrintScreen extends StatelessWidget {
  const FingerPrintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalAuthentication auth = LocalAuthentication();

    Future<bool> _authenticate() async {
      try {
        return await auth.authenticate(
          localizedReason: 'Authenticate to access this feature',
          options: const AuthenticationOptions(biometricOnly: true),
        );
      } catch (e) {
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            bool isAuthenticated = await _authenticate();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(isAuthenticated
                  ? 'Authentication Successful'
                  : 'Authentication Failed'),
            ));
          },
          child: const Text('Authenticate'),
        ),
      ),
    );
  }
}
