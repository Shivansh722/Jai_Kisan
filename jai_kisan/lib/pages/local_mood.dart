import 'package:flutter/material.dart';
import 'package:jai_kisan/components/bar_chart.dart';

class LocalMoodPage extends StatelessWidget {
  final Map<String, bool> surveyAnswers;

  const LocalMoodPage({Key? key, required this.surveyAnswers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int yesCount = surveyAnswers.values.where((answer) => answer).length;
    int noCount = surveyAnswers.length - yesCount;

    String message = (yesCount > noCount)
        ? "The commodity prices might go up in the coming days."
        : "The commodity prices might go down.";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Mood'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: (yesCount > noCount) ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BarChartSample1(
                              surveyAnswers: surveyAnswers,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text("label: positive"),
                              Text("Score: 92.9"),
                            ],
                          ),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Text("label: negative"),
                              Text("Score: 7.1"),
                            ],
                          ),
                        ],  
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGraphItem(String label, double percentage) {
    return Column(
      children: [
        Text(
          '$label: ${percentage.toStringAsFixed(1)}%',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: percentage,
          width: 40,
          color: (label == 'Yes') ? Colors.green : Colors.red,
          child: Center(
            child: Text(
              '${percentage.toStringAsFixed(1)}%',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
