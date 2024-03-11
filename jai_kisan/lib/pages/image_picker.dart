import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  ImagePickerPage({Key? key}) : super(key: key);

  XFile? _selectedImage;
  String? _resultClass;
  double? _resultConfidence;

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      widget._selectedImage = pickedImage;
      widget._resultClass = null;
      widget._resultConfidence = null;
    });
  }

  Future<void> _pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      widget._selectedImage = pickedImage;
      widget._resultClass = null;
      widget._resultConfidence = null;
    });
  }

  Future<void> _submitImage() async {
    if (widget._selectedImage == null) {
      // No image selected
      return;
    }

    final apiUrl = Uri.parse("http://10.5.144.216:5000/predictleaf");
    final imageBytes = await widget._selectedImage!.readAsBytes();
    final request = http.MultipartRequest('POST', apiUrl)
      ..files.add(
        await http.MultipartFile.fromPath("file", widget._selectedImage!.path),
      );

    final response = await request.send();

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(await response.stream.bytesToString());
      setState(() {
        widget._resultClass = data['class'];
        widget._resultConfidence = data['confidence'];
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
        title: const Text('Image Picker Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _takePicture,
              child: const Text('Capture Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImageFromGallery,
              child: const Text('Pick Image from Gallery'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitImage,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            if (widget._selectedImage != null)
              Image.file(
                File(widget._selectedImage!.path),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            // if (_resultClass != null && _resultConfidence != null)
            Column(
              children: [
                Text('Class: ${widget._resultClass}'),
                Text('Confidence: ${widget._resultConfidence}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
