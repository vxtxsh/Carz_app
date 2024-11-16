import 'package:flutter/material.dart';
import 'package:helpapp/screens/home.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert'; // Import for base64Encode
import 'package:http/http.dart' as http;

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

enum VenueType {
  hall1,
  hall2,
  itblock,
  aiml,
  block,
  cseblock,
  ground,
  busparking,
  bikeparking,
  carparking,
  pharmacy,
  lailawati
}

extension VenueTypeExtension on VenueType {
  String get name {
    switch (this) {
      case VenueType.hall1:
        return 'Hyundai';
      case VenueType.hall2:
        return 'Toyota';
      case VenueType.itblock:
        return 'Maruthi';
      case VenueType.aiml:
        return 'Tata';
      case VenueType.cseblock:
        return 'Mahindra';
      case VenueType.ground:
        return 'Honda';
      case VenueType.busparking:
        return 'Kia';
      case VenueType.bikeparking:
        return 'Nissan';
      case VenueType.carparking:
        return 'Mercedes';
      case VenueType.pharmacy:
        return 'Ferrari';
      case VenueType.lailawati:
        return 'BMW';
      default:
        return 'others';
    }
  }
}

enum EventType { technical, nonTechnical, technicalandnontechnical, cultural }

extension EventTypeExtension on EventType {
  String get type {
    switch (this) {
      case EventType.technical:
        return 'Family';
      case EventType.nonTechnical:
        return 'Luxury';
      case EventType.cultural:
        return 'Jeep';
      case EventType.technicalandnontechnical:
        return 'Sports';
      default:
        return 'Other';
    }
  }
}

class _CreateEventPageState extends State<CreateEventPage> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Widget? _selectedMediaWidget;
  EventType _selectedEventType = EventType.technical;
  VenueType _selectedVenueType = VenueType.hall1;

  Future<void> _submitEvent() async {
    final url = Uri.parse('http://192.168.1.6:8080/events/create');

    String? base64Image;
    if (_selectedMediaWidget != null) {
      final file = (_selectedMediaWidget as Image).image;
      final fileImage = file as FileImage;
      final imageFile = File(fileImage.file.path);
      base64Image = base64Encode(await imageFile.readAsBytes());
    }

    final eventData = {
      'eventId': 0,
      'name': _eventNameController.text,
      'date': _eventDateController.text,
      'startTime': _timeController.text,
      'endTime': _timeController.text,
      'venue': {'venueId': 0, 'venueName': _selectedVenueType.name},
      'description': _descriptionController.text,
      'type': {
        'typeId': 0,
        'name': _selectedEventType.type,
        'email': "string",
        'phone': "string"
      },
      'contact': {
        'contactId': 1,
        'name': "string",
        'email': "string",
        'phone': "string"
      },
      'clubId': 1,
      'image': base64Image // Add base64 image data here
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(eventData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Event created successfully');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        print('Failed to create event. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error creating event: $error');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _selectedMediaWidget = Image.file(File(pickedImage.path));
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101), 
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _eventDateController.text = DateFormat.yMd().format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 43, 43),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add  Car',
            style: TextStyle(color: Color.fromARGB(255, 232, 230, 230), fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 6, 6, 6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                        TextField(
              controller: _eventNameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Car Name',
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _eventDateController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Date',
                hintStyle: const TextStyle(color: Colors.white54),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            DropdownButton<VenueType>(
              value: _selectedVenueType,
              dropdownColor: Colors.black,
              onChanged: (VenueType? value) {
                if (value != null) setState(() => _selectedVenueType = value);
              },
              items: VenueType.values.map((VenueType venueType) {
                return DropdownMenuItem<VenueType>(
                  value: venueType,
                  child: Text(venueType.name,
                      style: const TextStyle(color: Colors.white)),
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _timeController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Dealer ID',
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _descriptionController,
              maxLines: null,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
            const SizedBox(height: 10.0),
            DropdownButton<EventType>(
              value: _selectedEventType,
              dropdownColor: Colors.black,
              onChanged: (EventType? value) {
                if (value != null) setState(() => _selectedEventType = value);
              },
              items: EventType.values.map((EventType eventType) {
                return DropdownMenuItem<EventType>(
                  value: eventType,
                  child: Text(eventType.type,
                      style: const TextStyle(color: Colors.white)),
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Upload Media',
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
            const SizedBox(height: 20.0),
            _selectedMediaWidget ?? Container(),
            const SizedBox(height: 20.0),
            Container(
              height: 60.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitEvent,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 40, 81, 42)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 15.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

