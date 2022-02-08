import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 120.0),
        child: Center(
          child: Column(
            children: <Widget>[
              const Text(
                'Calculator v.0.0.1',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: const Text(
                  'RASOLOMANANA H. Olivier',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: const Text(
                  'Release 11 january 2022',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
