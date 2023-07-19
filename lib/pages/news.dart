import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:projectbesquare/api/market_api.dart';
import 'package:projectbesquare/pages/news_body.dart';
import 'package:projectbesquare/cubit/bottom_navigation_cubit.dart';
import 'package:projectbesquare/model/news_model.dart';
import 'package:projectbesquare/component/bottom_navigation.dart';
import 'package:projectbesquare/component/loading_bar.dart';
import 'package:projectbesquare/component/news_card.dart';

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
      child: WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF0D0D2B),
          title: Image.asset(
            'assets/light_logo.png',
            width: 130.0,
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFFF9FAFD),
        body: RefreshIndicator(
          color: const Color(0xFFBB0163),
          backgroundColor: const Color(0xFFF9FAFD),
          onRefresh: fetchNews,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'News',
                        style: GoogleFonts.robotoSlab(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Read our crypto updates!',
                        style: GoogleFonts.robotoSlab(
                            fontSize: 15, color: const Color(0xFFBB0163)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
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
                            itemCount: 10))
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
                              child: Card(
                                color: const Color(0xFFF9FAFD),
                                elevation: 0,
                                child: NewsCard(
                                  imageUrl: news.imageUrl,
                                  title: news.title,
                                  source: news.source,
                                  img: news.img,
                                ),
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
    ));
  }

  Future<void> fetchNews() async {
    final response = await apiManager.getNewsData();

    if (mounted) {
      setState(() {
        crypto = (response['Data'] as List<dynamic>)
            .map((json) => NewsItemModel.fromJson(json))
            .toList();
      });
    }
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
