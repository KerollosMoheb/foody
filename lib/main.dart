import 'package:flutter/material.dart';
import 'package:food_app/features/auth/views/login_view.dart';
import 'package:food_app/features/auth/views/signup_view.dart';
import 'package:food_app/root.dart';
import 'package:food_app/splash_view.dart';

void main() {
  runApp(const Foody());
}

class Foody extends StatelessWidget {
  const Foody({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: Root(),
    );
  }
}
