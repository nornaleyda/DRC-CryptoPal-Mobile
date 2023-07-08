import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectbesquare/views/about.dart';
import 'package:projectbesquare/views/help.dart';
import '../cubit/bottom_navigation_cubit.dart.dart';
import '../register/onboarding.dart';
import '../widget/bottom_navigation.dart';

class UserAccount extends StatelessWidget {
  UserAccount({Key? key}) : super(key: key);
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email ?? '';

    return BlocProvider<BottomNavigationBarCubit>(
        create: (context) => BottomNavigationBarCubit(4),
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF0D0D2B),
              title: const Text('CryptoPal'),
              centerTitle: true),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
            child: Column(
              children: [
                Text(
                  'Email: $userEmail',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const AboutPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          final tween = Tween(begin: begin, end: end);
                          final offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: const [Icon(Icons.info)],
                              )),
                          Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'About',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [Icon(Icons.navigate_next)])),
                        ],
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HelpPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          final tween = Tween(begin: begin, end: end);
                          final offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: const [Icon(Icons.build_outlined)],
                              )),
                          Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Help',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [Icon(Icons.navigate_next)])),
                        ],
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Logout Confirmation'),
                          content:
                              const Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Color(0xFFBB0163)),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OnboardingPage(
                                            emailController: emailController,
                                          )),
                                );
                              },
                              child: const Text(
                                'Logout',
                                style: TextStyle(color: Color(0xFFBB0163)),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: const [Icon(Icons.logout)],
                              )),
                          Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Logout',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [Icon(Icons.navigate_next)])),
                        ],
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const BottomNavigation(),
        ));
  }
}
