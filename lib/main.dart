import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:projectbesquare/cubit/bottom_navigation_cubit.dart.dart';
import 'package:projectbesquare/firebase_options.dart';
import 'package:projectbesquare/provider/watchlist_provider.dart';
import 'package:projectbesquare/register/onboarding.dart';
import 'package:projectbesquare/splash_screen.dart';
import 'package:projectbesquare/views/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Provider.debugCheckInvalidValueType = null;
  runApp(ChangeNotifierProvider<FavoriteProvider>(
    create: (context) => FavoriteProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CryptoPal',
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyAppHome extends StatelessWidget {
  const MyAppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return ChangeNotifierProvider<FavoriteProvider>(
      create: (context) => FavoriteProvider(),
      child: BlocProvider(
        create: (context) => BottomNavigationBarCubit(0),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomePage();
              } else {
                return OnboardingPage(emailController: emailController);
              }
            },
          ),
        ),
      ),
    );
  }
}
