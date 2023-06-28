import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/market_api.dart';
import '../body/news_body.dart';
import '../cubit/bottom_navigation_cubit.dart.dart';
import '../model/news_model.dart';
import '../widget/bottom_navigation.dart';
import '../widget/news_card.dart';

class CryptoNews extends StatefulWidget {
  const CryptoNews({Key? key}) : super(key: key);

  @override
  State<CryptoNews> createState() => _CryptoNews();
}

class _CryptoNews extends State<CryptoNews> {
  List<NewsItemModel> crypto = [];
  final ApiNews apiManager = ApiNews();

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBarCubit>(
        create: (context) => BottomNavigationBarCubit(1),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('News'),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: fetchNews,
            child: ListView.builder(
              itemCount: crypto.length,
              itemBuilder: (context, index) {
                final news = crypto[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsBody(news: news),
                      ),
                    );
                  },
                  child: NewsCard(
                    imageUrl: news.imageUrl,
                    title: news.title,
                    source: news.source,
                    img: news.img,
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: const BottomNavigation(),
        ));
  }

  Future<void> fetchNews() async {
    print('news called');
    final response = await apiManager.getNewsData();

    if (mounted) {
      setState(() {
        crypto = (response['Data'] as List<dynamic>)
            .map((json) => NewsItemModel.fromJson(json))
            .toList();
      });
    }

    print('news completed');
  }
}
