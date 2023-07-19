import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCardBody extends StatelessWidget {
  final String? title;
  final String? source;
  final String? image;
  final String? body;
  final String? tags;

  const NewsCardBody({
    super.key,
    required this.title,
    required this.source,
    required this.image,
    required this.body,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
                width: double.infinity,
                child: Container(
                  color: Colors.grey,
                  child: Image.network(
                    image!,
                    fit: BoxFit.cover,
                  ),
                )),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'News tags: $tags',
                    style: GoogleFonts.robotoSlab(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 45.0, top: 30.0, right: 45.0, bottom: 30.0),
          child: Column(
            children: [
              Text(
                title!,
                style: GoogleFonts.robotoSlab(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(
                          Icons.travel_explore,
                          size: 24,
                          color: Colors.grey,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 8),
                      ),
                      TextSpan(
                        text: 'News by: $source',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                body!,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 78, 76, 76)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
