import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/bottom_navigation_cubit.dart.dart';
import '../model/market_model.dart';
import '../widget/bottom_navigation.dart';
import '../api/market_api.dart';
import '../widget/home_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> crypto = [];
  final ApiManager apiManager = ApiManager();

  @override
  void initState() {
    super.initState();
    fetchCrypto();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBarCubit>(
      create: (context) => BottomNavigationBarCubit(0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D0D2B),
          title: const Text('Homepage'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome !',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Check out todays Top 6 currency !',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: Color(0xFFBB0163)),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(18.0),
              height: 500,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 8,
                shadowColor: const Color(0xFF979797),
                child: ListView.builder(
                  itemCount: crypto.length,
                  itemBuilder: (context, index) {
                    final currency = crypto[index];

                    return HomeCard(
                      name: currency.name,
                      symbol: currency.symbol,
                      imageUrl: currency.imageUrl,
                      price: currency.price,
                      change: currency.change,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }

  Future<void> fetchCrypto() async {
    print('fetchCrypto home called');
    final cryptoData = apiManager.getCryptoData(limit: 6);
    final response = await cryptoData;

    if (mounted) {
      setState(() {
        crypto = (response['Data'] as List<dynamic>)
            .map((json) => CryptoItemModel.fromJson(json))
            .toList();
      });
    }

    print('fetchCrypto home completed');
  }
}
