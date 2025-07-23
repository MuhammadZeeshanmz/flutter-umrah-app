import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UmrahQAScreen extends StatefulWidget {
  const UmrahQAScreen({super.key});

  @override
  _UmrahQAScreenState createState() => _UmrahQAScreenState();
}

class _UmrahQAScreenState extends State<UmrahQAScreen> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';
  bool _isLoading = false;

  final String apiKey = 'AIzaSyAcZ-OM80S3hVdPHw3YMBwEDDlD_nrZdE8';

  Future<void> askQuestion(String question) async {
    setState(() {
      _isLoading = true;
      _response = '';
    });

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
    );

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": question},
          ],
        },
      ],
    });

    try {
      final res = await http.post(url, headers: headers, body: body);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final content = data['candidates'][0]['content']['parts'][0]['text'];
        setState(() {
          _response = content;
        });
      } else {
        setState(() {
          _response = 'Error: ${res.statusCode}\n${res.body}';
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Request failed: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Umrah Q&A with Gemini')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ask a question about Umrah',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  askQuestion(_controller.text);
                }
              },
              child: Text('Ask Gemini'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                  child: SingleChildScrollView(
                    child: Text(_response, style: TextStyle(fontSize: 16)),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
