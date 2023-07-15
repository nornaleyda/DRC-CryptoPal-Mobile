import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectbesquare/body/market_body.dart';

import 'package:projectbesquare/cubit/bottom_navigation_cubit.dart.dart';
import 'package:projectbesquare/provider/watchlist_provider.dart';
import 'package:projectbesquare/widget/bottom_navigation.dart';
import 'package:projectbesquare/widget/market_card.dart';
import 'package:provider/provider.dart';

class WatchList extends StatefulWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  State createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  @override
  void initState() {
    super.initState();
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    favoriteProvider.fetchFavorites().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBarCubit>(
      create: (context) => BottomNavigationBarCubit(3),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF0D0D2B),
          title: Image.asset(
            'assets/light_logo.png',
            width: 130.0,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 12.0),
                child: Column(
                  children: const [
                    Text(
                      'Watchlist',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 12.0),
                child: Column(
                  children: const [
                    Text(
                      'View your favorite coins here!',
                      style: TextStyle(fontSize: 15, color: Color(0xFFBB0163)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Consumer<FavoriteProvider>(
                  builder: (context, provider, _) {
                    final favoriteItems = provider.favoriteItems;

                    if (favoriteItems.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text(
                            '- Add currency to watchlist -',
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: favoriteItems.length,
                      itemBuilder: (context, index) {
                        final item = favoriteItems[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        CryptoDescr(
                                  currency: item,
                                ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return child;
                                },
                              ),
                            );
                          },
                          child: MarketCard(
                            name: item.name,
                            symbol: item.symbol,
                            price: item.price,
                            change: item.change,
                            percent: item.percent,
                            imageUrl: item.imageUrl,
                            marketCap: item.marketCap,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
