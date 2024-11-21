import 'package:flutter/material.dart';

class TouchTrackerScreen extends StatefulWidget {
  const TouchTrackerScreen({super.key});

  @override
  State<TouchTrackerScreen> createState() => _TouchTrackerScreenState();
}

class _TouchTrackerScreenState extends State<TouchTrackerScreen> {
  List<Offset> _points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          // Menambahkan titik sentuhan baru ke daftar
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          _points.add(renderBox.globalToLocal(details.globalPosition));
        },
        onPanEnd: (details) {
          // Menghapus jalur saat jari diangkat (opsional)
          // Jika ingin tetap mempertahankan titik sebelumnya, abaikan bagian ini
          setState(() {
            // _points.clear();
          });
        },
        child: CustomPaint(
          painter: TouchTrackerPainter(_points),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class TouchTrackerPainter extends CustomPainter {
  final List<Offset?> points;

  TouchTrackerPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue // warna line
      ..strokeWidth = 24.0 // Ketebalan jalur
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
