import 'package:flutter/material.dart';

class NewsCardBody extends StatelessWidget {
  const NewsCardBody({
    super.key,
    required this.title,
    required this.source,
    required this.image,
    required this.body,
    required this.tags,
  });

  final String? title;
  final String? source;
  final String? image;
  final String? body;
  final String? tags;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                title!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Source: ',
                      style: TextStyle(fontSize: 15, color: Color(0xFF979797)),
                    ),
                    TextSpan(
                      text: '$source',
                      style: const TextStyle(
                          fontSize: 15, color: Color(0xFFBB0163)),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image!),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'News tags: $tags',
                style: const TextStyle(fontSize: 15, color: Color(0xFFBB0163)),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: Text(
              body!,
              style: const TextStyle(height: 1.5),
            ),
          )
        ],
      ),
    );
  }
}
