import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  final CollectionReference<Map<String, dynamic>> _userDataCollection =
      FirebaseFirestore.instance.collection('userData');
  final String _documentName = 'data';

  TextEditingController emailController = TextEditingController();
  TextEditingController favoriteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
      ),
    );
  }

  void saveUserData() {
    String email = emailController.text;
    String favorite = favoriteController.text;

    if (email.isEmpty || favorite.isEmpty) {
      return;
    }

    Map<String, dynamic> userData = {
      'email': email,
      'favorite': favorite,
    };

    _userDataCollection.doc(_documentName).set(userData).then((_) {
      print('User data has been saved!');
    }).catchError((error) {
      print('User data was not saved! $error');
    });
  }
}
