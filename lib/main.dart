import 'package:animeverse/screens/signup_screen.dart';
import 'package:animeverse/screens/signin_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimeVerse',
      theme: ThemeData(fontFamily: 'Urbanist'),
      home: const SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
