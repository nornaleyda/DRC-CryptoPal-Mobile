import 'package:flutter/material.dart';
import 'package:projectbesquare/api/market_api.dart';
import 'package:projectbesquare/model/cryptocurrencies_summary_model.dart';
import 'package:projectbesquare/widget/description_card.dart';

class CryptoAboutList extends StatefulWidget {
  const CryptoAboutList({Key? key, required this.symbol}) : super(key: key);

  final String symbol;

  @override
  State<CryptoAboutList> createState() => _CryptoAboutListState();
}

class _CryptoAboutListState extends State<CryptoAboutList> {
  List<AboutItemModel> about = [];
  final ApiAbout apiAbout = ApiAbout();

  @override
  void initState() {
    super.initState();
    fetchAbout();
  }

  Future<void> fetchAbout() async {
    print('fetchAbout called');
    final response = await ApiAbout.fetchAbout(widget.symbol);

    if (mounted) {
      setState(() {
        about = [AboutItemModel.fromJson(response as Map<String, dynamic>)];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: about.length,
        itemBuilder: (context, index) {
          final abouts = about[index];
          return DescriptionCard(
            symbol: abouts.symbol,
            description: abouts.description,
            website: abouts.website,
          );
        },
      ),
    );
  }
}
