import '../model/market_model.dart';

class CryptoUtils {
  static List<CryptoItemModel> filterCrypto(List<CryptoItemModel> crypto, String query) {
    if (query.isEmpty) {
      return crypto;
    } else {
      return crypto.where((currency) {
        return currency.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  static void sortCrypto(List<CryptoItemModel> filteredCrypto, bool isDescending) {
    filteredCrypto.sort((a, b) {
      if (isDescending) {
        return b.price!.compareTo(a.price!);
      } else {
        return a.price!.compareTo(b.price!);
      }
    });
  }
}
