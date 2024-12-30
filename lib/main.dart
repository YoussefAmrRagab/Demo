import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FallDetectionScreen(),
    );
  }
}

class FallDetectionScreen extends StatefulWidget {
  const FallDetectionScreen({super.key});

  @override
  State<FallDetectionScreen> createState() => _FallDetectionScreenState();
}

class _FallDetectionScreenState extends State<FallDetectionScreen> {
  String fallStatus = "No fall detected";

  @override
  void initState() {
    super.initState();

    accelerometerEventStream().listen((event) async {
      double verticalAcceleration = event.y; // Focus on the y-axis for vertical motion
      double fallingVelocity = -5; // Negative fallingVelocity for detecting acceleration towards the ground
      if (verticalAcceleration < fallingVelocity) {
        debugPrint(verticalAcceleration.toString());
        // TODO: implement action according to fall detection
        _makeCall('+201023287109');
        setState(() => fallStatus = "Fall detected!");
      } else {
        setState(() => fallStatus = "No fall detected");
      }
    });
  }

  void _makeCall(String phoneNumber) {
    FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fall Detection')),
      body: Center(
        child: Text(
          fallStatus,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
