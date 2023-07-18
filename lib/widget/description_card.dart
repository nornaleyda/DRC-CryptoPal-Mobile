import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      margin: const EdgeInsets.all(2.0),
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
              Text(
                'About',
                style: GoogleFonts.robotoSlab(
                    color: const Color.fromARGB(255, 78, 76, 76),
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold),
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
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _launchUrl,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: const Color(0xFFBB0163),
                    ),
                    child: const Text(
                      'Visit Homepage',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(website!);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
