import 'package:flutter/material.dart';
import 'package:salon_app/pages/dashboard_page.dart';
import 'package:salon_app/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:salon_app/pages/login_page.dart';
import 'package:salon_app/pages/reservation_page.dart';
import 'package:salon_app/pages/signin_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salon App - Project SEA',
      home: const HomePage(),
      routes: {
        '/reservation_page': (context) => const ReservationPage(),
        '/home_page': (context) => const HomePage(),
        '/signin_page': (context) => const SignInPage(),
        '/dashboard_page': (context) => const DashboardPage(),
        '/login_page': (context) => const LoginPage(),
      },
    );
  }
}
