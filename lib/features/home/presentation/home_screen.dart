// Flutter packages
import 'package:flutter/material.dart';

//Css
import 'package:husband/features/shared/css/style_constants.dart';

//Shared Widgets
import 'package:husband/features/shared/body/sceleton.dart';
import 'package:husband/features/shared/header/header.dart';
import 'package:husband/features/shared/navbar/navbar.dart';

// Own Widgets
import 'package:husband/features/home/widgets/cards.dart';
import 'package:husband/features/home/widgets/quick_actions.dart';
import 'package:husband/features/home/widgets/info_center.dart';
import 'package:husband/features/home/widgets/memories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  var dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Sceleton(
      header: Header(
        title: 'Assalamu ʿalaykum',
        emote: '🌙',
        europeDateTime: dateTime,
        icon: Icons.account_circle,
        actions: null,
      ),
      upperActions: InteractiveCardStack(
        cards: [
          DashboardCard(
            backgroundColor: MainColors.emerald,
            child: CardContent(
              icon: Icons.nightlight_round,
              title: 'Deen - Spiritualität',
              titleColor: Colors.white,
              value: '4 /5 Gebete',
              valueColor: Colors.white,
              comment: '1 Dua ausstehend',
              commentColor: Colors.white70,
              tags: [
                TagData(label: 'Fajr', icon: Icons.check),
                TagData(label: 'Dhuhr', icon: Icons.check),
                TagData(label: 'Asr', icon: Icons.check),
                TagData(label: 'Maghrib', icon: Icons.check),
              ],
            ),
          ),
          DashboardCard(
            backgroundColor: MainColors.gold,
            child: CardContent(
              icon: Icons.attach_money,
              title: 'Finanzen - Haushalt',
              titleColor: Colors.white,
              value: '342 €',
              valueColor: Colors.white,
              comment: 'Budget noch Verfügbar',
              commentColor: Colors.white70,
              tags: [
                TagData(label: 'Einnahmen +€2800'),
                TagData(label: 'Gestern: €450 Ausgaben'),
              ],
            ),
          ),
          DashboardCard(
            backgroundColor: MainColors.purple,
            child: CardContent(
              icon: Icons.local_restaurant_rounded,
              title: 'Dates - Ehe',
              titleColor: Colors.white,
              value: 'Freitag 12.04',
              valueColor: Colors.white,
              comment: 'Erinnerung für Date am Freitag',
              commentColor: Colors.white70,
              tags: [
                TagData(label: 'Nächstes Date'),
                TagData(label: 'Picknick im Park'),
              ],
            ),
          ),
        ],
      ),
      extraActions: QuickActionsSection(
        children: [
          QuickAction(
            backgroundColor: const Color.fromARGB(255, 38, 199, 124),
            icon: Icons.menu_book,
            text: 'Dua hinzufügen',
          ),
          QuickAction(
            backgroundColor: const Color(0xFFE79231),
            icon: Icons.add,
            text: 'Ausgaben hinzufügen',
          ),
          QuickAction(
            backgroundColor: const Color.fromARGB(255, 164, 49, 231),
            icon: Icons.local_restaurant_rounded,
            text: 'Date planen',
          ),
          QuickAction(
            backgroundColor: const Color(0xFFE79231),
            icon: Icons.pie_chart_rounded,
            text: 'Zakat rechnen',
          ),
        ],
      ),
      mainAction: [
        InformationCenter(
          backgroundColor: MainColors.ink,
          icon: Icons.warning_amber_rounded,
          title: 'Erinnerung',
          value: 'Zakat fällig in 3 Tagen',
          comment: 'Berechne deine Zakat rechtzeitig',
        ),
        LastMemoriesSection(
          children: [
            LastMemories(
              icon: Icons.filter_center_focus,
              title: 'Skydiven',
              tag: 'Tag',
              paidMoney: '13€',
              date: DateTime(2017, 1, 1),
            ),
            LastMemories(
              icon: Icons.filter_center_focus,
              title: 'Skydiven 2',
              tag: 'Tag',
              paidMoney: '13€',
              date: DateTime(2017, 2, 1),
            ),
            LastMemories(
              icon: Icons.filter_center_focus,
              title: 'Skydiven 3',
              tag: 'Tag',
              paidMoney: '13€',
              date: DateTime(2017, 3, 1),
            ),
          ],
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
