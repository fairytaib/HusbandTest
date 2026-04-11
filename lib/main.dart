import 'package:flutter/material.dart';
import 'package:husband/features/shared/css/style_constants.dart';
import 'package:husband/features/home/presentation/home_screen.dart';
import 'package:husband/features/shared/navbar/navbar.dart';

import 'package:husband/features/shared/sceleton/sceleton.dart';

class HusbandApp extends StatelessWidget {
  const HusbandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Cormorant Garamond',
        scaffoldBackgroundColor: MainColors.daymode,
      ),
      home: Sceleton(
        tabs: [
          HomeTab.build(context),
        ],
        bottomNavigationBarBuilder: (index, onTap) =>
            CustomNavbar(currentIndex: index, onTap: onTap),
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(HusbandApp());
}
