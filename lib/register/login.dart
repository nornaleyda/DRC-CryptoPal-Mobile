// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectbesquare/register/onboarding.dart';
import 'package:projectbesquare/register/signup.dart';
import 'package:projectbesquare/views/home.dart';

class Login extends StatefulWidget {
  final TextEditingController emailController;

  const Login({Key? key, required this.emailController}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;
  bool isPasswordVisible = false;

  @override
  void dispose() {
    resetTimer?.cancel();
    passwordController.dispose();
    super.dispose();
  }

  bool isLoginButtonEnabled() {
    final email = widget.emailController.text.trim();
    final password = passwordController.text.trim();
    return email.isNotEmpty && password.isNotEmpty;
  }

  void signInWithEmailAndPassword() async {
    try {
      final email = widget.emailController.text.trim();
      final password = passwordController.text.trim();

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        if (user.emailVerified) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                title: const Text('Email Verification Required'),
                content:
                    const Text('Please verify your email before logging in.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Color(0xFFBB0163)),
                    ),
                  ),
                ],
              );
            },
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  bool isResettingPassword = false;
  Timer? resetTimer;

  void resetPassword() async {
    if (isResettingPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            title: const Text('Reset Password'),
            content:
                const Text('Please wait a few minutes before trying again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK',
                    style: TextStyle(color: Color(0xFFBB0163))),
              ),
            ],
          );
        },
      );
      return;
    }

    isResettingPassword = true;

    final email = widget.emailController.text.trim();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            title: const Text('Reset Password'),
            content: const Text(
                'A password reset link has been sent to your email.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK',
                    style: TextStyle(color: Color(0xFFBB0163))),
              ),
            ],
          );
        },
      );

      const waitDuration = Duration(minutes: 5);
      resetTimer = Timer(waitDuration, () {
        isResettingPassword = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred while resetting your password.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D2B),
        title: const Text('CryptoPal'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            AkarIcons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    OnboardingPage(emailController: emailController),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return child;
                },
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: GoogleFonts.robotoSlab(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Journey across the cryptoverse now!',
                    style:
                        GoogleFonts.robotoSlab(color: const Color(0xFFBB0163)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: 50,
                child: TextField(
                  controller: widget.emailController,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: 50,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: resetPassword,
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Color(0xFFBB0163)),
                  ),
                ),
              ),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: Center(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 50),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoginButtonEnabled()
                      ? signInWithEmailAndPassword
                      : null,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        isLoginButtonEnabled()
                            ? const Color(0xFFBB0163)
                            : const Color.fromARGB(41, 187, 1, 100)),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SignUp(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return child;
                      },
                    ),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: 'Create account',
                        style: TextStyle(
                          color: Color(0xFFBB0163),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
