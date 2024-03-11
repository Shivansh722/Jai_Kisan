import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchData extends StatefulWidget {
  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  List<double> prices = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const baseUrl = 'http://10.5.144.216:5000/predict';
    const selectedCommodity = 'Wheat';
    const selectedDistrict = 'Kurukshetra';
    const selectedMarket = 'Digapahandi';
    const selectedState = 'Maharashtra';

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
        final price = responseData[
            'price']; // Adjust this based on your API response structure
        setState(() {
          prices.add(price);
        });
      } else {
        print('Failed to fetch data. Error: ${response.statusCode}');
        // Handle error as needed
      }
    }
    print(prices);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Call and Graph Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Prices: $prices'),
            // Add your graph widget here using the 'prices' list
          ],
        ),
      ),
    );
  }
}
