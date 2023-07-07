import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/market_model.dart';
import '../provider/watchlist_provider.dart';

class CryptoCardBody extends StatelessWidget {
  const CryptoCardBody(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.change,
      required this.marketCap,
      required this.symbol,
      required this.percent});

  final String? name;
  final String? imageUrl;
  final num? price;
  final num? change;
  final String? marketCap;
  final String? symbol;
  final num? percent;

  @override
  Widget build(BuildContext context) {
    CryptoItemModel item = CryptoItemModel(
        name: name,
        symbol: symbol,
        price: price,
        change: change,
        percent: percent,
        imageUrl: imageUrl,
        marketCap: marketCap);

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
                  Consumer<FavoriteProvider>(
                    builder: (context, provider, _) {
                      return IconButton(
                        onPressed: () {
                          Provider.of<FavoriteProvider>(context, listen: false)
                              .toggleFavorite(item);
                        },
                        icon: provider.isExist(item)
                            ? const Icon(Icons.star, color: Colors.yellow)
                            : const Icon(Icons.star_outline),
                      );
                    },
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
