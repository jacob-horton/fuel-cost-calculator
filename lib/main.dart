import 'package:flutter/material.dart';
import 'package:mileage/arc_clipper.dart';
import 'package:mileage/components/mileage_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mileage',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      supportedLocales: const [
        Locale('en'),
        Locale('en', 'GB'),
        Locale('en', 'US'),
        Locale('es'),
        Locale('fr'),
        Locale('de'),
        Locale('it'),
        Locale('pt'),
        Locale('ru'),
        Locale('ja'),
        Locale('zh'),
        Locale('zh', 'HK'),
        Locale('zh', 'TW'),
      ],
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
          Container(color: const Color(0xFFEEEDF3)),
          Positioned(
            left: 0.0,
            right: 0.0,
            child: ClipPath(
              clipper: CurvedBottomClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFC2A6F1), Color(0xFF946ED5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                height: 300.0,
                child: const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Fuel Cost Calculator",
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: MileageCalculator(),
          ),
        ],
      ),
    );
  }
}
