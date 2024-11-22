import 'package:device_features/screen/camera/camera_screen.dart';
import 'package:device_features/screen/device/device_info_screen.dart';
import 'package:device_features/screen/flashlight/flashlight_screen.dart';
import 'package:device_features/screen/flashlight/flashlight_torch_controller.dart';
import 'package:device_features/screen/sensor/sensor_screen.dart';
import 'package:device_features/screen/touchscreen/touch_screen.dart';
import 'package:device_features/screen/touchscreen/touch_tracker_screen.dart';
import 'package:device_features/widget/feature_button.dart';
import 'package:flutter/material.dart';

void main() {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Features'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            children: [
              FeatureButton(
                label: 'Access Camera',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CameraScreen()),
                ),
              ),
              FeatureButton(
                label: 'Access Sensors',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SensorScreen()),
                ),
              ),
              FeatureButton(
                label: 'Touch Screen',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TouchScreen()),
                ),
              ),
              FeatureButton(
                label: 'Access Flashlight',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const FlashlightScreen()),
                ),
              ),
              FeatureButton(
                label: 'Access Device Info',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DeviceInfoScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
