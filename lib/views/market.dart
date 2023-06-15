import 'package:flutter/material.dart';
import '../widget/bottombar.dart';

class MarketTrade extends StatelessWidget {
  const MarketTrade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        centerTitle: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ]),
              child: Row(
                children: [
                  SizedBox(
                    height: 68,
                    width: 68,
                    child: Image.network(
                        'https://resources.cryptocompare.com/asset-management/1/1659708726266.png'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(index: selectedIndex),
    );
  }
}
