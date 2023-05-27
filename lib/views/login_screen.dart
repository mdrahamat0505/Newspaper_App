import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newspaper_app/components/testField.dart';
import 'package:newspaper_app/config/base.dart';
import 'package:newspaper_app/service/internet_connection.dart';
import 'package:newspaper_app/views/home_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> with Base {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                'Enter your email address to sign in!',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    loginC.email.value = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                  )),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    loginC.password.value = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password.')),
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
                          final user = await _auth.signInWithEmailAndPassword(
                              email: loginC.email.value,
                              password: loginC.password.value);
                          if (user != null) {
                            Get.off(() => const HomeScreen());
                            //  push(HomeScreen());
                          } else {
                            Get.snackbar(
                              'Attention!!',
                              'There is no user record corresponding to this identifier. The user may have been deleted.',
                              colorText: Colors.red,
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.white,
                            );
                          }
                        } catch (e) {
                          Get.snackbar(
                            'Attention!!',
                            'Please entered valid username and password!',
                            colorText: Colors.red,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white,
                          );
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
                      'Log In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
