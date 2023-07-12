import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

import '../model/market_model.dart';
import '../provider/watchlist_provider.dart';

class CryptoCardBody extends StatelessWidget {
  const CryptoCardBody({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.marketCap,
    required this.symbol,
    required this.percent,
  }) : super(key: key);

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
      marketCap: marketCap,
    );

    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 25.0, right: 18.0, bottom: 30.0, left: 18.0),
            child: Column(
              children: [
                Row(
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
                                  symbol!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  name!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
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
                                Consumer<FavoriteProvider>(
                                  builder: (context, provider, _) {
                                    return IconButton(
                                      iconSize: 35,
                                      onPressed: () {
                                        Provider.of<FavoriteProvider>(context,
                                                listen: false)
                                            .toggleFavorite(item);
                                      },
                                      icon: provider.isExist(item)
                                          ? const Icon(Icons.star,
                                              color: Colors.yellow)
                                          : const Icon(Icons.star_outline,
                                              color: Colors.grey),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 30.0,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Price',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  NumberFormat('#,###.00')
                                      .format(price!.toDouble()),
                                  style: const TextStyle(
                                    fontSize: 23,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Value',
                                    style: TextStyle(color: Colors.grey)),
                                Text(
                                  change!.toDouble() < 0
                                      ? change!.toDouble().toStringAsFixed(2)
                                      : '+${change!.toDouble().toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: change!.toDouble() > 0
                                        ? const Color(0xFF57992D)
                                        : Colors.red,
                                    fontSize: 23,
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
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          color: const Color(0xFF0D0D2B),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: DropdownButton(
                        items: const [
                          DropdownMenuItem(
                            value: 'Option 1',
                            child: Text('Option 1'),
                          ),
                          DropdownMenuItem(
                            value: 'Option 2',
                            child: Text('Option 2'),
                          ),
                        ],
                        onChanged: (value) {
                          // dropdown value 
                        },
                        hint: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'option',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        isExpanded: false,
                        underline:
                            const SizedBox(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const [
                    Text(
                      'chart',
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1.2,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
