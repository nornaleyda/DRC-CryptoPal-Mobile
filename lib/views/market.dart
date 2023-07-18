import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:projectbesquare/api/market_api.dart';
import 'package:projectbesquare/body/market_body.dart';
import 'package:projectbesquare/cubit/bottom_navigation_cubit.dart.dart';
import 'package:projectbesquare/model/market_model.dart';
import 'package:projectbesquare/utils/crypto_utils.dart';
import 'package:projectbesquare/utils/filter_buttons.dart';
import 'package:projectbesquare/utils/search_field.dart';
import 'package:projectbesquare/widget/bottom_navigation.dart';
import 'package:projectbesquare/widget/loading_bar.dart';
import 'package:projectbesquare/widget/market_card.dart';

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
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
      child: WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF0D0D2B),
            title: Image.asset(
              'assets/light_logo.png',
              width: 130.0,
            ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Market',
                      style: GoogleFonts.robotoSlab(
                          fontSize: 40, fontWeight: FontWeight.bold),
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
                          itemCount: 10))
                  : Expanded(
                      child: filteredCrypto.isEmpty
                          ? const Center(
                              child: Text(
                                '- No result found -',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: filteredCrypto.length,
                              itemBuilder: (context, index) {
                                final currency = filteredCrypto[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            CryptoDescr(
                                          currency: currency,
                                        ),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return child;
                                        },
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 0,
                                    child: MarketCard(
                                        name: currency.name,
                                        symbol: currency.symbol,
                                        price: currency.price,
                                        change: currency.change,
                                        percent: currency.percent,
                                        imageUrl: currency.imageUrl,
                                        marketCap: currency.marketCap),
                                  ),
                                );
                              },
                            ),
                    ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    ));
  }

  Future<void> fetchCrypto() async {
    final response = await apiManager.getCryptoData();

    if (mounted) {
      setState(() {
        crypto = (response['Data'] as List<dynamic>)
            .map((json) => CryptoItemModel.fromJson(json))
            .toList();
        filteredCrypto = crypto;
      });
    }
  }

  void sortCrypto() {
    CryptoUtils.sortCrypto(filteredCrypto, isDescending);
  }
}
