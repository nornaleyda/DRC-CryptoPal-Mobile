import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:projectbesquare/api/market_api.dart';
import 'package:projectbesquare/body/market_body.dart';
import 'package:projectbesquare/cubit/bottom_navigation_cubit.dart.dart';
import 'package:projectbesquare/model/market_model.dart';
import 'package:projectbesquare/widget/bottom_navigation.dart';
import 'package:projectbesquare/widget/home_card.dart';
import 'package:projectbesquare/widget/loading_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> crypto = [];
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBarCubit>(
      create: (context) => BottomNavigationBarCubit(0),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF0D0D2B),
          title: Image.asset(
            'assets/light_logo.png',
            width: 130.0,
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFFF9FAFD),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.robotoSlab(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Check out todays Top 6 currency!',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.robotoSlab(
                            fontSize: 15, color: const Color(0xFFBB0163)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                _isLoading
                    ? Container(
                        margin: const EdgeInsets.all(18.0),
                        height: 520,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 2,
                            shadowColor: const Color(0xFF979797),
                            child: ListView.separated(
                                itemBuilder: ((context, index) =>
                                    const MarketCardLoading()),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                itemCount: 6)),
                      )
                    : Container(
                        margin: const EdgeInsets.all(18.0),
                        height: 570,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 2,
                          shadowColor: const Color(0xFF979797),
                          child: ListView.builder(
                            itemCount: crypto.length,
                            itemBuilder: (context, index) {
                              final currency = crypto[index];
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
                                  child: HomeCard(
                                    name: currency.name,
                                    symbol: currency.symbol,
                                    imageUrl: currency.imageUrl,
                                    price: currency.price,
                                    change: currency.change,
                                    percent: currency.percent,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // ),
                      ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }

  Future<void> fetchCrypto() async {
    final cryptoData = apiManager.getCryptoData(limit: 6);
    final response = await cryptoData;

    if (mounted) {
      setState(() {
        crypto = (response['Data'] as List<dynamic>)
            .map((json) => CryptoItemModel.fromJson(json))
            .toList();
      });
    }
  }
}
