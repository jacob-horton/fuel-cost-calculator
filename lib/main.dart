import 'package:flutter/material.dart';
import 'package:fuel_cost_calculator/arc_clipper.dart';
import 'package:fuel_cost_calculator/components/mileage_calculator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Cost Calculator',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: OrientationBuilder(builder: (context, orientation) {
          return Stack(
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
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: orientation == Orientation.portrait
                                ? 50.0
                                : 0.0),
                        child: const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Fuel Cost Calculator",
                            style: TextStyle(
                              fontSize: 28.0,
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
              Padding(
                padding: EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    top: orientation == Orientation.portrait ? 150.0 : 50.0),
                child: const MileageCalculator(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
