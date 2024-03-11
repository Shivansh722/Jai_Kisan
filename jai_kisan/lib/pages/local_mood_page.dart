import 'package:flutter/material.dart';

class LocalMoodPage extends StatelessWidget {
  final Map<String, bool> surveyAnswers;

  LocalMoodPage({required this.surveyAnswers});

  @override
  Widget build(BuildContext context) {
    int yesCount = surveyAnswers.values.where((answer) => answer).length;
    int noCount = surveyAnswers.length - yesCount;

    String message = (yesCount > noCount)
        ? "The commodity prices might go up in the coming days."
        : "The commodity prices might go down.";

    double totalUsers = surveyAnswers.length.toDouble();
    double yesPercentage = (yesCount / totalUsers) * 100.0;
    double noPercentage = (noCount / totalUsers) * 100.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Local Mood'),
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
              SizedBox(height: 20),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Survey Results',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildGraphItem('Yes', yesPercentage),
                          _buildGraphItem('No', noPercentage),
                        ],
                      ),
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
    return Expanded(
      child: Column(
        children: [
          Text(
            '$label: ${percentage.toStringAsFixed(1)}%',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Container(
              width: 30,
              color: (label == 'Yes') ? Colors.green : Colors.red,
              child: Center(
                child: Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
