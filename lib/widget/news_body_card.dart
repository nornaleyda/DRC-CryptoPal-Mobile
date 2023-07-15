import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            title!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image!),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'News tags: $tags',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              body!,
              style: const TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Source: ',
                      style: TextStyle(fontSize: 15, color: Color(0xFFBB0163)),
                    ),
                    TextSpan(
                      text: '$source',
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
