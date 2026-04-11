// Flutter packages
import 'package:flutter/material.dart';

//Css
import 'package:husband/features/shared/css/style_constants.dart';

//Shared Widgets
import 'package:husband/features/shared/sceleton/sceleton.dart';
import 'package:husband/features/shared/css/style_constants.dart';
import 'package:husband/features/shared/header/header.dart';
import 'package:husband/features/shared/header/selection_tool.dart';
import 'package:husband/features/shared/navbar/navbar.dart';

// In deen_screen.dart
class DeenBody extends StatelessWidget {
  final int selectedCategory;
  const DeenBody({required this.selectedCategory, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // HIER ist das if erlaubt, da es in einer Liste (children) steht
        if (selectedCategory == 0) 
          InteractiveCardStack(cards: deenCards),
        
        const InputCard(
          title: 'Frage des Tages',
          // ... restliche Daten
        ),
      ],
    );
  }
}

class DeenScreen extends StatefulWidget {
  const DeenScreen({super.key});

  @override
  State<DeenScreen> createState() => _DeenScreenState();
}

class _DeenScreenState extends State<DeenScreen> {
  //Selection Tool
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['Heute', 'Dhikr', 'Quran', 'Wissen'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(
          title: 'Dein Deen',
          emote: '☽',
          subtitle: 'Bismillah',
          icon: Icons.nightlife,
        ),
      SelectionTool(
        backgroundColor: MainColors.emerald.withValues(alpha: 0.05),
        selectedColor: MainColors.emerald,
        options: _categories,
        selectedIndex: _selectedCategoryIndex,
        onSelected: (index) {
          setState(() {
            _selectedCategoryIndex = index;
          });
        },

        
      ),
      ],
      ),
    );
  }
}
