import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/market_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<CryptoItemModel> _favoriteItems = [];
  List<CryptoItemModel> get favoriteItems => _favoriteItems;

  FavoriteProvider() {
    fetchFavorites();
  }

  Future<void> toggleFavorite(CryptoItemModel item) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User is not logged in.');
      return;
    }

    final userEmail = user.email;
    final userRef =
        FirebaseFirestore.instance.collection('userData').doc(userEmail);

    try {
      final index =
          _favoriteItems.indexWhere((favItem) => favItem.name == item.name);
      if (index != -1) {
        _removeFavoriteByIndex(index);
        await userRef.collection('favorites').doc(item.name).delete();
      } else {
        _favoriteItems.add(item);
        await userRef.collection('favorites').doc(item.name).set(item.toMap());
      }
      notifyListeners();
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  Future<void> fetchFavorites() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User is not logged in.');
        return;
      }

      final userEmail = user.email;
      final userRef =
          FirebaseFirestore.instance.collection('userData').doc(userEmail);

      final snapshot = await userRef.collection('favorites').get();
      final favoriteList = snapshot.docs
          .map((doc) => CryptoItemModel.fromMap(doc.data()))
          .toList();

      _favoriteItems.clear();
      _favoriteItems.addAll(favoriteList);
    } catch (e) {
      print('Error retrieving favorites: $e');
    }

    notifyListeners();
  }

  bool isExist(CryptoItemModel item) {
    final isExist = _favoriteItems.any(
      (favItem) => favItem.name == item.name,
    );
    return isExist;
  }

  void _removeFavoriteByIndex(int index) {
    if (index >= 0 && index < _favoriteItems.length) {
      _favoriteItems.removeAt(index);
      notifyListeners();
    }
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}
