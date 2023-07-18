import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectbesquare/api/chart_api_EUR.dart';
import 'package:projectbesquare/api/chart_api_GBP.dart';
import 'package:projectbesquare/api/chart_api_USD.dart';
import 'package:projectbesquare/views/description.dart';
import 'package:projectbesquare/widget/loading_bar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:projectbesquare/model/market_model.dart';
import 'package:projectbesquare/provider/watchlist_provider.dart';

class CryptoCardBody extends StatefulWidget {
  const CryptoCardBody({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.marketCap,
    required this.symbol,
    required this.percent,
    required this.cryptocurrencyName,
  }) : super(key: key);

  final String? name;
  final String? imageUrl;
  final num? price;
  final num? change;
  final String? marketCap;
  final String? symbol;
  final num? percent;
  final String cryptocurrencyName;

  @override
  State<CryptoCardBody> createState() => _CryptoCardBodyState();
}

class _CryptoCardBodyState extends State<CryptoCardBody> {
  bool showUSDChart = true;
  bool showGBPChart = false;
  bool showEURChart = false;

  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  void toggleChartVisibility(String currency) {
    setState(() {
      showUSDChart = currency == 'USD';
      showGBPChart = currency == 'GBP';
      showEURChart = currency == 'EUR';
    });
  }

  @override
  Widget build(BuildContext context) {
    CryptoItemModel item = CryptoItemModel(
      name: widget.name,
      symbol: widget.symbol,
      price: widget.price,
      change: widget.change,
      percent: widget.percent,
      imageUrl: widget.imageUrl,
      marketCap: widget.marketCap,
    );

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 25.0, right: 18.0, bottom: 30.0, left: 18.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 60,
                                    child: Image.network(
                                      'https://www.cryptocompare.com${widget.imageUrl}',
                                      width: 100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.symbol!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.name!,
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Consumer<FavoriteProvider>(
                                    builder: (context, provider, _) {
                                      return IconButton(
                                        iconSize: 35,
                                        onPressed: () {
                                          Provider.of<FavoriteProvider>(context,
                                                  listen: false)
                                              .toggleFavorite(item);
                                        },
                                        icon: provider.isExist(item)
                                            ? const Icon(Icons.star_rounded,
                                                color: Colors.yellow)
                                            : const Icon(
                                                Icons.star_border_rounded,
                                                color: Colors.grey),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30.0,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Price',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    NumberFormat('#,##0.00')
                                        .format(widget.price!.toDouble()),
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: 23,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Value',
                                      style: TextStyle(color: Colors.grey)),
                                  Text(
                                    '${widget.change!.toDouble() < 0 ? '-' : '+'}${NumberFormat('#,##0.00').format(widget.change!.toDouble().abs())}',
                                    style: GoogleFonts.robotoSlab(
                                      color: widget.change!.toDouble() > 0
                                          ? const Color(0xFF57992D)
                                          : Colors.red,
                                      fontSize: 23,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            color: const Color(0xFF0D0D2B),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          toggleChartVisibility('USD');
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (showUSDChart) {
                                return const Color(0xFFBB0163);
                              } else {
                                return Colors.grey;
                              }
                            },
                          ),
                        ),
                        child: const Text('USD'),
                      ),
                      const SizedBox(width: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          toggleChartVisibility('GBP');
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (showGBPChart) {
                                return const Color(0xFFBB0163);
                              } else {
                                return Colors.grey;
                              }
                            },
                          ),
                        ),
                        child: const Text(
                          'GBP',
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          toggleChartVisibility('EUR');
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (showEURChart) {
                                return const Color(0xFFBB0163);
                              } else {
                                return Colors.grey;
                              }
                            },
                          ),
                        ),
                        child: const Text(
                          'EUR',
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: showUSDChart,
                    child: ChartUSD(
                      cryptocurrencyName: widget.symbol!,
                    ),
                  ),
                  Visibility(
                    visible: showGBPChart,
                    child: ChartGBP(
                      cryptocurrencyName: widget.symbol!,
                    ),
                  ),
                  Visibility(
                    visible: showEURChart,
                    child: ChartEUR(
                      cryptocurrencyName: widget.symbol!,
                    ),
                  ),
                  _isLoading
                      ? SizedBox(
                          height: 200,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ListView.separated(
                                  itemBuilder: ((context, index) =>
                                      const DescriptionCardLoading()),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                  itemCount: 1)),
                        )
                      : CryptoAboutList(symbol: widget.symbol!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
