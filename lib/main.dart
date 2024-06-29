import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHA-256 Encryption',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _messageController = TextEditingController();
  TextEditingController _verifyController = TextEditingController();
  TextEditingController _hashController = TextEditingController();
  String _verificationResult = '';

  String generateSha256Hash(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  void encryptMessage() {
    setState(() {
      String hash = generateSha256Hash(_messageController.text);
      _hashController.text = hash;
    });
  }

  void verifyMessage() {
    String verificationHash = generateSha256Hash(_verifyController.text);
    setState(() {
      _verificationResult = verificationHash == _hashController.text
          ? "Verification successful: The messages match."
          : "Verification failed: The messages do not match.";
    });
  }

  String getCurrentYear() {
    return DateTime.now().year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SHA-256 Encryption'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Message'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: encryptMessage,
              child: Text('Encrypt'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _hashController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Encrypted Message (SHA-256)',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _verifyController,
              decoration: InputDecoration(labelText: 'Verify Message'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: verifyMessage,
              child: Text('Verify'),
            ),
            SizedBox(height: 20),
            Text(_verificationResult),
            SizedBox(height: 20),
            Text(
              'Developed by Asaduzzaman | CSE | SHU | All Rights Reserved © ${getCurrentYear()}',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
