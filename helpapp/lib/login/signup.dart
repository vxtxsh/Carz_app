
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Added line

class signup extends StatefulWidget {
  final Function()? onPressed;
  const signup({super.key,required this.onPressed});

  @override
  State<signup> createState() => _SignupState();
}

class _SignupState extends State<signup> {
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController(); // Added line

  createUserWithEmailAndPassword() async {
    try {
      setState(() {
        isloading = true;
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The password provided is too weak."),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The account already exists for that email."),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isloading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(18),
            child: Form(
              key: _formKey,
              child: OverflowBar(
                overflowSpacing: 18,
                children: [
                  const SizedBox(height: 100),
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
                            createUserWithEmailAndPassword();
                          }
                        },
                        child: isloading
                            ? Center(child: CircularProgressIndicator(color: Colors.amber,))
                            : Text("SignUp", style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255))),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 100,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: widget.onPressed,
                        child: Text("Back"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
