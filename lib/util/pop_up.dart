import 'package:flutter/material.dart';

void showPopUpSubmittedReview(BuildContext context, int rate) {
  String dialog = (rate != 0)
      ? 'Terima kasih sudah mengisi.'
      : 'Anda belum mengisi. Silakan diisi.';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.orange[300],
        title: const Text('Perhatian'),
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
      ? 'Terima kasih sudah mengisi. Data Anda akan diproses'
      : 'Anda belum mengisi dengan lengkap. Silakan diisi.';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.orange[300],
        title: const Text('Perhatian'),
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
