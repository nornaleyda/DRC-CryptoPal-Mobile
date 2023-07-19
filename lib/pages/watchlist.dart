import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectbesquare/pages/market_body.dart';

import 'package:projectbesquare/cubit/bottom_navigation_cubit.dart';
import 'package:projectbesquare/component/watchlist_provider.dart';
import 'package:projectbesquare/component/bottom_navigation.dart';
import 'package:projectbesquare/component/market_card.dart';
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
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Watchlist',
                          style: GoogleFonts.robotoSlab(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'View your favorite coins here!',
                          style: GoogleFonts.robotoSlab(
                              fontSize: 15, color: const Color(0xFFBB0163)),
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
                                '- Add cryptocurrency to watchlist -',
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
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
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
                              child: Card(
                                elevation: 0,
                                child: MarketCard(
                                  name: item.name,
                                  symbol: item.symbol,
                                  price: item.price,
                                  change: item.change,
                                  percent: item.percent,
                                  imageUrl: item.imageUrl,
                                  marketCap: item.marketCap,
                                ),
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
        ));
  }
}
