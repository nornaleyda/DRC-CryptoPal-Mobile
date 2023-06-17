import 'package:flutter/material.dart';
import '../widget/bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        centerTitle: true,
      ),
      bottomNavigationBar: MyBottomNavigationBar(index: selectedIndex),
    );
  }
}
