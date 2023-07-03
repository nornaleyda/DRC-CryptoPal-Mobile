import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bottom_navigation_cubit.dart.dart';
import '../widget/bottom_navigation.dart';

class WatchList extends StatelessWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBarCubit>(
        create: (context) => BottomNavigationBarCubit(3),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color(0xFF0D0D2B),
            title: const Text('CryptoPal'),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              Column(
                children: const [
                  Text('oops.. you havent add anything to your watchlist')
                ],
              )
            ],
          ),
          bottomNavigationBar: const BottomNavigation(),
        ));
  }
}
