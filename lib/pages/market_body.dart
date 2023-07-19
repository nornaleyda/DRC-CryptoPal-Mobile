import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:projectbesquare/model/market_model.dart';
import 'package:projectbesquare/component/market_body_card.dart';

class CryptoDescr extends StatelessWidget {
  final CryptoItemModel currency;

  const CryptoDescr({Key? key, required this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chart'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0D0D2B),
        leading: IconButton(
          icon: const Icon(
            AkarIcons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
