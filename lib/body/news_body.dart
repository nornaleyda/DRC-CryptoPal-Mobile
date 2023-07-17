import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:projectbesquare/model/news_model.dart';
import 'package:projectbesquare/widget/news_body_card.dart';

class NewsBody extends StatelessWidget {
  final NewsItemModel news;

  const NewsBody({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0D0D2B),
        leading: IconButton(
          icon: const Icon(
            AkarIcons.chevron_left,
            color: Colors.white, // Customize the color of the icon
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          NewsCardBody(
            title: news.title,
            source: news.source,
            image: news.imageUrl,
            body: news.body,
            tags: news.tags,
          ),
        ],
      ),
    );
  }
}
