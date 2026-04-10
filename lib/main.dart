import 'package:flutter/material.dart';
import 'package:husband/shared/style_constants.dart';
import 'package:husband/features/home/presentation/home_screen.dart';

class HusbandApp extends StatelessWidget {
  const HusbandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Cormorant Garamond',
        scaffoldBackgroundColor: MainColors.surface,
      ),
      home: const HomeScreen(),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // erst danach andere Initialisierungen
  runApp(HusbandApp());
}
