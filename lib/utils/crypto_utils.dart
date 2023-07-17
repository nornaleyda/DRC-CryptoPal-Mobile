import 'package:projectbesquare/model/market_model.dart';

bool showNotFoundText = false;

class CryptoUtils {
  static List<CryptoItemModel> filterCrypto(
      List<CryptoItemModel> crypto, String query) {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      showNotFoundText = false;
      return crypto;
    } else {
      List<CryptoItemModel> filteredCrypto = crypto.where((currency) {
        return currency.name!
            .toLowerCase()
            .contains(trimmedQuery.toLowerCase());
      }).toList();

      showNotFoundText = filteredCrypto.isEmpty;

      return filteredCrypto;
    }
  }

  static void sortCrypto(
      List<CryptoItemModel> filteredCrypto, bool isDescending) {
    filteredCrypto.sort((a, b) {
      if (isDescending) {
        return b.price!.compareTo(a.price!);
      } else {
        return a.price!.compareTo(b.price!);
      }
    });
  }
}
