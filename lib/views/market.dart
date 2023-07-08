import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/market_api.dart';
import '../body/market_body.dart';
import '../cubit/bottom_navigation_cubit.dart.dart';
import '../model/market_model.dart';
import '../utils/filter_buttons.dart';
import '../utils/search_field.dart';
import '../widget/bottom_navigation.dart';
import '../widget/market_card.dart';
import '../widget/loading_bar.dart';
import '../utils/crypto_utils.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  TextEditingController searchController = TextEditingController();
  List<CryptoItemModel> crypto = [];
  List<CryptoItemModel> filteredCrypto = [];
  bool isDescending = true;

  final ApiManager apiManager = ApiManager();

  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
    fetchCrypto();
  }

  SearchField _buildSearchField() {
    return SearchField(
      controller: searchController,
      onChanged: (value) {
        setState(() {
          filteredCrypto = CryptoUtils.filterCrypto(crypto, value);
          sortCrypto();
        });
      },
    );
  }

  FilterButtons _buildFilterButtons() {
    return FilterButtons(
      isDescending: isDescending,
      onHighestPressed: () {
        setState(() {
          isDescending = false;
          sortCrypto();
        });
      },
      onLowestPressed: () {
        setState(() {
          isDescending = true;
          sortCrypto();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBarCubit>(
      create: (context) => BottomNavigationBarCubit(2),
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF0D0D2B),
            title: const Text('CryptoPal'),
            centerTitle: true),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 12.0),
                child: Column(
                  children: const [
                    Text(
                      'Markets',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSearchField(),
              const SizedBox(height: 20),
              _buildFilterButtons(),
              _isLoading
                  ? Expanded(
                      child: ListView.separated(
                          itemBuilder: ((context, index) =>
                              const MarketCardLoading()),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 6.0,
                              ),
                          itemCount: 6))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: filteredCrypto.length,
                        itemBuilder: (context, index) {
                          final currency = filteredCrypto[index];

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
                                marketCap: currency.marketCap),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }

  Future<void> fetchCrypto() async {
    print('fetchCrypto called');
    final response = await apiManager.getCryptoData();

    if (mounted) {
      setState(() {
        crypto = (response['Data'] as List<dynamic>)
            .map((json) => CryptoItemModel.fromJson(json))
            .toList();
        filteredCrypto = crypto;
      });
    }

    print('fetchCrypto completed');
  }

  void sortCrypto() {
    CryptoUtils.sortCrypto(filteredCrypto, isDescending);
  }
}
