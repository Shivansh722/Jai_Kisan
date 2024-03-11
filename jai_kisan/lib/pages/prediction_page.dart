import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jai_kisan/components/dropdown_menu.dart';


class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  // Initialize variables to hold selected values
  String? selectedCommodity;
  String? selectedState;
  String? selectedDistrict;
  String? selectedMarket;
  String price = "Predicted Price"; // Initial value

  Future<void> fetchPrice() async {
    //var apiUrl = Uri.parse('http://10.5.178.63:5000/predict');
    var apiUrl = Uri.parse('http://127.0.0.1:5000/predict');

    var body = json.encode({
      'commodity': selectedCommodity,
      'district': selectedDistrict,
      'market': selectedMarket,
      'state': selectedState,
      'day': 0
    });

    final response = await http.post(
      apiUrl,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        price = data['price'].toString();
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CustomDropdownButton(
                          label: "Commodity",
                          options: const [
                            'Potato',
                            'Wheat',
                            'Onion',
                            'Tomato',
                            'Green Gram Dal (Moong Dal)',
                            'Rice',
                            'Soyabean',
                            'Lemon',
                          ],
                          selectedValue: selectedCommodity,
                          onChanged: (String? value) {
                            setState(() {
                              selectedCommodity = value;
                            });
                          }),
                      CustomDropdownButton(
                          label: "State",
                          options: const [
                            'Madhya Pradesh',
                            'Punjab',
                            'Uttar Pradesh',
                            'Maharashtra',
                            'Rajasthan',
                            'Gujarat',
                            'Andhra Pradesh',
                            'Bihar',
                            'Haryana',
                            'Chhattisgarh',
                            'Chandigarh'
                          ],
                          selectedValue: selectedState,
                          onChanged: (String? value) {
                            setState(() {
                              selectedState = value;
                            });
                          }),
                      CustomDropdownButton(
                          label: "District",
                          options: const [
                            'Gautam Budh Nagar',
                            'South District',
                            'Ballia',
                            'Imphal East',
                            'Jhalawar',
                            'Chitrakut',
                            'Patiala',
                            'Jalpaiguri',
                            'Thoubal',
                            'Fatehpur',
                            'Hyderabad',
                          ],
                          selectedValue: selectedDistrict,
                          onChanged: (String? value) {
                            setState(() {
                              selectedDistrict = value;
                            });
                          }),
                      CustomDropdownButton(
                          label: "Market",
                          options: const [
                            'Kalikiri',
                            'Rajapalayam',
                            'Bishramganj',
                            'Lakhanpuri',
                            'Nilagiri',
                            'Uniyara',
                            'Kondotty',
                            'Lasalgaon(Niphad)',
                            'Adampur',
                            'Sathur',
                            'Umreth',
                            'Ruperdeeha',
                            'Vemulawada',
                            'Dharapuram',
                            'Gauripur',
                            'Baruwasagar',
                            'Karamadai'
                          ],
                          selectedValue: selectedMarket,
                          onChanged: (String? value) {
                            setState(() {
                              selectedMarket = value;
                            });
                          }),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      fetchPrice();
                    },
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Price: $price',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
