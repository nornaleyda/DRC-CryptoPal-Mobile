import 'package:flutter/material.dart';
import 'package:projectbesquare/api/market_api.dart';
import 'package:projectbesquare/model/description_model.dart';
import 'package:projectbesquare/component/description_card.dart';

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
      child: Column(
        children: List.generate(
          about.length,
          (index) {
            final abouts = about[index];
            return DescriptionCard(
              symbol: abouts.symbol,
              description: abouts.description,
              website: abouts.website,
            );
          },
        ),
      ),
    );
  }
}
