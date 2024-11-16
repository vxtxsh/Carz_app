import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helpapp/login/authpage.dart';
import 'package:helpapp/login/firebase_options.dart';

import 'models/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const CarRental());
}

class CarRental extends StatelessWidget {
  const CarRental({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car App',
      theme: ThemeData(scaffoldBackgroundColor: kBackgroundColor),
      home: const authpage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
