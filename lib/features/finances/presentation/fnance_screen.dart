// Flutter packages
import 'package:flutter/material.dart';

//Css
import 'package:husband/features/shared/css/style_constants.dart';
import 'package:husband/features/shared/tags/tabs.dart';

//Shared Widgets
import 'package:husband/features/shared/sceleton/sceleton.dart';
import 'package:husband/features/shared/header/header.dart';
import 'package:husband/features/shared/navbar/selection_tool.dart';

// Tabs
import 'package:husband/features/shared/card_tabs/checkup_tab.dart';
import 'package:husband/features/shared/card_tabs/input_tab.dart';
import 'package:husband/features/shared/card_tabs/add_tab.dart';
import 'package:husband/features/shared/card_tabs/text_tab.dart';


class FinanceTab {
  static SceletonTab build(BuildContext context) {
    return SceletonTab(
      header: Header(
        title: 'Finanzen',
        emote: '💰',
        subtitle: 'Bismillah',
        icon: Icons.account_balance,
      ),
      upperActions: const FinanceContent(),
      mainAction: [],
    );
  }
}

class FinanceContent extends StatefulWidget {
  const FinanceContent({super.key});

  @override
  State<FinanceContent> createState() => _FinanceContentState();
}

class _FinanceContentState extends State<FinanceContent> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['Übersicht', 'Einträge', 'Zakat', 'Kategorien'];

    @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectionTool(
          backgroundColor: MainColors.gold.withValues(alpha: 0.05),
          selectedColor: MainColors.gold,
          options: _categories,
          selectedIndex: _selectedCategoryIndex,
          onSelected: (index) {
            setState(() {
              _selectedCategoryIndex = index;
            });
          },
        ),
        const SizedBox(height: 20),
        FinanceBody(selectedCategory: _selectedCategoryIndex),
      ],
    );
  }
}


// The body of the Finance Tab that changes based on the selected category. For now, only the "Übersicht" category has content.
class FinanceBody extends StatelessWidget {
  final int selectedCategory;
  const FinanceBody({required this.selectedCategory, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        if (selectedCategory == 0) ...[
          InputTab(
            title: 'Frage des Tages',
            question: 'Wofür bist du Allah heute Dankbar?',
            backgroundColor: MainColors.emerald.withValues(alpha: 0.05),
            onSave: (input) => print("saved"),
          ),
          CheckupTab(
            title: 'Gebete',
            tasks: ['Fajr', 'Duhr', 'Asr', 'Maghrib', 'Isha'],
            backgroundColor: MainColors.gold.withValues(alpha: 0.5),
            onProgressChanged: (completed, count) => print('checked'),
          ),
          TextTab(
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
        ] else if (selectedCategory == 1) ...[
          AddTab(
            title: 'Neuer Dhikr',
            subtitle:
                'Füge einen neuen Dhikr hinzu, den du regelmäßig rezitieren möchtest.',
            backgroundColor: MainColors.emerald.withValues(alpha: 0.05),
          ),
        ] else if (selectedCategory == 2) ...[
          AddTab(
            title: 'Neues Ziel',
            subtitle:
                'Füge einen neuen Ziel hinzu, den du regelmäßig rezitieren möchtest.',
            backgroundColor: MainColors.emerald.withValues(alpha: 0.05),
          ),
        ] else if (selectedCategory == 3) ...[
          AddTab(
            title: 'Neue Unterrichtseinheit',
            subtitle:
                'Füge eine neue Unterrichtseinheit hinzu, den du regelmäßig rezitieren möchtest.',
            backgroundColor: MainColors.emerald.withValues(alpha: 0.05),
          ),
        ] else
          const Text("Andere Kategorien kommen noch..."),
      ],
    );
  }
}
