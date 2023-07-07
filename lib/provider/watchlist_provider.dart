import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/market_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<CryptoItemModel> _favoriteItems = [];

  List<CryptoItemModel> get favoriteItems => _favoriteItems;

  static const _favoriteKey = 'favoriteKey';

  Future<void> toggleFavorite(CryptoItemModel item) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not logged in, handle the error or show a message
      print('User is not logged in.');
      // You can show a message to the user using a toast or a dialog
      return;
    }

    final userEmail = user.email;
    final userRef =
        FirebaseFirestore.instance.collection('userData').doc(userEmail);

    try {
      final index = _favoriteItems.indexWhere((favItem) => favItem.name == item.name);
      if (index != -1) {
        _removeFavoriteByIndex(index);
        print('itemRemove: ${item.name}');
        await userRef.collection('favorites').doc(item.name).delete();
      } else {
        _favoriteItems.add(item);
        print('itemAdd: ${item.name}');
        await userRef.collection('favorites').doc(item.name).set(item.toMap());
      }
      notifyListeners();
      // Remove the saveFavorites() call since we're not using SharedPreferences
    } catch (e) {
      // Handle any errors that occur during data modification
      print('Error toggling favorite: $e');
      // You can show a message to the user using a toast or a dialog
    }
  }

Future<void> fetchFavorites() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not logged in, handle the error or show a message
      print('User is not logged in.');
      // You can show a message to the user using a toast or a dialog
      return;
    }

    final userEmail = user.email;
    final userRef = FirebaseFirestore.instance.collection('userData').doc(userEmail);

    final snapshot = await userRef.collection('favorites').get();
    final favoriteList = snapshot.docs.map((doc) => CryptoItemModel.fromMap(doc.data())).toList();

    _favoriteItems.clear();
    _favoriteItems.addAll(favoriteList);
  } catch (e) {
    print('Error retrieving favorites: $e');
  }

  notifyListeners();
}

  bool isExist(CryptoItemModel item) {
    return _favoriteItems.contains(item);
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
