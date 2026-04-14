// FLutter imports
import 'package:flutter/material.dart';

// Css
import 'package:husband/features/shared/css/style_constants.dart';

// Features
import 'package:husband/features/shared/sceleton/sceleton.dart';
import 'package:husband/features/shared/navbar/navbar.dart';

//Tabs
import 'package:husband/features/home/presentation/home_screen.dart';
import 'package:husband/features/deen/presentation/deen_screen.dart';
import 'package:husband/features/finances/presentation/finance_screen.dart';
import 'package:husband/features/dates/presentation/dates_screen.dart';

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
          DeenTab.build(context),
          FinanceTab.build(context),
          DatesTab.build(context),
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
