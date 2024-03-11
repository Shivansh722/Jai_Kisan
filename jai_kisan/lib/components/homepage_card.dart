import 'package:flutter/material.dart';
import 'package:jai_kisan/pages/result_page.dart';
import 'package:jai_kisan/components/dropdown_menu.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  String? selectedCommodity;
  String? selectedState;
  String? selectedDistrict;
  String? selectedMarket;

  @override
  Widget build(BuildContext context) {
    
    return Card(
      elevation: 10,
      color: Color.fromARGB(255,154,208,194),
       // Set the desired background color here
      shadowColor: const Color.fromARGB(255,38,80,115),
      surfaceTintColor: const Color.fromARGB(255,38,80,115),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.live_tv_outlined,
                  size: 18.0,
                  color: Colors.black,
                ),
                const SizedBox(width: 8.0),
                Text(
                  "Today's Live Price",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 20.0, color: Colors.black),
            const SizedBox(height: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                        selectedCommodity: selectedCommodity,
                        selectedState: selectedState,
                        selectedDistrict: selectedDistrict,
                        selectedMarket: selectedMarket),
                  ),
                );
              },
              child: const Text('Get Results'),
            ),
          ],
        ),
      ),
    );
  }
}
