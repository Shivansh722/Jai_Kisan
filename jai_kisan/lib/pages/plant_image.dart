import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jai_kisan/components/image_picker_helper.dart';

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
    final pickedImage = await ImagePickerHelper.takePicture();
    _updateSelectedImage(pickedImage);
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage = await ImagePickerHelper.pickImageFromGallery();
    _updateSelectedImage(pickedImage);
  }

  void _updateSelectedImage(XFile? pickedImage) {
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
      return;
    }

    final apiUrl = Uri.parse("http://10.5.144.216:5000/predictleaf");
    final imageBytes = await widget._selectedImage!.readAsBytes();
    final request = http.MultipartRequest('POST', apiUrl)
      ..files.add(
        await http.MultipartFile.fromPath(
          "file",
          widget._selectedImage!.path,
        ),
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

Widget _buildImagePreview() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.greenAccent, width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget._selectedImage != null
              ? ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: Image.file(
                    File(widget._selectedImage!.path),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
              : const SizedBox.shrink(),
          if (widget._selectedImage == null)
           const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Text(
                  'Add Plant Picture here',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Page'),
      ),
      body: Column(
        children: [
          _buildImagePreview(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   
                    GestureDetector(
                      onTap: _pickImageFromGallery,
                      child: Image.asset(
                        'lib/assets/gallery.png', // Replace with your gallery button asset
                        width: 50,
                        height: 50,
                      ),
                    ),
                     GestureDetector(
                      onTap: _takePicture,
                      child: Image.asset(
                        'lib/assets/image.png', // Replace with your camera button asset
                        width: 50,
                        height: 50,
                      ),
                    ),
                    GestureDetector(
                      onTap: _submitImage,
                      child: Image.asset(
                        'lib/assets/send.png', // Replace with your submit button asset
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
