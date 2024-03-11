import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<XFile?> takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    return pickedImage;
  }

  static Future<XFile?> pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    return pickedImage;
  }
}
