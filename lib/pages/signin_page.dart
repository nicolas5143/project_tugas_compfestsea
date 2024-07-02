import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/util/font_style.dart';
import 'package:salon_app/util/pop_up.dart';
import '../util/section.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final controllerEmail = TextEditingController();
  final controllerName = TextEditingController();
  final controllerPhoneNum = TextEditingController();
  final controllerPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final db = FirebaseFirestore.instance;

  var _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = true;
  }

  @override
  void dispose() {
    super.dispose();
    controllerEmail.dispose();
    controllerName.dispose();
    controllerPhoneNum.dispose();
    controllerPassword.dispose();
  }

  Future<int>? _futureUserCount;

  Future<int> fetchUserCount() async {
    try {
      final userCount = await db.collection('Users').count().get().then((res) => res.count);
      return userCount!;
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
        title: const Text('Sign In'),
        backgroundColor: Colors.orange[800],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [

                    // for inputting name
                    FormSection(
                      label: 'Name',
                      formField: TextFormField(
                        style: const TextStyle(fontSize: 15, color: Colors.black),
                        controller: controllerName,
                        expands: false,
                        decoration: const InputDecoration(
                          hintText: 'Enter your name',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),

                    // for inputting phone number
                    FormSection(
                      label: 'Phone Number',
                      formField: TextFormField(
                        style: const TextStyle(fontSize: 15, color: Colors.black),
                        controller: controllerPhoneNum,
                        expands: false,
                        decoration: const InputDecoration(
                          hintText: 'Enter your phone number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),

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
                          if (!value.contains('@')) {
                            return 'Please use the correct email';
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

                    // button for submitting the form
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.orangeAccent[100]),
                      ),
                      onPressed: () {
                        // validate the form and navigate to dashboard

                          /*
                        process the name to get the userID
                        count the user from db using count()
                        navigate to the dashboard page bringing the userID
                         */

                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _futureUserCount = fetchUserCount();
                          });
                        }
                      },
                      child: const ButtonFont(text: 'Sign In'),
                    ),

                      // Display the FutureBuilder here
                      if (_futureUserCount != null)
                        FutureBuilder<int>(
                          future: _futureUserCount,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              final userCount = snapshot.data!;
                              String userID = controllerName.text.split(' ')[0].toLowerCase();
                              String userCountStr = (userCount+1).toString();

                              if (userCount < 1000) {
                                for (int i = 0; i < (3 - userCountStr.length); i++) {
                                  userID += '0';
                                }
                              }
                              userID += userCountStr;

                              final userData = <String, dynamic> {
                                'email': controllerEmail.text,
                                'fullName': controllerName.text,
                                'password': controllerPassword.text,
                                'phoneNumber': controllerPhoneNum.text,
                                'userID': userID,
                              };

                              db.collection('Users').doc(userID).set(userData);

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                showPopUpCustom(
                                  context,
                                  true,
                                  'You\'ve successfully registered',
                                  '/dashboard_page',
                                  userID,
                                );
                              });

                              return const SizedBox(height: 0);
                            } else {
                              return const Center(child: Text('error'));
                            }
                          },
                        ),
                  ],
                ),)
              ],
            )),
      ),
    );
  }
}
