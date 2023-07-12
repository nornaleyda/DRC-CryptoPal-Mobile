import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF0D0D2B),
          centerTitle: true,
          title: const Text('About')),
      backgroundColor: const Color(0xFFF9FAFD),
      body: ListView(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'CryptoPal',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            margin: const EdgeInsets.all(18.0),
            height: 500,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 8,
              shadowColor: const Color(0xFF979797),
            ),
          ),
        ],
      ),
    );
  }
}
