import 'package:flutter/material.dart';
import 'package:lagi/home_page.dart';
import 'package:lagi/splashcreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // Rute awal
      routes: {
        '/': (context) => const SplashScreen(), // Rute splash screen
        '/homepage': (context) => const HomePage(), // Rute homepage
      },
    );
  }
}
