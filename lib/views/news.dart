import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/market_api.dart';
import '../body/news_body.dart';
import '../cubit/bottom_navigation_cubit.dart.dart';
import '../model/news_model.dart';
import '../widget/bottom_navigation.dart';
import '../widget/loading_bar.dart';
import '../widget/news_card.dart';

class CryptoNews extends StatefulWidget {
  const CryptoNews({Key? key}) : super(key: key);

  @override
  State<CryptoNews> createState() => _CryptoNews();
}

class _CryptoNews extends State<CryptoNews> {
  List<NewsItemModel> crypto = [];
  final ApiNews apiManager = ApiNews();
  final ScrollController _scrollController = ScrollController();

  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    super.initState();
    fetchNews();

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBarCubit>(
      create: (context) => BottomNavigationBarCubit(1),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF0D0D2B),
          title: Image.asset(
            'assets/light_logo.png',
            width: 150.0,
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: fetchNews,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 12.0),
                  child: Column(
                    children: const [
                      Text(
                        'News',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 12.0),
                  child: Column(
                    children: const [
                      Text(
                        'Read our crypto updates !',
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFFBB0163)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _isLoading
                    ? Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                const NewsCardLoading(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 5,
                                ),
                            itemCount: 5))
                    : Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: crypto.length,
                          itemBuilder: (context, index) {
                            final news = crypto[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        NewsBody(news: news),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return child;
                                    },
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
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

  Future<void> _loadMoreData() async {
    final additionalData = await apiManager.getMoreNewsData();

    if (mounted) {
      setState(() {
        crypto.addAll((additionalData['Data'] as List<dynamic>)
            .map((json) => NewsItemModel.fromJson(json))
            .toList());
      });
    }
  }
}
