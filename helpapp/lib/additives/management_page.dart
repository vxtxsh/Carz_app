import 'package:flutter/material.dart';

class AuthorPage extends StatelessWidget {
  const AuthorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle sectionTitleStyle =
        TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
    const TextStyle subsectionTitleStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white70);
    const TextStyle contentStyle =
        TextStyle(fontSize: 16, color: Colors.white70, height: 1.5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Author & App Information'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16.0),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Author Information', style: sectionTitleStyle),
              SizedBox(height: 10),
              Text('Name: Vitesh Balusu', style: contentStyle),
              SizedBox(height: 5),
              Text('Email: nyx4894@gmail.com', style: contentStyle),
              SizedBox(height: 20),
              Text('App Information', style: sectionTitleStyle),
              SizedBox(height: 10),
              Text('Frontend: Dart & Flutter', style: contentStyle),
              SizedBox(height: 5),
              Text('Authentication: Firebase', style: contentStyle),
              SizedBox(height: 5),
              Text('Backend: Spring Framework', style: contentStyle),
              SizedBox(height: 5),
              Text('Database: PostgreSQL', style: contentStyle),
              SizedBox(height: 20),
              Text('Assignment Objective', style: sectionTitleStyle),
              SizedBox(height: 10),
              Text(
                'Build a Car Management Application where users can create, view, edit, and delete cars. Each car can contain up to 10 images (specifically of a car), a title, a description, and tags such as car_type, company, dealer, etc. The application should include user authentication, allow users to manage only their products, and provide search functionality across products.',
                style: contentStyle,
              ),
              SizedBox(height: 20),
              Text('Required Functionalities', style: sectionTitleStyle),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('1. User can login/signup', style: contentStyle),
                  SizedBox(height: 5),
                  Text(
                    '2. Users can add car images, title, description and tags',
                    style: contentStyle,
                  ),
                  SizedBox(height: 5),
                  Text('3. Users can view a list of all their cars.', style: contentStyle),
                  SizedBox(height: 5),
                  Text(
                    '4. Users can perform a global search through all their cars',
                    style: contentStyle,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '5. Users can click on a car to view its detailed information.',
                    style: contentStyle,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Frontend Requirements', style: sectionTitleStyle),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Sign Up / Login Page: Allow users to register and log in to access their products.',
                    style: contentStyle,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '2. Product List Page: Display all cars created by the logged-in user, with a search bar.',
                    style: contentStyle,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '3. Product Creation Page: Form for uploading image, setting a title, and writing a description for a new car.',
                    style: contentStyle,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '4. Product Detail Page: Display a cars details',
                    style: contentStyle,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Technologies Used', style: sectionTitleStyle),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- Frontend: Flutter (Dart)', style: contentStyle),
                  SizedBox(height: 5),
                  Text('- Authentication: Firebase', style: contentStyle),
                  SizedBox(height: 5),
                  Text('- Backend: Spring Framework', style: contentStyle),
                  SizedBox(height: 5),
                  Text('- Database: PostgreSQL', style: contentStyle),
                ],
              ),
              
              
              SizedBox(height: 20),
              Text('Additional Information', style: sectionTitleStyle),
              SizedBox(height: 10),
              Text(
                'This project was developed as an assessment assignment for Spyne SDE Intern position. It demonstrates the ability to build a full-stack application with user authentication, CRUD operations, and search functionality using modern technologies.',
                style: contentStyle,
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey, thickness: 1, indent: 10, endIndent: 10),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
