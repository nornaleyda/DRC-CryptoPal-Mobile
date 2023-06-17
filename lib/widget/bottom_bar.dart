import 'package:flutter/material.dart';
import 'package:projectbesquare/views/home.dart';
import 'package:projectbesquare/views/market.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key, required this.index})
      : super(key: key);

  final int index;

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  void _onItemTapped(int index) {
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
              pageBuilder: (context, anim1, anim2) => const MarketPage(),
              transitionDuration: Duration.zero),
        );
      //   break;
      // case 2:
      //   Navigator.pushReplacement(
      //     context,
      //     PageRouteBuilder(
      //         pageBuilder: (context, anim1, anim2) => const MyStanding(),
      //         transitionDuration: Duration.zero),
      //   );
      //   break;
      // case 3:
      //   Navigator.pushReplacement(
      //     context,
      //     PageRouteBuilder(
      //         pageBuilder: (context, anim1, anim2) => Leaderboard(),
      //         transitionDuration: Duration.zero),
      //   );
      //   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Center(
            child: Icon(Icons.house,
                size: widget.index == 0 ? 30 : 25,
                color: widget.index == 0
                    ? const Color.fromARGB(255, 102, 42, 180)
                    : Colors.grey),
          ),
          label: widget.index == 0 ? 'Home' : '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_exchange,
              size: widget.index == 1 ? 30 : 25,
              color: widget.index == 1
                  ? const Color.fromARGB(255, 102, 42, 180)
                  : Colors.grey),
          label: widget.index == 1 ? 'Market' : ' ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper,
              size: widget.index == 2 ? 30 : 25,
              color: widget.index == 2
                  ? const Color.fromARGB(255, 102, 42, 180)
                  : Colors.grey),
          label: widget.index == 2 ? 'News' : ' ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star,
              size: widget.index == 3 ? 30 : 25,
              color: widget.index == 3
                  ? const Color.fromARGB(255, 102, 42, 180)
                  : Colors.grey),
          label: widget.index == 3 ? 'Test' : ' ',
        ),
      ],
      currentIndex: widget.index,
      selectedItemColor: const Color.fromARGB(255, 102, 42, 180),
      unselectedItemColor: Colors.grey,
      onTap: (int index) => _onItemTapped(index),
    );
  }
}
