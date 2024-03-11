import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchData extends StatefulWidget {
  const FetchData({
    Key? key,
  });

  @override
  State<FetchData> createState() => _FetchDataState();

  static Future<List<double>> fetchData() async {
    const baseUrl = 'http://127.0.0.1:5000/predict';
    const selectedCommodity = 'Wheat';
    const selectedDistrict = 'Kurukshetra';
    const selectedMarket = 'Digapahandi';
    const selectedState = 'Maharashtra';

    List<double> prices = [];

    for (int day = 0; day < 7; day++) {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'commodity': selectedCommodity,
          'district': selectedDistrict,
          'market': selectedMarket,
          'state': selectedState,
          'day': day,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final price = responseData['price'];
        prices.add(price);
      } else {
        print('Failed to fetch data for day $day. Error: ${response.statusCode}');
        // Handle error as needed
      }
    }

    print("Here $prices");
    return prices;
  }
}

class _FetchDataState extends State<FetchData> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}