import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Added line
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helpapp/login/square_tile.dart';

class login extends StatefulWidget {
  final void Function()? onPressed;
  const login({super.key, required this.onPressed});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  signInWithEmailAndPassword() async {
    try {
      setState(() {
        isloading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      // Store the username in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid) // Use the UID as the document ID
          .set({'username': _username.text});

      setState(() {
        isloading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isloading = false;
      });
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                child: Text(
                  'Incorrect Email',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                child: Text(
                  'Incorrect Password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(18),
                  child: Form(
                    key: _formKey,
                    child: OverflowBar(
                      overflowSpacing: 18,
                      children: [
                        TextFormField(
                          controller: _username,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Username is empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Username"),
                        ),
                        TextFormField(
                          controller: _email,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Email is empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Email"),
                        ),
                        TextFormField(
                          controller: _password,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Password is empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Password"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  signInWithEmailAndPassword();
                                }
                              },
                              child: isloading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.amber,
                                      ),
                                    )
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        // ... Existing code ...
                      ],
                    ),
                  ),
                ),
                // ... Existing code ...
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SquareTile(imagePath: 'assets/google.png'),
                    SizedBox(width: 25),
                    SquareTile(imagePath: 'assets/apple.png')
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    SizedBox(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Colors.transparent,
                        ),
                        onPressed: widget.onPressed,
                        child: Text(
                          'Signup now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
