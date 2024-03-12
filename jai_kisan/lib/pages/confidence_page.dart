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
        toolbarHeight: kToolbarHeight + 24,
        actions: [
          // Replace 'your_logo_asset.png' with your actual logo asset
          Image.asset('lib/assets/JK_logo.png'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200, // Set the desired height for the image
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/leaf.jpg'), // Replace with your actual image asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildResultCard('Class', resultClass ?? 'N/A'),
            const SizedBox(height: 20),
            _buildResultCard('Confidence', resultConfidence?.toString() ?? '0.0'),
            const SizedBox(height: 20),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Grow Green gives you the surety no one does!',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(String title, String value) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
