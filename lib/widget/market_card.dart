import 'package:flutter/material.dart';

class MarketCard extends StatelessWidget {
  const MarketCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    required this.percent,
    required this.imageUrl,
    required this.marketCap,
  });

  final String? name;
  final String? symbol;
  final num? price;
  final num? change;
  final num? percent;
  final String? imageUrl;
  final String? marketCap;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        left: 10.0,
        right: 10.0,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: const Color(0xFF979797).withOpacity(0.5),
                  width: 2.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height: 50,
              width: 50,
              child: Image.network('https://www.cryptocompare.com$imageUrl'),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  symbol!,
                  style: const TextStyle(
                    color: Color(0xFF979797),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price!.toDouble().toStringAsFixed(2),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Text(
                  percent!.toDouble() < 0
                      ? '${percent!.toDouble().toStringAsFixed(2)}%'
                      : '+${percent!.toDouble().toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: percent!.toDouble() > 0
                        ? const Color(0xFF57992D)
                        : Colors.red,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
