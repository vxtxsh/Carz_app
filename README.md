# Car Management Application

## Objective

The **Car Management Application** is designed to help users manage their car-related information, including creating, viewing, editing, and deleting cars. Each car can contain up to 10 images, a title, a description, and tags (e.g., car_type, company, dealer). The application includes user authentication, allows users to see latest news on car, allows users to manage only their products, and provides search functionality across products.

## Technologies Used

- **Frontend:** Dart & Flutter
- **Authentication:** Firebase
- **Backend:** Spring Framework
- **Database:** PostgreSQL

## Features

- User login/signup with Firebase authentication
- Create, view cars
- Each car can contains images,title, description and tags (car type, company, dealer)
- Global search across car details
- API support for CRUD operations on car data

## APIs

- **Create User** (Users)
- **Create Car** (Add Event)
- **List Cars**  
- **Get Particular Car**
- **News API to fetch news**

### API Documentation

The API documentation for the Car Management Application is available as JSON file above and at the following link:

http://localhost:8080/swagger-ui/index.html

## Setup and Installation

### Prerequisites

Before you begin ensure you have the following installed on your system:

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Firebase**: [Firebase Setup Guide](https://firebase.google.com/docs/flutter/setup)
- **Spring Boot**: [Spring Boot Setup Guide](https://spring.io/guides/gs/spring-boot/)
- **PostgreSQL**: [PostgreSQL Setup Guide](https://www.postgresql.org/download/)

### Frontend Setup

1. **Clone the repository**:

    

2. **Navigate to the project directory**:

    

3. **Install Flutter dependencies**:

    ```bash
    flutter pub get
    ```

4. **Configure Firebase**:
    - Go to Firebase console and create a new project.
    - Download the `google-services.json` for Android and add it to the `android/app` directory of your Flutter project.

5. **Run the Flutter app**:

    ```bash
    flutter run
    ```

    This will launch the app on an emulator or a connected device.

### Backend Setup

1. **Clone the backend repository**:

    

2. **Navigate to the backend directory**:

    

3. **Set up PostgreSQL**:
    - Install PostgreSQL on your system.
    - Create a new database for the app.

    Update the  `application.yml` in the Spring Boot project with your PostgreSQL database credentials:

    ```properties
    spring.datasource.url=jdbc:postgresql://localhost:5432/your_database_name
    spring.datasource.username=your_username
    spring.datasource.password=your_password
    spring.jpa.hibernate.ddl-auto=update
    ```

4. **Build and run the backend**:

    ```bash
    mvn spring-boot:run
    ```

    This will start the backend service on `http://localhost:8080`.

## Screenshots
<div style="display: flex; justify-content: center;align-items: center;">
    <img src="https://github.com/user-attachments/assets/05310147-d232-45e2-a85a-e5848557a70b" alt="Image 2" width="200" style="padding-right: 200px;" />
  <img src="https://github.com/user-attachments/assets/66afd2e9-3f24-43ee-83bd-e1636c306b37" alt="Image 2" width="200" style="padding-right: 200px;" />
  <img src="https://github.com/user-attachments/assets/18443003-404d-410e-82f6-ff1c76ac2990" alt="Image 2" width="200" style="padding-right: 200px;" />
  <img src="https://github.com/user-attachments/assets/76f76aee-62d6-4735-b364-fdd9a80d833a" alt="Image 2" width="200" style="padding-right: 200px;" />
  <img src="https://github.com/user-attachments/assets/94888661-5c51-4cd6-b8e4-7887d4efb351" alt="Image 2" width="200" style="padding-right: 200px;" />
  <img src="https://github.com/user-attachments/assets/61b198c8-f621-4bfb-a345-34bfaed1eb16" alt="Image 2" width="200" style="padding-right: 200px;" />
  <img src="https://github.com/user-attachments/assets/b5beb8fa-f0c4-471d-9edf-888ab74a7184" alt="Image 2" width="200" style="padding-right: 200px;" />
  <img src="https://github.com/user-attachments/assets/d2478e81-1f72-41a1-9b4d-276f8e494652" alt="Image 2" width="550" style="padding-right: 200px;" />
  <img src="https://github.com/user-attachments/assets/25f7a845-770c-4e5b-aa70-528396939da7" alt="Image 2" width="550" style="padding-right: 200px;" />
  <img src="https://github.com/user-attachments/assets/77891a1b-6fab-4f1f-bfcf-e101fe342cba" alt="Image 2" width="550" style="padding-right: 200px;" />
   
</div>


## Contact

- **Author:** Vitesh Balusu
- **Email:** nyx4894@gmail.com
