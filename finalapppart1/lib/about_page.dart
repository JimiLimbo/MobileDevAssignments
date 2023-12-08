import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'About This App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'This is a mobile app developed as part of a project for learning mobile app development with Flutter and Dart. It features secure login functionality and demonstrates the use of local storage.',
                textAlign: TextAlign.center,
              ),
              // You can add more content here as needed
            ],
          ),
        ),
      ),
    );
  }
}
