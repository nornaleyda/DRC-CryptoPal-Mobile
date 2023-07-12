// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: widget.emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void resetPassword() async {
    final email = widget.emailController.text.trim();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password Reset'),
            content: const Text(
                'A password reset link has been sent to your email.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Starts your journey with us!',
                    style: TextStyle(color: Color(0xFFBB0163)),
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
                    fillColor: const Color.fromARGB(255, 236, 234, 234),
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
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
                    fillColor: const Color.fromARGB(255, 236, 234, 234),
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
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
                width: MediaQuery.of(context).size.width * .7,
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
                          : Colors.grey,
                    ),
                  ),
                  child: const Text('Login'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Sign up',
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
