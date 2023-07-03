import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/market_model.dart';

class WatchlistProvider extends ChangeNotifier {
  final List<CryptoItemModel> _favorites = [];

  List<CryptoItemModel> get favorites => _favorites;

  void addToFavorites(CryptoItemModel currency) {
    _favorites.add(currency);
    notifyListeners();
  }

  void removeFromFavorites(CryptoItemModel currency) {
    _favorites.remove(currency);
    notifyListeners();
  }

  bool isFavorite(CryptoItemModel currency) {
    return _favorites.contains(currency);
  }

  static WatchlistProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<WatchlistProvider>(context, listen: listen);
  }
}
