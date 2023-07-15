import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DescriptionCard extends StatelessWidget {
  final String? symbol;
  final String? description;
  final String? website;

  const DescriptionCard({
    Key? key,
    required this.symbol,
    required this.description,
    required this.website,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 2,
        shadowColor: const Color(0xFF979797),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                symbol!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                description!,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 15.0),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                website!,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _launchUrl,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    backgroundColor: Colors.pink,
                  ),
                  child: const Text('Visit Homepage'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(website!);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
