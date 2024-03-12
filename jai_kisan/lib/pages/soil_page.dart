import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SoilPage extends StatefulWidget {
  SoilPage({Key? key});

  XFile? _selectedSoilImage;
   String? _resultSoilClass;
   double? _resultSoilConfidence;

  @override
  State<SoilPage> createState() => _SoilPageState();
}

class _SoilPageState extends State<SoilPage> {
  Future<void> _takeSoilPicture() async {
    final imagePicker = ImagePicker();
    final pickedSoilImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedSoilImage == null) {
      return;
    }

    setState(() {
      widget._selectedSoilImage = pickedSoilImage;
      widget._resultSoilClass = null;
      widget._resultSoilConfidence = null;
    });
  }

  Future<void> _pickSoilImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedSoilImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (pickedSoilImage == null) {
      return;
    }

    setState(() {
      widget._selectedSoilImage = pickedSoilImage;
      widget._resultSoilClass = null;
      widget._resultSoilConfidence = null;
    });
  }

  Future<void> _submitSoilImage() async {
    if (widget._selectedSoilImage == null) {
      // No soil image selected
      return;
    }

    final apiUrl = Uri.parse("http://10.5.163.158:5000/predict_soil"); // Update with your soil prediction API endpoint
    final soilImageBytes = await widget._selectedSoilImage!.readAsBytes();
    final request = http.MultipartRequest('POST', apiUrl)
      ..files.add(
        await http.MultipartFile.fromPath("file", widget._selectedSoilImage!.path),
      );

    final response = await request.send();

    if (response.statusCode == 200) {
      print('hello1');
      final Map<String, dynamic> data =
          json.decode(await response.stream.bytesToString());
          print(data);
      setState(() {
        widget._resultSoilClass = data['class'];
        widget._resultSoilConfidence = data['confidence'];
      });
    } else {
      // Handle API error
      print("API Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _takeSoilPicture,
              child: const Text('Capture Soil Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickSoilImageFromGallery,
              child: const Text('Pick Soil Image from Gallery'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitSoilImage,
              child: const Text('Submit Soil Image'),
            ),
            const SizedBox(height: 20),
            if (widget._selectedSoilImage != null)
              Image.file(
                File(widget._selectedSoilImage!.path),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            if (widget._resultSoilClass != null)
              Column(
                children: [
                  Text('Soil Class: ${widget._resultSoilClass}',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  ),
                  
                ],
              ),
          ],
        ),
      ),
    );
  }
}
