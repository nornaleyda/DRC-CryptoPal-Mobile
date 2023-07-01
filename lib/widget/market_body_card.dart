import 'package:flutter/material.dart';

class CryptoCardBody extends StatelessWidget {
  const CryptoCardBody(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.change});

  final String? name;
  final String? imageUrl;
  final num? price;
  final num? change;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Image.network(
                    'https://www.cryptocompare.com$imageUrl',
                    width: 100,
                  ),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      price!.toDouble().toStringAsFixed(2),
                      style: const TextStyle(
                        color: Color(0xFF979797),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      change!.toDouble() < 0
                          ? change!.toDouble().toStringAsFixed(2)
                          : '+${change!.toDouble().toStringAsFixed(2)}',
                      style: TextStyle(
                        color: change!.toDouble() > 0
                            ? const Color(0xFF57992D)
                            : Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'chart',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
