import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class PriceCard extends StatefulWidget {
  PriceCard({
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
    var apiUrl = Uri.parse('http://10.5.178.63:5000/current_price');
    // var apiUrl = Uri.parse('http://127.0.0.1:5000/current_price');

    var body = json.encode(
        {"commodity": "WHEAT", "state": "MADHYA PRADESH", "market": "BERASIA"});

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
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                buildTableRow('Min. Price: ', widget.minPrice),
                buildTableRow('Model Price: ', widget.modelPrice),
                buildTableRow('Max. Price: ', widget.maxPrice),
              ],
            ),
          ],
        ),
      ),
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
            child: Text(
              value,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }
}
