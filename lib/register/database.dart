import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
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
        title: Text('User Data'),
      ),
      // body: Column(
      //   children: [
      //     TextField(
      //       controller: emailController,
      //       decoration: InputDecoration(
      //         labelText: 'Email',
      //       ),
      //     ),
      //     TextField(
      //       controller: favoriteController,
      //       decoration: InputDecoration(
      //         labelText: 'Favorite',
      //       ),
      //     ),
      //     ElevatedButton(
      //       onPressed: saveUserData,
      //       child: Text('Save User Data'),
      //     ),
      //   ],
      // ),
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

// void main() {
//   runApp(MaterialApp(
//     home: MainActivity(),
//   ));
// }
