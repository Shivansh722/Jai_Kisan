import 'package:flutter/material.dart';
import 'package:jai_kisan/models/news_model.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;

  const NewsDetailPage({required this.news, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        toolbarHeight: kToolbarHeight + 24,
        actions: [
          // Replace 'your_logo_asset.png' with your actual logo asset
          Image.asset('lib/assets/JK_logo.png'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              news.imageAsset,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),
            Text(
              news.headline,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              news.description,
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}