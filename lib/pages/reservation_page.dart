import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/util/section.dart';
import '../util/font_style.dart';
import '../util/pop_up.dart';
import '../util/var.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final controllerEmailForm = TextEditingController();
  final controllerDatePicker = TextEditingController();

  String? selectedService = services[0];
  String? selectedTime = '09:00:00';

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void dispose() {
    controllerEmailForm.dispose();
    controllerDatePicker.dispose();
    super.dispose();
  }

  Future<String>? _futureUserID;

  Future<String> fetchUserID(String email) async {
    try {
      final user = await db.collection('Users').where('email', isEqualTo: email).get().then((querySnapshot) => querySnapshot.docs[0].data());
      return user['userID'];
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
        title: const Text('Reservation Form'),
        backgroundColor: Colors.orange[800],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: currentWidth / 2 + 100,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // form for inputting user's email
                  FormSection(
                    label: 'Email',
                    formField: TextFormField(
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                      controller: controllerEmailForm,
                      expands: false,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  // type of service
                  DropDownServices(selectedService: (String? newValue) {
                    setState(() {
                      selectedService = newValue!;
                    });
                  },),

                  // form for booking date and time
                  ReservedDateTime(controllerDate: controllerDatePicker, selectedTime: (String? newValue) {
                    setState(() {
                      print(newValue);
                      selectedTime = newValue!;
                    });
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),

              // button to submit to database
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.orangeAccent[100]),
                ),
                onPressed: () {
                  String email = controllerEmailForm.text;
                  String dateTime = controllerDatePicker.text;
                  if (email != '' &&  dateTime != '') {

                    // getting user's id
                      setState(() {
                        _futureUserID = fetchUserID(email);
                      });

                  } else {

                    // the data inputted isnt validated
                    showPopUpSubmittedReservation(context, false);
                  }
                },
                child: const ButtonFont(text: 'Submit',),
              ),

              // Display the FutureBuilder here
              if (_futureUserID != null)
                FutureBuilder<String>(
                  future: _futureUserID,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final userID = snapshot.data!;

                      final dataReserved = <String, dynamic> {
                        'service': selectedService,
                        'date': DateTime.parse('${controllerDatePicker.text} $selectedTime'),
                      };

                      db.collection('Users').doc(userID).collection('Services').add(dataReserved);
                      controllerDatePicker.clear();
                      controllerEmailForm.clear();

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showPopUpCustom(
                          context,
                          true,
                          'You\'ve successfully reserved a service',
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

            ]),
          ),
        ),
      ),
    );
  }
}
