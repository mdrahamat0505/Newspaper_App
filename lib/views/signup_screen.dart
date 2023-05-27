import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newspaper_app/components/testField.dart';
import 'package:newspaper_app/config/base.dart';
import 'package:newspaper_app/service/internet_connection.dart';
import 'package:newspaper_app/views/home_screen.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Base {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  signupC.email.value = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email')),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  signupC.password.value = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Password')),
            const SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () async {
                    final connectivityResult =
                        await InternetConnection.isConnectedToInternet();
                    if (connectivityResult) {
                      setState(() {
                        loginC.showSpinner.value = true;
                      });

                      try {
                        if ((signupC.password.value.length >= 6 &&
                                signupC.password.value != null) &&
                            (signupC.email.value.length >= 2 &&
                                signupC.email.value.contains('@') &&
                                signupC.email.value.endsWith('.com'))) {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: signupC.email.value,
                                  password: signupC.password.value);
                          if (newUser != null) {
                            Get.offAll(() => const HomeScreen());
                          }
                        } else {
                          Get.snackbar(
                            'Attention!!',
                            'Email adddress and Password less then 6 caracter',
                            colorText: Colors.red,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white,
                          );
                        }
                      } catch (e) {
                        Get.snackbar(
                          'Attention!!',
                          'Please entered email address and Password less then 6',
                          colorText: Colors.red,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                        );
                        log('$e');
                      }
                      setState(() {
                        loginC.showSpinner.value = false;
                      });
                    } else {
                      Get.snackbar(
                        'Attention!!',
                        'Please check your internet connection.',
                        colorText: Colors.red,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.white,
                      );
                    }
                  },
                  //Go to login screen.
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
