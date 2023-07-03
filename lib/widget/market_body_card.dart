import 'package:flutter/material.dart';

class CryptoCardBody extends StatelessWidget {
  const CryptoCardBody(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.change,
      required this.marketCap});

  final String? name;
  final String? imageUrl;
  final num? price;
  final num? change;
  final String? marketCap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 100,
                    child: Image.network(
                      'https://www.cryptocompare.com$imageUrl',
                      width: 100,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Market Cap: $marketCap',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Price: $price',
                    style: const TextStyle(
                      // color: Color(0xFF979797),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    change!.toDouble() < 0
                        ? change!.toDouble().toStringAsFixed(2)
                        : '+${change!.toDouble().toStringAsFixed(2)}',
                    style: TextStyle(
                      color: change!.toDouble() > 0
                          ? const Color(0xFF57992D)
                          : Colors.red,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8.0),
              Column(
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.star_outline)
                      ),
                ],
              )
            ],
          ),
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'chart',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
