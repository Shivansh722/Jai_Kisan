import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:jai_kisan/services/price_card.dart';

class ResultPage extends StatelessWidget {
  final String? selectedCommodity;
  final String? selectedState;
  final String? selectedDistrict;
  final String? selectedMarket;

  const ResultPage({
    Key? key,
    required this.selectedCommodity,
    required this.selectedState,
    this.selectedDistrict,
    required this.selectedMarket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime currentDateTime = DateTime.now();
    String formattedDateTime =
        DateFormat('MMMM yyyy HH:mm').format(currentDateTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(25, 40, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.chevron_left),
                const SizedBox(width: 4),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    ' ${formattedDateTime} ',
                    style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.chevron_right),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const Text(
                  'Market: ',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10.0),
                Text(
                  selectedMarket ?? 'No Market Selected',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const Text(
                  'Commodity: ',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10.0),
                Text(
                  selectedCommodity ?? 'No Commodity Selected',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Center(
              child: PriceCard(),
            ),
            
          ],
        ),
      ),
    );
  }
}
