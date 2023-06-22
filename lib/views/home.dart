import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectbesquare/views/profile.dart';
import '../cubit/bottom_navigation_cubit.dart.dart';
import '../widget/bottom_navigation.dart';
import '../api/market_api.dart';
import '../widget/home_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<dynamic> crypto = [];
  final ApiManager apiManager = ApiManager();

  @override
  void initState() {
    super.initState();
    fetchCrypto();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBarCubit>(
        create: (context) => BottomNavigationBarCubit(0),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Homepage'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const UserAccount(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(-1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          body: ListView.builder(
            itemCount: crypto.length,
            itemBuilder: (context, index) {
              final currency = crypto[index];
              final name = currency['CoinInfo']['FullName'];

              return HomeCard(name: name);
            },
          ),
          bottomNavigationBar: const BottomNavigation(),
        ));
  }

  Future<void> fetchCrypto() async {
    print('fetchCrypto home called');
    final cryptoData = apiManager.getCryptoData(limit: 3);
    final response = await cryptoData;

    if (mounted) {
      setState(() {
        crypto = response['Data'];
      });
    }

    print('fetchCrypto home completed');
  }
}
