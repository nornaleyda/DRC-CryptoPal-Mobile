import 'package:flutter/material.dart';

class NewsCardBody extends StatelessWidget {
  const NewsCardBody({
    super.key,
    required this.title,
    required this.source,
    required this.image,
    required this.body,
  });

  final String? title;
  final String? source;
  final String? image;
  final String? body;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                title!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: NetworkImage(image!),
                    fit: BoxFit.fill,
                  ),
                ),
                child: const Padding(padding: EdgeInsets.all(18.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Source: $source'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                body!,
                style: const TextStyle(height: 1.5),
              ),
            )
          ],
        ));
  }
}
