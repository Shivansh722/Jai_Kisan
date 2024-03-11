import 'package:flutter/material.dart';

class ConfidencePage extends StatelessWidget {
  final String? resultClass;
  final double? resultConfidence;

  const ConfidencePage({required this.resultClass, required this.resultConfidence});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Class: ${resultClass ?? "N/A"}',
              style: const TextStyle(fontSize: 24.0),
            ),
            Text(
              'Confidence: ${resultConfidence ?? 0.0}',
              style: const TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}