import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _isFrontCameraSupported = false;
  bool _isBackCameraSupported = false;

  // late CameraController _cameraController;
  // late List<CameraDescription> _cameras;
  // Future<void>? _initializeControllerFuture;

  // Future<void> initCamera() async {
  //   _cameras = await availableCameras();
  //   _cameraController = CameraController(_cameras.first, ResolutionPreset.max);
  //   _initializeControllerFuture = _cameraController.initialize();
  //   setState(
  //       () {}); // Memperbarui UI setelah _initializeControllerFuture diatur
  // }

  @override
  void initState() {
    super.initState();
    // initCamera();
    _checkCameraSupport();
  }

  Future<void> _checkCameraSupport() async {
    final cameras = await availableCameras();
    setState(() {
      _isFrontCameraSupported = cameras
          .any((camera) => camera.lensDirection == CameraLensDirection.front);
      _isBackCameraSupported = cameras
          .any((camera) => camera.lensDirection == CameraLensDirection.back);
    });
  }

  @override
  void dispose() {
    // _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a picture'),
      ),
      // body: _initializeControllerFuture == null
      //     ? const Center(child: CircularProgressIndicator())
      //     : FutureBuilder(
      //         future: _initializeControllerFuture,
      //         builder: (context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.done) {
      //             return CameraPreview(_cameraController);
      //           } else {
      //             return const Center(child: CircularProgressIndicator());
      //           }
      //         },
      //       ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     if (_initializeControllerFuture == null) return;
      //
      //     try {
      //       // Pastikan kamera sudah diinisialisasi
      //       await _initializeControllerFuture;
      //
      //       // Ambil gambar
      //       final image = await _cameraController.takePicture();
      //
      //       if (!context.mounted) return;
      //
      //       // Navigasi ke layar tampilan gambar
      //       await Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (context) =>
      //               DisplayPictureScreen(imagePath: image.path),
      //         ),
      //       );
      //     } catch (e) {
      //       print(e);
      //     }
      //   },
      //   child: const Icon(Icons.camera_alt),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Front Camera: ${_isFrontCameraSupported ? "Supported" : "Not Supported"}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              'Back Camera: ${_isBackCameraSupported ? "Supported" : "Not Supported"}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
