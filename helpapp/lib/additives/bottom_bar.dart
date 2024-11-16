import 'package:flutter/material.dart';

import 'left_bar.dart';
import 'right_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0), 
        child: Container(
          color: Color.fromARGB(255, 15, 13, 28),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          height: size.height * .08,
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                LeftSideIcons(),
                RightSideIcons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
