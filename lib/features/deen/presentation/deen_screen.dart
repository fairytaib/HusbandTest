// Flutter packages
import 'package:flutter/material.dart';

//Css
import 'package:husband/features/shared/css/style_constants.dart';

//Shared Widgets
import 'package:husband/features/shared/sceleton/sceleton.dart';
import 'package:husband/features/shared/css/style_constants.dart';
import 'package:husband/features/shared/header/header.dart';
import 'package:husband/features/shared/header/selection_tool.dart';
import 'package:husband/features/shared/card_tabs/input_tab.dart';
import 'package:husband/features/shared/navbar/navbar.dart';

class DeenScreen extends StatefulWidget {
  const DeenScreen({super.key});

  @override
  State<DeenScreen> createState() => _DeenScreenState();
}

class _DeenScreenState extends State<DeenScreen> {
  //Selection Tool
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['Heute', 'Dhikr', 'Quran', 'Wissen'];

  //Navigation Bar
  int _selectedTab = 1;

  @override
  Widget build(BuildContext context) {
    return Sceleton(
      header: Header(
        title: 'Dein Deen',
        emote: '☽',
        subtitle: 'Bismillah',
        icon: Icons.nightlife,
      ),

      upperActions: SelectionTool(
        backgroundColor: MainColors.emerald.withValues(alpha: 0.05),
        selectedColor: MainColors.emerald,
        options: _categories,
        selectedIndex: _selectedCategoryIndex,
        onSelected: (index) {
          setState(() {
            _selectedCategoryIndex = index;
          });
        },

        // if (_selectedCategoryIndex == 0)
        // InteractiveCardStack(cards: deenCards)
      ),
      mainAction: [
        InputCard(
          title: 'Frage des Tages',
          question: 'Wofür bist du heute besonders dankbar?',
          icon: Icons.auto_awesome,
          backgroundColor: MainColors.emerald,
          onSave: (text) {
            print("User hat gespeichert: $text");
          },
        ),
      ],
      bottomNavigationBar: CustomNavbar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
      ),
    );
  }
}
