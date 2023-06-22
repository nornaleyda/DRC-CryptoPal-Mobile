import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:projectbesquare/views/news.dart';
import 'package:projectbesquare/views/watchlist.dart';
import '../views/home.dart';
import '../views/market.dart';

class BottomNavigationBarCubit extends Cubit<int> {
  BottomNavigationBarCubit(int initialIndex) : super(initialIndex);

  void updateIndex(int index, BuildContext context) {
    emit(index);
    navigateToScreen(index, context);
  }

  void navigateToScreen(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => const HomePage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => const CryptoNews(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => const MarketPage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => const WatchList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
    }
  }
}
