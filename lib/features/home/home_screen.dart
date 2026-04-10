import 'package:flutter/material.dart';
import 'package:husband/shared/style_constants.dart';
import 'package:husband/features/navbar/navbar.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Assalamu ʿalaykum 🌙',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 24,
                    color: MainColors.ink,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Current Date.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: MainColors.lightInk,
                  ),
                ),
              ],
            ),
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: MainColors.ink,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.account_circle, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}

class TagData {
  final String label;
  final IconData? icon; // Optionales Icon
  TagData({required this.label, this.icon});
}

class CardContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color titleColor;
  final String value;
  final Color valueColor;
  final String comment;
  final Color commentColor;
  final List<TagData> tags;

  const CardContent({
    super.key,
    required this.icon,
    required this.title,
    required this.titleColor,
    required this.value,
    required this.valueColor,
    required this.comment,
    required this.commentColor,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 32, color: const Color.fromARGB(185, 255, 255, 255)),
          Spacer(),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                value.split(" ")[0],
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 18,
                  color: valueColor,
                ),
              ),
              Text(
                value.contains('/') ? '/ ${value.split('/')[1]}' : '',
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  fontSize: 12,
                  color: valueColor,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            comment,
            style: TextStyle(
              fontFamily: 'Cormorant Garamond',
              fontSize: 12,
              color: commentColor,
            ),
          ),
          Spacer(),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: tags.map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tag.label,
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    if (tag.icon != null) ...[
                      Icon(tag.icon, size: 12, color: Colors.white),
                      SizedBox(width: 4),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  const Card({super.key, required this.child, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

class InteractiveCardStack extends StatefulWidget {
  final List<Widget> cards;
  const InteractiveCardStack({super.key, required this.cards});

  @override
  State<InteractiveCardStack> createState() => _InteractiveCardStackState();
}

class _InteractiveCardStackState extends State<InteractiveCardStack> {
  int _currentIndex = 0;

  void _showNextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.cards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    int stackPosition = _currentIndex + 1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Übersicht',
          style: TextStyle(
            fontFamily: 'Cormorant Garamond',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: MainColors.lightInk,
          ),
        ),
        GestureDetector(
          onTap: _showNextCard,
          child: SizedBox(
            height: 250,
            width: double.infinity,
            child: Stack(
              children: widget.cards
                  .asMap()
                  .entries
                  .map((entry) {
                    int index = entry.key;
                    int position =
                        (index - _currentIndex + widget.cards.length) %
                        widget.cards.length;

                    double top = position * 15;
                    double horizontalInset = position * 10;
                    double opacity = 1.0 - (position * 3);

                    return AnimatedPositioned(
                      key: ValueKey(
                        index,
                      ), // WICHTIG: Damit Flutter die Karte wiederkennt
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutBack,
                      top: top,
                      left: horizontalInset,
                      right: horizontalInset,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: opacity,
                        child: entry.value,
                      ),
                    );
                  })
                  .toList()
                  .reversed
                  .toList(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              stackPosition.toString(),
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 12,
                color: MainColors.lightInk,
              ),
            ),
            Text(
              ' / ${widget.cards.length}',
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 12,
                color: MainColors.lightInk,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class QuickAction extends StatefulWidget {
  final Color backgroundColor;
  final IconData icon;
  final String text;

  const QuickAction({
    required this.backgroundColor,
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  State<QuickAction> createState() => _QuickActionState();
}

class _QuickActionState extends State<QuickAction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Handle tap event
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: widget.backgroundColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              widget.icon,
              size: 32,
              color: const Color.fromARGB(185, 255, 255, 255),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.text,
          style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 12,
            color: MainColors.lightInk,
          ),
        ),
      ],
    );
  }
}

class QuickActionsSection extends StatelessWidget {
  final List<Widget> children;

  const QuickActionsSection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }
}

class InformationCenter extends StatefulWidget {
  final Color backgroundColor;
  final IconData icon;
  final String title;
  final String value;
  final String comment;

  const InformationCenter({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.title,
    required this.value,
    required this.comment,
  });

  @override
  State<InformationCenter> createState() => _InformationCenterState();
}

class _InformationCenterState extends State<InformationCenter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          // Handle tap event
        },
        child: Container(
          width: double.infinity,
          height: 80,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.backgroundColor.withValues(alpha: 0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 32,
                color: const Color.fromARGB(185, 255, 255, 255),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.value,
                      style: TextStyle(
                        fontFamily: 'Cormorant Garamond',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.comment,
                      style: TextStyle(
                        fontFamily: 'Cormorant Garamond',
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 24,
                color: const Color.fromARGB(185, 255, 255, 255),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LastMemories extends StatefulWidget {
  final IconData icon;
  final String title;
  final DateTime date;
  final String tag;
  final String paidMoney;

  const LastMemories({
    super.key,
    required this.icon,
    required this.title,
    required this.date,
    required this.tag,
    required this.paidMoney,
  });

  @override
  State<LastMemories> createState() => _LastMemoriesState();
}

class _LastMemoriesState extends State<LastMemories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(86, 255, 255, 255).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            widget.icon,
            size: 20,
            color: const Color.fromARGB(185, 255, 255, 255),
          ),
          SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.date,
                    style: TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 10,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    widget.tag,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
                // Hier muss noch der Preis/Value eingetragen werden
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LastMemoriesSection extends StatelessWidget {
  final List<Widget> children;
  const LastMemoriesSection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Letze Erlebnisse',
          style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 18,
            color: Color.fromARGB(185, 255, 255, 255),
          ),
        ),
        const SizedBox(height: 8),
        for (var child in children) ...[
          child,
          const SizedBox(height: 4),
        ], // max 3 children pls
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(),
                SizedBox(height: 32),
                InteractiveCardStack(
                  cards: [
                    Card(
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
                    Card(
                      backgroundColor: MainColors.brown,
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
                    Card(
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
                QuickActionsSection(
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
            ),
          ),
        ),
      ),
    );
  }
}
