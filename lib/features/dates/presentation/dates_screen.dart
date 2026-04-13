// Flutter packages
import 'package:flutter/material.dart';

//Css
import 'package:husband/features/shared/css/style_constants.dart';
import 'package:husband/features/shared/tags/tags.dart';

//Shared Widgets
import 'package:husband/features/shared/sceleton/sceleton.dart';
import 'package:husband/features/shared/header/header.dart';
import 'package:husband/features/shared/navbar/selection_tool.dart';

// Tabs
import 'package:husband/features/shared/card_tabs/checkup_tab.dart';
import 'package:husband/features/shared/card_tabs/input_tab.dart';
import 'package:husband/features/shared/card_tabs/add_tab.dart';
import 'package:husband/features/shared/card_tabs/text_tab.dart';

// Puts everything together for the Dates Tab in the main screen.
class DatesTab {
  static SceletonTab build(BuildContext context) {
    return SceletonTab(
      header: Header(
        title: 'Dates & Ehe ',
        emote: '♡',
        subtitle: 'Bismillah',
        icon: Icons.nightlife,
      ),
      upperActions: const DatesContent(),
      mainAction: [],
    );
  }
}

// The content of the Dates Tab, including the category selection and the body that changes based on the selected category.
class DatesContent extends StatefulWidget {
  const DatesContent({super.key});

  @override
  State<DatesContent> createState() => _DatesContentState();
}

class _DatesContentState extends State<DatesContent> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    'Übersicht',
    'Tagebuch',
    'Ideen',
    'DeepTalks',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectionTool(
          backgroundColor: MainColors.purple.withValues(alpha: 0.05),
          selectedColor: MainColors.purple,
          options: _categories,
          selectedIndex: _selectedCategoryIndex,
          onSelected: (index) {
            setState(() {
              _selectedCategoryIndex = index;
            });
          },
        ),
        const SizedBox(height: 20),
        DatesBody(selectedCategory: _selectedCategoryIndex),
      ],
    );
  }
}

// The body of the Dates Tab that changes based on the selected category. For now, only the "Übersicht" category has content.
class DatesBody extends StatelessWidget {
  final int selectedCategory;
  const DatesBody({required this.selectedCategory, super.key});

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
            backgroundColor: MainColors.purple.withValues(alpha: 0.05),
            onSave: (input) => print("saved"),
          ),
          CheckupTab(
            title: 'Gebete',
            tasks: ['Fajr', 'Duhr', 'Asr', 'Maghrib', 'Isha'],
            backgroundColor: MainColors.purple.withValues(alpha: 0.5),
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
            backgroundColor: MainColors.purple.withValues(alpha: 0.05),
          ),
        ] else if (selectedCategory == 2) ...[
          AddTab(
            title: 'Neues Ziel',
            subtitle:
                'Füge einen neuen Ziel hinzu, den du regelmäßig rezitieren möchtest.',
            backgroundColor: MainColors.purple.withValues(alpha: 0.05),
          ),
        ] else if (selectedCategory == 3) ...[
          AddTab(
            title: 'Neue Unterrichtseinheit',
            subtitle:
                'Füge eine neue Unterrichtseinheit hinzu, den du regelmäßig rezitieren möchtest.',
            backgroundColor: MainColors.purple.withValues(alpha: 0.05),
          ),
        ] else
          const Text("Andere Kategorien kommen noch..."),
      ],
    );
  }
}
