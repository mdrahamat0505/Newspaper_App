import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/views/bookmarked_screen.dart';
import 'package:newspaper_app/views/login_screen.dart';

Drawer sideDrawer() {
  final _auth = FirebaseAuth.instance;
  return Drawer(
    // backgroundColor: Colors.black12,
    child: ListView(
      padding: const EdgeInsets.symmetric(vertical: 50),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "Newspaper",
              style: TextStyle(color: Colors.blueAccent, fontSize: 20),
            ),
            SizedBox(height: 20),
          ],
        ),

        Row(
          children: [
            MaterialButton(
              child: const Text(
                "Bookmarked News",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () async {
                //push(BookmarkedScreen());
                Get.to(BookmarkedScreen());
                // Get.offAll(() => const ());
              },
            ),
          ],
        ),
        Row(
          children: [
            MaterialButton(
              child: const Text(
                "SignOut",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () async {
                Get.offAll(() => const LoginScreen());
                _auth.signOut();
              },
            ),
          ],
        ),

        ///ListTile(title: Text("Close"), onTap: () => Get.back()),
      ],
    ),
  );
}
