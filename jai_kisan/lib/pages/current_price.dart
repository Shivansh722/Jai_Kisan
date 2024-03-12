import 'package:flutter/material.dart';
import 'package:jai_kisan/pages/result_page.dart';
import 'package:jai_kisan/components/dropdown_menu.dart';
// import statements


class LivePricePage extends StatefulWidget {
   LivePricePage({Key? key, this.selectedCommodity, this.selectedState, this.selectedDistrict,this.selectedMarket}) : super(key: key);
    String? selectedCommodity;
  String? selectedState;
  String? selectedDistrict;
  String? selectedMarket;


  @override
  _LivePricePageState createState() => _LivePricePageState();
}

class _LivePricePageState extends State<LivePricePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Price"),
      ),
      body: Card(
        elevation: 10,
        color: Color.fromARGB(255, 154, 208, 194),
        shadowColor: Color.fromARGB(255, 38, 115, 56),
        surfaceTintColor: Color.fromARGB(255, 23, 59, 27),
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
                    selectedValue: widget.selectedCommodity,
                    onChanged: (String? value) {
                      setState(() {
                        widget.selectedCommodity = value;
                      });
                    },
                  ),
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
                    selectedValue: widget.selectedState,
                    onChanged: (String? value) {
                      setState(() {
                        widget.selectedState = value;
                      });
                    },
                  ),
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
                    selectedValue: widget.selectedDistrict,
                    onChanged: (String? value) {
                      setState(() {
                        widget.selectedDistrict = value;
                      });
                    },
                  ),
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
                    selectedValue: widget.selectedMarket,
                    onChanged: (String? value) {
                      setState(() {
                        widget.selectedMarket = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LivePricePage(
                        selectedCommodity: widget.selectedCommodity,
                        selectedState: widget.selectedState,
                        selectedDistrict: widget.selectedDistrict,
                        selectedMarket: widget.selectedMarket,
                      ),
                    ),
                  );
                },
                child: const Text('Get Results'),
              ),            ],
          ),
        ),
      ),
    );
  }
}
