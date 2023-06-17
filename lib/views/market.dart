import 'package:flutter/material.dart';
import '../api/market_api.dart';
import '../widget/bottom_bar.dart';
import '../widget/market_card.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<dynamic> crypto = [];
  final ApiManager apiManager = ApiManager();

  @override
  void initState() {
    super.initState();
    fetchCrypto();
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
        centerTitle: true,
      ),
      bottomNavigationBar: MyBottomNavigationBar(index: selectedIndex),
      body: ListView.builder(
        itemCount: crypto.length,
        itemBuilder: (context, index) {
          final currency = crypto[index];
          final name = currency['CoinInfo']['FullName'];
          final symbol = currency['CoinInfo']['Name'];
          final price = currency['RAW']['USD']['PRICE'];
          final change = currency['RAW']['USD']['CHANGE24HOUR'];
          final changepercent = currency['RAW']['USD']['CHANGEPCT24HOUR'];

          return MarketCard(
            name: name,
            symbol: symbol,
            price: price,
            change: change,
            changepercent: changepercent,
          );
        },
      ),
    );
  }

  void fetchCrypto() async {
    print('fetchCrypto called');
    final response = await apiManager.getCryptoData();
    setState(() {
      crypto = response['Data'];
    });
    print('fetchCrypto completed');
  }
}
