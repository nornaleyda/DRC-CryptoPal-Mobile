import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/market_api.dart';
import '../body/market_body.dart';
import '../cubit/bottom_navigation_cubit.dart.dart';
import '../model/market_model.dart';
import '../widget/bottom_navigation.dart';
import '../widget/market_card.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<CryptoItemModel> crypto = [];
  final ApiManager apiManager = ApiManager();

  @override
  void initState() {
    super.initState();
    fetchCrypto();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBarCubit>(
        create: (context) => BottomNavigationBarCubit(2),
        child: Scaffold(
          appBar: AppBar(title: const Text('Market'), centerTitle: true),
          body: ListView.builder(
            itemCount: crypto.length,
            itemBuilder: (context, index) {
              final currency = crypto[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CryptoDescr(
                        currency: currency,
                      ),
                    ),
                  );
                },
                child: MarketCard(
                  name: currency.name,
                  symbol: currency.symbol,
                  price: currency.price,
                  change: currency.change,
                  percent: currency.percent,
                  imageUrl: currency.imageUrl,
                ),
              );
            },
          ),
          bottomNavigationBar: const BottomNavigation(),
        ));
  }

  Future<void> fetchCrypto() async {
    print('fetchCrypto called');
    final response = await apiManager.getCryptoData();

    setState(() {
      crypto = (response['Data'] as List<dynamic>)
          .map((json) => CryptoItemModel.fromJson(json))
          .toList();
    });

    print('fetchCrypto completed');
  }
}
