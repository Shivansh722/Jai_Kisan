import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextPage extends StatefulWidget {
  @override
  _SpeechToTextPageState createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking.';
  TextEditingController _textInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('Speech recognition status: $status');
        },
        onError: (error) {
          print('Speech recognition error: $error');
        },
      );

      if (available) {
        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      _speech.stop();
    }

    setState(() {
      _isListening = !_isListening;
    });
  }

  void _onSubmit() {
    setState(() {
      _text = _textInputController.text;
    });
  }

  @override
  void dispose() {
    _textInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  _text,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _listen,
              child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _textInputController,
              decoration: InputDecoration(
                labelText: 'Enter Text',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _onSubmit,
              child: Text('Show Text'),
            ),
          ],
        ),
      ),
    );
  }
}
