import 'package:flutter/material.dart';
import 'package:jai_kisan/essentials/marquee.dart';

class LiveRunningBar extends StatelessWidget {
  final double price;

  const LiveRunningBar({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    bool isPriceHigh = price > 50.0;

    return Container(
      color: isPriceHigh ? Colors.green : Colors.red,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Marquee(
              text: 'Live Price: $price',
              style: const TextStyle(fontWeight: FontWeight.bold),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              velocity: 100.0,
              pauseAfterRound: const Duration(seconds: 1),
              startPadding: 10.0,
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
          Container(
            width: 10,
            color: isPriceHigh ? Colors.red : Colors.green,
          ),
        ],
      ),
    );
  }
}
