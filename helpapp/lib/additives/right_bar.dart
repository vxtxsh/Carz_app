import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'profile.dart';

class RightSideIcons extends StatelessWidget {
  const RightSideIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 15.0,
        ),
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileSettingScreen()));
              },
            )
          ],
        ),
        const SizedBox(
          width: 15.0,
        ),
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: ()async {
                await FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
      ],
    );
  }
}
