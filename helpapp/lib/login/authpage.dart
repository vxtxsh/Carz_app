import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:helpapp/login/loginsignup.dart";
import "package:helpapp/screens/home.dart";


class authpage extends StatelessWidget {
  const authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return loginsignup();
            }
          }

        },),
         );
  }
}