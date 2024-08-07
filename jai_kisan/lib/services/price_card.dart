import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// ignore: must_be_immutable
class PriceCard extends StatefulWidget {
  // final String? selectedCommodity;
  // final String? selectedState;
  // final String? selectedMarket;
  PriceCard({
    // this.selectedCommodity,
    // this.selectedState,
    // this.selectedMarket,
    super.key,
  });

  String minPrice = "loading..."; // Initial value
  String modelPrice = "loading...";
  String maxPrice = "loading...";

  @override
  State<PriceCard> createState() => _PriceCardState();
}

class _PriceCardState extends State<PriceCard> {
  Future<void> fetchPrice() async {
    // var apiUrl = Uri.parse('http://10.5.178.63:5000/current_price');
    var apiUrl = Uri.parse('http://10.5.163.158:5000/current_price');

    var body = json.encode({
      "commodity": "WHEAT",
      "state": "MADHYA PRADESH",
      "market": "ITARSI"
    });
    print(body);

    try {
      final response = await http.post(
        apiUrl,
        body: body,
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)["prices"];
        setState(() {
          widget.minPrice = data['min_price'].toString();
          widget.modelPrice = data['modal_price'].toString();
          widget.maxPrice = data['max_price'].toString();
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               const Icon(
              Icons.attach_money, // You can use any icon you prefer
              size: 24.0,
            ),
            const SizedBox(width: 8.0),
            const Text(
              'Price Details',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
                const Divider(height: 20.0, color: Colors.black),
                Table(
  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
  columnWidths: const {
    0: IntrinsicColumnWidth(),
    1: IntrinsicColumnWidth(),
    2: IntrinsicColumnWidth(),
  },
  children: [
    buildTableRow('Min. Price: ', '₹ ${widget.minPrice} '),
    buildTableRow('Model Price: ', '₹ ${widget.modelPrice} '),
    buildTableRow('Max. Price: ', '₹ ${widget.maxPrice} '),
  ],
)
              ],
              
            ),
          ),

        ),
        SizedBox(height: 50.0),
               ColoredBox(
  color: const Color.fromARGB(255, 136, 224, 139),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(50.0), // Adjust the radius as needed
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Model Price: ₹${widget.modelPrice}',
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
)

      ],
    );
  }

  TableRow buildTableRow(String label, String value) {
  return TableRow(
    children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
        const SizedBox(width: 45.0),
        TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            color: Colors.white, // White background color
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
      ],
    );
  }
}
