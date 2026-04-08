import 'package:flutter/material.dart';
import 'package:husband/shared/style_constants.dart';
import 'package:husband/features/home/home_screen.dart';

class HusbandApp extends StatelessWidget {
  const HusbandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: const HomeScreen(),
      theme: ThemeData(
        fontFamily: 'Cormorant Garamond',
        scaffoldBackgroundColor: MainColors.surface,
      ),
    );
  }
}


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // erst danach andere Initialisierungen
  runApp(HusbandApp());
}