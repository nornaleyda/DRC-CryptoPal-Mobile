import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:projectbesquare/views/description.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:projectbesquare/api/chart_api.dart';
import 'package:projectbesquare/model/market_model.dart';
import 'package:projectbesquare/provider/watchlist_provider.dart';

class CryptoCardBody extends StatefulWidget {
  const CryptoCardBody({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.marketCap,
    required this.symbol,
    required this.percent,
    required this.cryptocurrencyName,
  }) : super(key: key);

  final String? name;
  final String? imageUrl;
  final num? price;
  final num? change;
  final String? marketCap;
  final String? symbol;
  final num? percent;
  final String cryptocurrencyName;

  @override
  State<CryptoCardBody> createState() => _CryptoCardBodyState();
}

class _CryptoCardBodyState extends State<CryptoCardBody> {
  List<String> dropdownItems = ['USD', 'GBP', 'EUR'];
  late String selectedCurrency;

  @override
  void initState() {
    super.initState();
    selectedCurrency = 'USD';
  }

  void updateCurrency(String currency) {
    setState(() {
      selectedCurrency = currency;
    });
  }

  @override
  Widget build(BuildContext context) {
    CryptoItemModel item = CryptoItemModel(
      name: widget.name,
      symbol: widget.symbol,
      price: widget.price,
      change: widget.change,
      percent: widget.percent,
      imageUrl: widget.imageUrl,
      marketCap: widget.marketCap,
    );

    return SingleChildScrollView(
      child: Column(
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
                                      'https://www.cryptocompare.com${widget.imageUrl}',
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
                                    widget.symbol!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.name!,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                            ? const Icon(Icons.star_rounded,
                                                color: Colors.yellow)
                                            : const Icon(
                                                Icons.star_border_rounded,
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
                                    NumberFormat('#,##0.00')
                                        .format(widget.price!.toDouble()),
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
                                    '${widget.change!.toDouble() < 0 ? '-' : '+'}${NumberFormat('#,##0.00').format(widget.change!.toDouble().abs())}',
                                    style: TextStyle(
                                      color: widget.change!.toDouble() > 0
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
                        width: 100.0,
                        height: 25.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        child: DropdownButton<String>(
                          items: dropdownItems.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedCurrency = value;
                              });
                              updateCurrency(value);
                            }
                          },
                          value: selectedCurrency,
                          hint: const Text(
                            'USD',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          isExpanded: true,
                          underline: const SizedBox(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Chart(
                    cryptocurrencyName: widget.symbol!,
                    currency: selectedCurrency,
                  ),
                  CryptoAboutList(symbol: widget.symbol!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
