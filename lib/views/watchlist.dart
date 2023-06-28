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
        child:Scaffold(
      appBar: AppBar(title: const Text('Description')),
      body: ListView(
        children: [
          Column(
            children: const [Text('oops.. you havent add anything to your watchlist')],
          )
        ],
      ),
                bottomNavigationBar: const BottomNavigation(),

    ));
  }
}
