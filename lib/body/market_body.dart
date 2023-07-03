import 'package:flutter/material.dart';

import '../model/market_model.dart';
import '../widget/market_body_card.dart';

class CryptoDescr extends StatelessWidget {
  final CryptoItemModel currency;

  const CryptoDescr({Key? key, required this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Description')),
      body: ListView(
        children: [
          CryptoCardBody(
            name: currency.name,
            imageUrl: currency.imageUrl,
            change: currency.change,
            price: currency.price,
            marketCap: currency.marketCap,
          ),
          
        ],
      ),
    );
  }
}
