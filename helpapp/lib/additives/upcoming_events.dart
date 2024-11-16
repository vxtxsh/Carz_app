import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EventModel {
  final int eventId;
  final String name;
  final String date;
  final String startTime;
  final String endTime;
  final VenueModel venue;
  final String description;
  final EventTypeModel type;
  final ContactModel contact;
  final ClubModel club;
  final String? image;

  EventModel({
    required this.eventId,
    required this.name,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.venue,
    required this.description,
    required this.type,
    required this.contact,
    required this.club,
    required this.image,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['eventId'],
      name: json['name'] ?? '',
      date: json['date'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      venue: VenueModel.fromJson(json['venue']),
      description: json['description'] ?? '',
      type: EventTypeModel.fromJson(json['type']),
      contact: ContactModel.fromJson(json['contact']),
      club: ClubModel.fromJson(json['club']),
      image: json['image'],
    );
  }
}

class VenueModel {
  final int venueId;
  final String venueName;

  VenueModel({required this.venueId, required this.venueName});

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      venueId: json['venueId'],
      venueName: json['venueName'],
    );
  }
}

class EventTypeModel {
  final int contactId;
  final String name;
  final String email;
  final String phone;

  EventTypeModel(
      {required this.contactId,
      required this.name,
      required this.email,
      required this.phone});

  factory EventTypeModel.fromJson(Map<String, dynamic> json) {
    return EventTypeModel(
      contactId: json['contactId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class ContactModel {
  final int contactId;
  final String name;
  final String email;
  final String phone;

  ContactModel(
      {required this.contactId,
      required this.name,
      required this.email,
      required this.phone});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      contactId: json['contactId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class ClubModel {
  final int clubId;
  final String clubName;
  final String clubDescription;
  final String clubContact;

  ClubModel(
      {required this.clubId,
      required this.clubName,
      required this.clubDescription,
      required this.clubContact});

  factory ClubModel.fromJson(Map<String, dynamic> json) {
    return ClubModel(
      clubId: json['clubId'],
      clubName: json['clubName'],
      clubDescription: json['clubDescription'],
      clubContact: json['clubContact'],
    );
  }
}

class ApiService {
  final String baseUrl = 'http://192.168.1.6:8080';

  Future<List<EventModel>> fetchEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/events/'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map<EventModel>((event) => EventModel.fromJson(event))
          .toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}

class EventsUpcoming extends StatefulWidget {
  @override
  _EventsUpcomingState createState() => _EventsUpcomingState();
}

class _EventsUpcomingState extends State<EventsUpcoming> {
  bool isUpcomingSelected = true;
  late Future<List<EventModel>> futureEvents;
  List<EventModel> events = [];
  List<EventModel> filteredEvents = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureEvents = ApiService().fetchEvents();
    futureEvents.then((value) {
      setState(() {
        events = value;
        filteredEvents = value;
      });
    });

    searchController.addListener(() {
      filterEvents();
    });
  }

  void filterEvents() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredEvents = events
          .where((event) => event.name.toLowerCase().contains(query))
          .toList();
    });
  }

  List<EventModel> filterUpcomingEvents(List<EventModel> events) {
    final currentDate = DateTime.now();
    return events.where((event) {
      try {
        final eventDate = DateTime.parse(event.date);
        return eventDate.isAfter(currentDate);
      } catch (e) {
        print('Error parsing date for event: ${event.name}');
        return false;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your Cars'),
        backgroundColor: const Color.fromARGB(31, 24, 24, 24),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Cars',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<EventModel>>(
              future: futureEvents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No cars available.'));
                } else {
                  return ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = filteredEvents[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 97, 96, 96),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: event.image != null
                                        ? Image.memory(
                                            base64Decode(event.image!),
                                            height: 125,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/TECHNICAL.png',
                                            height: 125,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                event.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text('Date: ${event.date}'),
                              const SizedBox(height: 5),
                              Text('Description: ${event.description}', style: const TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),),
                              
                              //Text(event.type.name),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
