import 'package:flutter/material.dart';
import 'package:jai_kisan/models/news_model.dart';
import 'package:jai_kisan/components/news_card.dart';

class NewsPage extends StatelessWidget {
  final List<News> newsList = [
    News(
      imageAsset: 'lib/assets/news1.gif',
      headline: 'Farmers burn vehicles, attack cops in Karnataka',
      description: 'The incident took place on Monday in Byadagi area of Haveri district. The farmers threw stones on the APMC building and gutted three vehicles.',
    ),
    News(
      imageAsset: 'lib/assets/news2.jpg',
      headline: 'Ensure potato farmers face no inconvenience: U.P. CS',
      description: 'Government ensures top value for farmers produce, focusing on potato storage and sale. UP leads in potato production, with higher market prices this year.',
    ),
    News(
      imageAsset: 'lib/assets/news3.jpg',
      headline: 'Farmers 4-Hour "Rail Roko" Today In Protest For Safety Net On Crop Prices',
      description: 'The Samyukta Kisan Morcha (Non-Political) and the Kisan Mazdoor Morcha have called for the countrywide "rail roko" protest from 12 pm to 4 pm.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Page'),
        toolbarHeight: kToolbarHeight + 24,
        actions: [
          // Replace 'your_logo_asset.png' with your actual logo asset
          Image.asset('lib/assets/JK_logo.png'),
        ],
      ),
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return NewsCard(news: newsList[index]);
        },
      ),
    );
  }
}