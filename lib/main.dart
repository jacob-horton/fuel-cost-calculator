import 'package:flutter/material.dart';
import 'package:mileage/components/mileage_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.red),
          Container(
            color: Colors.purple,
            height: 250.0,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 100.0,
            ),
            child: MileageCalculator(),
          ),
        ],
      ),
    );
  }
}
