import 'package:flutter/material.dart';
import 'package:food_app/features/orderHistory/views/order_history_view.dart';
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
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Root(),
    );
  }
}
