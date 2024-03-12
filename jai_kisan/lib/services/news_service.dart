import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String?> getNewsLabel(String text) async {
    final apiUrl = Uri.parse('http://127.0.0.1:5000/predict_sentiment'); // Replace with your API URL
    final Map<String, dynamic> requestBody = {'text': text};

    try {
      final response = await http.post(
        apiUrl,
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['label'];
      } else {
        // Handle API error
        print('API Error: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      // Handle other errors
      print('Error: $error');
      return null;
    }
  }
}