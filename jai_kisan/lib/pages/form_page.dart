import 'package:flutter/material.dart';
import 'package:jai_kisan/pages/local_mood.dart';

class MarketSurveyScreen extends StatefulWidget {
  const MarketSurveyScreen({Key? key});
  @override
  State<MarketSurveyScreen> createState() => _MarketSurveyScreenState();
}

class _MarketSurveyScreenState extends State<MarketSurveyScreen> {
  Map<String, bool?> surveyAnswers = {
    "Did you get the expected price?": null,
    "Are there any local agitations in the market?": null,
    "Were there any private companies that visited the market place?": null,
    "Are international exports functioning in your market?": null,
    "Is the variety of harvest in your market of high quality?": null,
    "Is the mobility of commodities affordable in your locality?": null,
    "Is the general market opinion positive?": null,
    "Is there any cartel politics in your locality?": null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Survey'),
        toolbarHeight: kToolbarHeight + 24,
        actions: [
          // Replace 'your_logo_asset.png' with your actual logo asset
          Image.asset('lib/assets/JK_logo.png'),
        ],
      ),
       backgroundColor: Color.fromARGB(255, 110, 162, 148),
      body: SingleChildScrollView(
       
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: surveyAnswers.keys.map((question) {
              return Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                surveyAnswers[question] = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: surveyAnswers[question] == true
                                  ? Color.fromARGB(255, 36, 58, 15)
                                  : const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: const Text('Yes'),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                surveyAnswers[question] = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: surveyAnswers[question] == false
                                  ? Color.fromARGB(255, 145, 10, 10)
                                  : const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: const Text('No'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the survey answers, considering null values
          final cleanedAnswers =
              surveyAnswers.map((key, value) => MapEntry(key, value ?? false));
          print(cleanedAnswers);

          // Navigate to LocalMood page with survey answers
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LocalMoodPage(surveyAnswers: cleanedAnswers),
            ),
          );
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MarketSurveyScreen(),
  ));
}
