// Flutter packages
import 'package:flutter/material.dart';
import 'package:husband/features/shared/card_tabs/goal_tab.dart';

//Css
import 'package:husband/features/shared/css/style_constants.dart';
import 'package:husband/features/shared/tags/tags.dart';

//Shared Widgets
import 'package:husband/features/shared/sceleton/sceleton.dart';
import 'package:husband/features/shared/header/header.dart';
import 'package:husband/features/shared/navbar/selection_tool.dart';

// Tabs
import 'package:husband/features/shared/card_tabs/add_tab.dart';
import 'package:husband/features/shared/card_tabs/text_tab.dart';
import 'package:husband/features/shared/card_tabs/finance_overview_tab.dart';

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
  final List<String> _categories = [
    'Übersicht',
    'Einträge',
    'Zakat',
    'Kategorien',
  ];

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
          GoalTab(
            title: 'Aktuelles Budget',
            mainValue: '333€',
            subtitle: 'von X monatlichen Budget',
            backgroundColor: MainColors.gold,
          ),
          TextTab(
            backgroundColor: MainColors.purple.withValues(alpha: 0.5),
            title: 'Einnahmen',
            mainText: '€ 2000',
            subText: "diesen Monat",
            tags: [TagData(label: "Gehalt")],
          ),
        ] else if (selectedCategory == 1) ...[
          AddTab(
            title: 'Neuer Ausgabe/Einnahme',
            subtitle: 'Füge einen neuen Transaktion hinzu.',
            backgroundColor: MainColors.emerald.withValues(alpha: 0.05),
          ),
        ] else if (selectedCategory == 2) ...[
          TextTab(
            backgroundColor: MainColors.purple.withValues(alpha: 0.5),
            title: 'Zakat',
            mainText: '€ 175',
            subText: "2.5% von 7000€ Vermögen",
            tags: [TagData(label: "Nisab erreicht")],
          ),
        ] else if (selectedCategory == 3) ...[
          FinanceOverviewTab(
            backgroundColor: MainColors.ink,
            percentage: 0.65, // Der Ring füllt sich zu 65%
            incomeValue: '+ 3.450 €',
            expenseValue: '- 1.200 €',
            zakatValue: '86,25 €',
          ),
          TextTab(
            backgroundColor: MainColors.purple.withValues(alpha: 0.5),
            title: 'Analyse',
            mainText: 'Muss noch grafik-tab erstellen',
            subText: "Bla bla",
            tags: [TagData(label: "Nisab erreicht")],
          ),
        ] else
          const Text("Andere Kategorien kommen noch..."),
      ],
    );
  }
}
