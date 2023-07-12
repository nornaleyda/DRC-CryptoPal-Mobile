import '../model/market_model.dart';

bool showNotFoundText = false;

class CryptoUtils {
  static List<CryptoItemModel> filterCrypto(
      List<CryptoItemModel> crypto, String query) {
    if (query.isEmpty) {
      showNotFoundText = false;
      return crypto;
    } else {
      List<CryptoItemModel> filteredCrypto = crypto.where((currency) {
        return currency.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();

      showNotFoundText = filteredCrypto.isEmpty;

      if (filteredCrypto.isEmpty) {
        print('no result found');
      }

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
