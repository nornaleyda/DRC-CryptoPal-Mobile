import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/market_api.dart';
import '../body/market_body.dart';
import '../cubit/bottom_navigation_cubit.dart.dart';
import '../model/market_model.dart';
import '../widget/bottom_navigation.dart';
import '../widget/market_card.dart';
import '../widget/loading_bar.dart';

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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    filterCrypto(value);
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 233, 231, 231),
                      labelText: 'Search currency',
                      labelStyle: const TextStyle(
                        color: Colors.blueGrey,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.blueGrey,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.white),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isDescending = false;
                          sortCrypto();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDescending
                            ? const Color(0xFF979797)
                            : Colors.pink,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Highest',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isDescending = true;
                          sortCrypto();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDescending
                            ? Colors.pink
                            : const Color(0xFF979797),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Lowest',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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

  void filterCrypto(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCrypto = crypto;
      } else {
        filteredCrypto = crypto.where((currency) {
          return currency.name!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
      sortCrypto();
    });
  }

  void sortCrypto() {
    filteredCrypto.sort((a, b) {
      if (isDescending) {
        return b.price!.compareTo(a.price!);
      } else {
        return a.price!.compareTo(b.price!);
      }
    });
  }
}
