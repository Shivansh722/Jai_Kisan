import 'package:flutter/material.dart';
// language_card.dart

class LanguageCard extends StatelessWidget {
  final String language;
  final String iconAsset; // Updated to use a PNG asset
  final Color color;
  final VoidCallback onTap;

  const LanguageCard({
    required this.language,
    required this.iconAsset,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: color.withOpacity(0.7), // Adjust the opacity of the background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Add rounded corners to the card
          side: BorderSide(color: Colors.white, width: 2.0), // Add an outline to the card
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconAsset,
                height: 50,
                width: 50,
                color: Colors.white, // Customize the color of the PNG asset
              ),
              SizedBox(height: 10),
              Text(
                language,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
