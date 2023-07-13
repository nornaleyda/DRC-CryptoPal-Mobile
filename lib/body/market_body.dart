import 'package:flutter/material.dart';
import 'package:projectbesquare/model/market_model.dart';
import 'package:projectbesquare/widget/market_body_card.dart';


class CryptoDescr extends StatelessWidget {
  final CryptoItemModel currency;

  const CryptoDescr({Key? key, required this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D2B),
        title: const Text('Chart'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          CryptoCardBody(
            name: currency.name,
            imageUrl: currency.imageUrl,
            change: currency.change,
            price: currency.price,
            marketCap: currency.marketCap,
            percent: currency.percent,
            symbol: currency.symbol,
            cryptocurrencyName: currency.symbol!,
          ),
        ],
      ),
    );
  }
}
