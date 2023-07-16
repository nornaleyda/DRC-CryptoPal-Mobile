import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeCard extends StatelessWidget {
  final String? name;
  final String? symbol;
  final String? imageUrl;
  final num? price;
  final num? change;
  final num? percent;

  const HomeCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 20.0, bottom: 15.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 60,
                            child: Image.network(
                              'https://www.cryptocompare.com$imageUrl',
                              width: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
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
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            NumberFormat('#,##0.00').format(price!.toDouble()),
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            '${percent!.toDouble() < 0 ? '-' : '+'}${NumberFormat('#,##0.00').format(percent!.toDouble().abs())}%',
                            style: TextStyle(
                              color: percent!.toDouble() > 0
                                  ? const Color(0xFF57992D)
                                  : Colors.red,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
