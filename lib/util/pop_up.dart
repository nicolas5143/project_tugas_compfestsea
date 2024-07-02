import 'package:flutter/material.dart';

void showPopUpSubmittedReview(BuildContext context, int rate) {
  String dialog = (rate != 0)
      ? 'Thanks for your review.'
      : 'You haven\'t filled the form.';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.orange[300],
        title: const Text(''),
        content: Text(dialog),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}

void showPopUpSubmittedReservation(BuildContext context, bool isFilled) {
  String dialog = (isFilled)
      ? 'Thank you. Your data is submitted'
      : 'Please filled the form correctly.';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.orange[300],
        title: const Text(''),
        content: Text(dialog),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isFilled) {Navigator.pushNamed(context, '/home_page');}
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}

void showPopUpCustom(BuildContext context, bool isValidated, String text, String? navigateTo, String? argument) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.orange[300],
        title: const Text(''),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isValidated) {Navigator.pushNamed(context, navigateTo!, arguments: argument);}
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}