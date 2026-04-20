import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tsc_printer/tsc_printer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _tscPrinterPlugin = TscPrinter();
  String _status = 'Idle';

  Future<void> _setupPrinter() async {
    try {
      final result = await _tscPrinterPlugin.setup(Setup(type: ConnectionType.usb, data: ''));
      setState(() => _status = result ? 'Setup Successful' : 'Setup Failed');
    } catch (e) {
      setState(() => _status = 'Error setting up: $e');
    }
  }

  Future<void> _connectPrinter() async {
    try {
      final result = await _tscPrinterPlugin.connect();
      setState(() => _status = result ? 'Connected' : 'Connect Failed');
    } catch (e) {
      setState(() => _status = 'Error connecting: $e');
    }
  }

  Future<void> _checkConnection() async {
    try {
      final result = await _tscPrinterPlugin.isConnected();
      setState(() => _status = result ? 'Printer is Connected' : 'Printer is Disconnected');
    } catch (e) {
      setState(() => _status = 'Error checking connection: $e');
    }
  }

  Future<Uint8List> _createTextImage(String text) async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    
    // Draw white background
    final paint = Paint()..color = Colors.white;
    canvas.drawRect(const Rect.fromLTWH(0, 0, 400, 200), paint);

    // Draw text
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: 400);
    textPainter.paint(canvas, const Offset(20, 50));

    final picture = recorder.endRecording();
    final image = await picture.toImage(400, 200);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> _printReceipt() async {
    try {
      setState(() => _status = 'Generating image...');
      final imageBytes = await _createTextImage("Hello TSC Printer!");
      
      setState(() => _status = 'Printing...');
      final success = await _tscPrinterPlugin.printData(imageBytes);
      
      setState(() => _status = success ? 'Print Successful!' : 'Print Failed: Ensure connected');
    } catch (e) {
      setState(() => _status = 'Error printing: $e');
    }
  }

  Future<void> _disconnectPrinter() async {
    try {
      final result = await _tscPrinterPlugin.disconnect();
      setState(() => _status = result ? 'Disconnected' : 'Disconnect Failed');
    } catch (e) {
      setState(() => _status = 'Error disconnecting: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TSC Printer Example'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Status: $_status', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _setupPrinter,
                  child: const Text('1. Setup (USB)'),
                ),
                ElevatedButton(
                  onPressed: _connectPrinter,
                  child: const Text('2. Connect'),
                ),
                ElevatedButton(
                  onPressed: _checkConnection,
                  child: const Text('3. Check Connection'),
                ),
                ElevatedButton(
                  onPressed: _printReceipt,
                  child: const Text('4. Print "Hello TSC Printer"'),
                ),
                ElevatedButton(
                  onPressed: _disconnectPrinter,
                  child: const Text('5. Disconnect'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
