// Flutter packages
import 'package:flutter/material.dart';

//Css
import 'package:husband/features/shared/css/style_constants.dart';
import 'package:husband/features/shared/tags/tabs.dart';

//Shared Widgets
import 'package:husband/features/shared/header/header.dart';
import 'package:husband/features/shared/header/selection_tool.dart';
import 'package:husband/features/shared/card_tabs/tab.dart';
import 'package:husband/features/shared/sceleton/sceleton.dart';

class DeenTab {
  static SceletonTab build(BuildContext context) {
    return SceletonTab(
      header: Header(
        title: 'Dein Deen',
        emote: '☽',
        subtitle: 'Bismillah',
        icon: Icons.nightlife,
      ),
      upperActions: const DeenContent(),
      mainAction: [],
    );
  }
}

class DeenContent extends StatefulWidget {
  const DeenContent({super.key});

  @override
  State<DeenContent> createState() => _DeenContentState();
}

class _DeenContentState extends State<DeenContent> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['Heute', 'Dhikr', 'Quran', 'Wissen'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        const SizedBox(height: 20),
        DeenBody(selectedCategory: _selectedCategoryIndex),
      ],
    );
  }
}

class DeenBody extends StatelessWidget {
  final int selectedCategory;
  const DeenBody({required this.selectedCategory, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (selectedCategory == 0) ...[
          InputCard(
            title: 'Frage des Tages',
            question: 'Wofür bist du Allah heute Dankbar?',
            backgroundColor: MainColors.emerald.withValues(alpha: 0.05),
            onSave: (input) => print("saved"),
          ),
          CheckupCard(
            title: 'Gebete',
            tasks: ['Fajr', 'Duhr', 'Asr', 'Maghrib', 'Isha'],
            backgroundColor: MainColors.gold.withValues(alpha: 0.5),
            onProgressChanged: (completed, count) => print('checked'),
          ),
          TextCard(
            backgroundColor: MainColors.purple.withValues(alpha: 0.5),
            title: 'Deine Ziele',
            mainText: 'رَبَّنَا هَبْ لَنَا',
            subText: "Unser Herr, schenke uns…",
            reference: 'Surah 25:74',
            tags: [
              TagData(label: "Juma'ah"),
              TagData(label: 'Pflicht-Gebet'),
            ],
          ),
        ] else
          const Text("Andere Kategorien kommen noch..."),
      ],
    );
  }
}
