import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final String eventName;
  final Image eventImage;
  final String eventDescription;
  final String eventDate;
  final String eventVenue;
  final String eventTime;

  EventDetailPage({
    required this.eventName,
    required this.eventImage,
    required this.eventDescription,
    required this.eventDate,
    required this.eventVenue,
    required this.eventTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 123, 123, 123),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          eventName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30.0),
            eventImage,
            const SizedBox(height: 40.0),
            
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 18.0,color: Color.fromARGB(255, 212, 211, 211),fontWeight: FontWeight.bold),
                          
                  ),
                ],
              ),
            
            const SizedBox(height: 30.0),
            Text(
              eventDescription,
              style: TextStyle(fontSize: 14.0,color: Color.fromARGB(255, 212, 211, 211)),
                    
            ),
            const SizedBox(height: 20.0),
            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Icon(Icons.calendar_today, color: const Color.fromARGB(255, 255, 255, 255)),
                const SizedBox(width: 10.0),
                Text(
                  eventDate,
                  style: TextStyle(fontSize: 16.0,color: const Color.fromARGB(255, 197, 196, 196)),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            
            const SizedBox(height: 20.0),
            
            const SizedBox(height: 40.0),
            
          ],
        ),
      ),
    );
  }
}
