import 'package:flutter/material.dart';

import 'management_page.dart';
import 'upcoming_events.dart';

class LeftSideIcons extends StatelessWidget {
  const LeftSideIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.school,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AuthorPage()));
              },
            ),
          ],
        ),
        const SizedBox(
          width: 15.0,
        ),
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.car_rental,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EventsUpcoming()));
              },
            )
          ],
        ),
      ],
    );
  }
}
