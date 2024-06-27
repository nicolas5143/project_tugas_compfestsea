import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/util/section.dart';
import '../util/pop_up.dart';
import '../util/var.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final controllerNameForm = TextEditingController();
  final controllerPhoneNumForm = TextEditingController();
  final controllerDatePicker = TextEditingController();

  String? selectedService = services[0];
  String? selectedTime = '9:00:00';

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void dispose() {
    controllerNameForm.dispose();
    controllerPhoneNumForm.dispose();
    controllerDatePicker.dispose();
    super.dispose();
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
                  // form for inputting user's name
                  FormSection(
                      text: 'Name',
                      hintText: 'Enter your name',
                      controller: controllerNameForm),
                  // form for inputting user's phone number
                  FormSection(
                      text: 'Active Phone Number',
                      hintText: 'Enter your phone number',
                      controller: controllerPhoneNumForm),
                  // type of service
                  DropDownServices(selectedService: (String? newValue) {
                    setState(() {
                      selectedService = newValue!;
                    });
                  },),
                  // form for booking date and time
                  ReservedDateTime(controllerDate: controllerDatePicker, selectedTime: (String? newValue) {
                    setState(() {
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
                  String name = controllerNameForm.text;
                  String phoneNumber = controllerPhoneNumForm.text;
                  String dateTime = controllerDatePicker.text;
                  if (name != '' && phoneNumber != '' && dateTime != '') {
                    showPopUpSubmittedReservation(context, true);
                    final dataReview = <String, dynamic> {
                      'name': name,
                      'phoneNumber': phoneNumber,
                      'service': selectedService,
                      'date': DateTime.parse('$dateTime $selectedTime'),
                    };
                    db.collection('Reservations').doc(name).set(dataReview);
                    controllerDatePicker.clear();
                    controllerPhoneNumForm.clear();
                    controllerNameForm.clear();
                  } else {
                    showPopUpSubmittedReservation(context, false);
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
