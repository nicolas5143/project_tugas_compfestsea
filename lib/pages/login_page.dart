import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../util/font_style.dart';
import '../util/pop_up.dart';
import '../util/section.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  var _isObscure;

  final db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  Future<Map<String, dynamic>>? _futureUser;

  @override
  void initState() {
    super.initState();
    _isObscure = true;
  }

  @override
  void dispose() {
    super.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
  }

  Future<Map<String, dynamic>> fetchUserData(String email) async {
    try {
      final querySnapshot = await db
          .collection('Users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data();
      } else {
        throw Exception('No user found');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Login'),
          backgroundColor: Colors.orange[800],
        ),
        body: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(10),
            child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        // for inputting email
                        FormSection(
                          label: 'Email',
                          formField: TextFormField(
                            style: const TextStyle(fontSize: 15, color: Colors.black),
                            controller: controllerEmail,
                            expands: false,
                            decoration: const InputDecoration(
                              hintText: 'Enter your email',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                        ),

                        // for inputting password
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: currentWidth / 2 + 50,
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                                controller: controllerPassword,
                                obscureText: _isObscure,
                                expands: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(top: 12, left: 10, right: 10,),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: _isObscure
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                  ),
                                  hintText: 'Enter your password',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 8) {
                                    return 'Please use minimal 8 characters';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),

                        // button for submitting
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                            WidgetStateProperty.all(Colors.orangeAccent[100]),
                          ),
                          onPressed: () {
                            /*
                            to validate to data, search for the inputted email in db
                            if validated, navigate to dashboard page bringing the userID
                            else show pop up telling the the info is wrong
                             */

                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _futureUser = fetchUserData(controllerEmail.text);
                              });
                            }

                          },
                          child: const ButtonFont(text: 'Login'),
                        ),

                        // Display the FutureBuilder here
                        if (_futureUser != null)
                          FutureBuilder<Map<String, dynamic>>(
                            future: _futureUser,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Center(child: Text('User haven\'t registered. Please sign in.', style: TextStyle(fontSize: 20),)),
                                );
                              } else if (snapshot.hasData) {
                                final user = snapshot.data!;
                                if (user['password'] != controllerPassword.text) {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    showPopUpCustom(
                                        context, false, 'Incorrect password', null, null);
                                  });
                                } else {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    showPopUpCustom(
                                        context, true, 'Login successful', '/dashboard_page', user['userID']);
                                  });
                                }
                                return const SizedBox(height: 0);
                              } else {
                                return const Center(child: Text('No user found'));
                              }
                            },
                          ),
                      ],
                  ),
              )
            ])));
  }
}
